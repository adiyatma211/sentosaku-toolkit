import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import 'report_models.dart';

class ReportRepository {
  const ReportRepository(this._database);

  final AppDatabase _database;

  Future<IncomeReport> getIncomeReport(ReportFilter filter) async {
    final query =
        (_database.select(_database.payments).join([
            innerJoin(
              _database.invoices,
              _database.invoices.id.equalsExp(_database.payments.invoiceId),
            ),
            innerJoin(
              _database.students,
              _database.students.id.equalsExp(_database.invoices.studentId),
            ),
            leftOuterJoin(
              _database.sessions,
              _database.sessions.id.equalsExp(_database.invoices.sessionId),
            ),
          ]))
          ..where(_database.payments.deletedAt.isNull())
          ..where(_database.invoices.deletedAt.isNull())
          ..where(_database.students.deletedAt.isNull())
          ..orderBy([
            OrderingTerm.desc(_database.payments.paidAt),
            OrderingTerm.desc(_database.payments.id),
          ]);

    _applyPaymentFilter(query, filter);

    if (filter.studentId != null) {
      query.where(_database.invoices.studentId.equals(filter.studentId!));
    }
    if (filter.subjectId != null) {
      query.where(_database.sessions.subjectId.equals(filter.subjectId!));
    }

    final rows = await query.get();
    final reportRows = rows
        .map((row) {
          final payment = row.readTable(_database.payments);
          final invoice = row.readTable(_database.invoices);
          final student = row.readTable(_database.students);
          return IncomeReportRow(
            paymentId: payment.id,
            invoiceId: invoice.id,
            studentName: student.name,
            amount: payment.amount,
            paidAt: payment.paidAt,
            method: payment.method,
            invoiceStatus: invoice.status,
            periodLabel: invoice.periodLabel.isEmpty
                ? null
                : invoice.periodLabel,
          );
        })
        .toList(growable: false);

    return IncomeReport(
      totalIncome: reportRows.fold(0, (total, row) => total + row.amount),
      totalPayments: reportRows.length,
      rows: reportRows,
    );
  }

  Future<UnpaidReport> getUnpaidReport([ReportFilter? filter]) async {
    final query =
        (_database.select(_database.invoices).join([
            innerJoin(
              _database.students,
              _database.students.id.equalsExp(_database.invoices.studentId),
            ),
            leftOuterJoin(
              _database.sessions,
              _database.sessions.id.equalsExp(_database.invoices.sessionId),
            ),
          ]))
          ..where(
            _database.invoices.status.isIn([
              InvoiceStatus.unpaid,
              InvoiceStatus.partial,
            ]),
          )
          ..where(
            _database.invoices.amount.isBiggerThan(
              _database.invoices.paidAmount,
            ),
          )
          ..where(_database.invoices.deletedAt.isNull())
          ..where(_database.students.deletedAt.isNull())
          ..orderBy([
            OrderingTerm.asc(_database.invoices.dueDate),
            OrderingTerm.desc(_database.invoices.createdAt),
          ]);

    if (filter != null) {
      if (filter.studentId != null) {
        query.where(_database.invoices.studentId.equals(filter.studentId!));
      }
      if (filter.subjectId != null) {
        query.where(_database.sessions.subjectId.equals(filter.subjectId!));
      }
      if (filter.academicPeriodId != null) {
        query.where(
          _database.invoices.academicPeriodId.equals(
                filter.academicPeriodId!,
              ) |
              _database.sessions.academicPeriodId.equals(
                filter.academicPeriodId!,
              ),
        );
      }
    }

    final rows = await query.get();
    final reportRows = rows
        .map((row) {
          final invoice = row.readTable(_database.invoices);
          final student = row.readTable(_database.students);
          final remaining = invoice.amount - invoice.paidAmount;
          return UnpaidReportRow(
            invoiceId: invoice.id,
            studentName: student.name,
            whatsapp: student.whatsapp,
            amount: invoice.amount,
            paidAmount: invoice.paidAmount,
            remaining: remaining,
            status: invoice.status,
            dueDate: invoice.dueDate,
            periodLabel: invoice.periodLabel.isEmpty
                ? null
                : invoice.periodLabel,
          );
        })
        .toList(growable: false);

    return UnpaidReport(
      totalOutstanding: reportRows.fold(
        0,
        (total, row) => total + row.remaining,
      ),
      invoiceCount: reportRows.length,
      rows: reportRows,
    );
  }

  Future<StudentReport> getStudentReport(ReportFilter filter) async {
    final students =
        await (_database.select(_database.students)
              ..where((student) => student.deletedAt.isNull())
              ..where(
                (student) => filter.studentId == null
                    ? const Constant(true)
                    : student.id.equals(filter.studentId!),
              )
              ..orderBy([(student) => OrderingTerm.asc(student.name)]))
            .get();

    final sessionCounts = await _sessionCountsByStudent(filter);
    final invoiceTotals = await _invoiceTotalsByStudent(filter);
    final paymentTotals = await _paymentTotalsByStudent(filter);
    final assessmentCounts = await _assessmentCountsByStudent(filter);
    final progressNotes = await _latestProgressNotesByStudent(filter);

    final rows = students
        .map((student) {
          final totalInvoiceAmount = invoiceTotals[student.id] ?? 0;
          final totalPaidAmount = paymentTotals[student.id] ?? 0;
          return StudentReportRow(
            studentId: student.id,
            studentName: student.name,
            whatsapp: student.whatsapp,
            totalSessions: sessionCounts[student.id] ?? 0,
            totalInvoiceAmount: totalInvoiceAmount,
            totalPaidAmount: totalPaidAmount,
            outstandingAmount: _positive(totalInvoiceAmount - totalPaidAmount),
            assessmentCount: assessmentCounts[student.id] ?? 0,
            latestProgressNote: progressNotes[student.id],
          );
        })
        .where((row) {
          return row.totalSessions > 0 ||
              row.totalInvoiceAmount > 0 ||
              row.totalPaidAmount > 0 ||
              row.outstandingAmount > 0 ||
              row.assessmentCount > 0;
        })
        .toList(growable: false);

    return StudentReport(rows: rows);
  }

  Future<AttendanceReport> getAttendanceReport(ReportFilter filter) async {
    final query =
        (_database.select(_database.sessions).join([
            innerJoin(
              _database.students,
              _database.students.id.equalsExp(_database.sessions.studentId),
            ),
          ]))
          ..where(_database.sessions.isAttendanceSource.equals(true))
          ..where(_database.sessions.deletedAt.isNull())
          ..where(_database.students.deletedAt.isNull())
          ..orderBy([OrderingTerm.asc(_database.students.name)]);

    _applySessionFilter(query, filter);

    final rows = await query.get();
    final byStudent = <int, _AttendanceAccumulator>{};
    for (final row in rows) {
      final session = row.readTable(_database.sessions);
      final student = row.readTable(_database.students);
      final accumulator = byStudent.putIfAbsent(
        student.id,
        () => _AttendanceAccumulator(
          studentId: student.id,
          studentName: student.name,
          whatsapp: student.whatsapp,
        ),
      );
      accumulator.add(session.attendanceStatus);
    }

    return AttendanceReport(
      rows: byStudent.values.map((row) => row.toRow()).toList(growable: false),
    );
  }

  Future<ExportReportData> getExportData(ReportFilter filter) async {
    final income = await getIncomeReport(filter);
    final unpaid = await getUnpaidReport(filter);
    final studentReport = await getStudentReport(filter);
    final attendance = filter.includeAttendanceRecap
        ? await getAttendanceReport(filter)
        : const AttendanceReport(rows: []);

    final rows = <List<String>>[
      ['Ringkasan', 'Total pendapatan', income.totalIncome.toString(), ''],
      ['Ringkasan', 'Jumlah pembayaran', income.totalPayments.toString(), ''],
      [
        'Ringkasan',
        'Total outstanding',
        unpaid.totalOutstanding.toString(),
        '',
      ],
      ['Ringkasan', 'Invoice belum lunas', unpaid.invoiceCount.toString(), ''],
      ['Ringkasan', 'Sesi selesai', studentReport.totalSessions.toString(), ''],
      [
        'Ringkasan',
        'Total kehadiran tercatat',
        attendance.totalSessions.toString(),
        '',
      ],
      ['Pendapatan', 'Siswa', 'Nominal', 'Tanggal'],
      ...income.rows.map(
        (row) => [
          'Pendapatan',
          row.studentName,
          row.amount.toString(),
          _dateLabel(row.paidAt),
        ],
      ),
      ['Tagihan', 'Siswa', 'Sisa tagihan', 'Status'],
      ...unpaid.rows.map(
        (row) => [
          'Tagihan',
          row.studentName,
          row.remaining.toString(),
          row.status,
        ],
      ),
      ['Kehadiran', 'Siswa', 'Total', 'H/I/A/B/R'],
      ...attendance.rows.map(
        (row) => [
          'Kehadiran',
          row.studentName,
          row.total.toString(),
          '${row.present}/${row.permission}/${row.absent}/${row.cancelled}/${row.rescheduled}',
        ],
      ),
      ['Per Siswa', 'Siswa', 'Sesi', 'Outstanding'],
      ...studentReport.rows.map(
        (row) => [
          'Per Siswa',
          row.studentName,
          row.totalSessions.toString(),
          '${row.outstandingAmount}; assessment ${row.assessmentCount}; progress ${row.latestProgressNote ?? '-'}',
        ],
      ),
    ];

    return ExportReportData(
      title: 'Laporan Sentosa Catat',
      generatedAt: DateTime.now(),
      filterLabel: filterLabel(filter),
      columns: const ['Bagian', 'Nama', 'Nilai', 'Keterangan'],
      rows: rows,
    );
  }

  String filterLabel(ReportFilter filter) {
    return switch (filter.filterType) {
      ReportFilterType.today => 'Hari ini (${_dateLabel(filter.startDate)})',
      ReportFilterType.week =>
        'Minggu ini (${_dateLabel(filter.startDate)} - ${_dateLabel(filter.endDate.subtract(const Duration(days: 1)))})',
      ReportFilterType.month =>
        'Bulan ini (${_dateLabel(filter.startDate)} - ${_dateLabel(filter.endDate.subtract(const Duration(days: 1)))})',
      ReportFilterType.academicPeriod =>
        'Periode akademik (${filter.academicPeriodName ?? 'ID ${filter.academicPeriodId}'})',
      ReportFilterType.custom =>
        'Custom (${_dateLabel(filter.startDate)} - ${_dateLabel(filter.endDate.subtract(const Duration(days: 1)))})',
    };
  }

  Future<Map<int, int>> _sessionCountsByStudent(ReportFilter filter) async {
    final query = _database.select(_database.sessions)
      ..where(
        (session) => session.attendanceStatus.equals(AttendanceStatus.present),
      )
      ..where((session) => session.deletedAt.isNull());
    _applySessionSelectFilter(query, filter);

    final rows = await query.get();
    final result = <int, int>{};
    for (final session in rows) {
      result.update(session.studentId, (value) => value + 1, ifAbsent: () => 1);
    }
    return result;
  }

  Future<Map<int, int>> _invoiceTotalsByStudent(ReportFilter filter) async {
    if (filter.subjectId != null) {
      return _invoiceTotalsByStudentAndSubject(filter);
    }

    final query = _database.select(_database.invoices)
      ..where((invoice) => invoice.status.equals(InvoiceStatus.cancelled).not())
      ..where((invoice) => invoice.deletedAt.isNull());
    _applyInvoiceSelectFilter(query, filter);

    final rows = await query.get();
    final result = <int, int>{};
    for (final invoice in rows) {
      result.update(
        invoice.studentId,
        (value) => value + invoice.amount,
        ifAbsent: () => invoice.amount,
      );
    }
    return result;
  }

  Future<Map<int, int>> _invoiceTotalsByStudentAndSubject(
    ReportFilter filter,
  ) async {
    final query =
        (_database.select(_database.invoices).join([
            innerJoin(
              _database.sessions,
              _database.sessions.id.equalsExp(_database.invoices.sessionId),
            ),
          ]))
          ..where(
            _database.invoices.status.equals(InvoiceStatus.cancelled).not(),
          )
          ..where(_database.invoices.deletedAt.isNull())
          ..where(_database.sessions.subjectId.equals(filter.subjectId!))
          ..where(_database.sessions.deletedAt.isNull());
    _applyInvoiceJoinFilter(query, filter);
    if (filter.studentId != null) {
      query.where(_database.invoices.studentId.equals(filter.studentId!));
    }

    final rows = await query.get();
    final result = <int, int>{};
    for (final row in rows) {
      final invoice = row.readTable(_database.invoices);
      result.update(
        invoice.studentId,
        (value) => value + invoice.amount,
        ifAbsent: () => invoice.amount,
      );
    }
    return result;
  }

  Future<Map<int, int>> _paymentTotalsByStudent(ReportFilter filter) async {
    final query =
        (_database.select(_database.payments).join([
            innerJoin(
              _database.invoices,
              _database.invoices.id.equalsExp(_database.payments.invoiceId),
            ),
            leftOuterJoin(
              _database.sessions,
              _database.sessions.id.equalsExp(_database.invoices.sessionId),
            ),
          ]))
          ..where(_database.payments.deletedAt.isNull())
          ..where(_database.invoices.deletedAt.isNull());
    _applyPaymentFilter(query, filter);
    if (filter.studentId != null) {
      query.where(_database.invoices.studentId.equals(filter.studentId!));
    }
    if (filter.subjectId != null) {
      query.where(_database.sessions.subjectId.equals(filter.subjectId!));
    }

    final rows = await query.get();
    final result = <int, int>{};
    for (final row in rows) {
      final payment = row.readTable(_database.payments);
      final invoice = row.readTable(_database.invoices);
      result.update(
        invoice.studentId,
        (value) => value + payment.amount,
        ifAbsent: () => payment.amount,
      );
    }
    return result;
  }

  Future<Map<int, int>> _assessmentCountsByStudent(ReportFilter filter) async {
    final query = _database.select(_database.assessments)
      ..where((assessment) => assessment.deletedAt.isNull());
    if (filter.academicPeriodId != null) {
      query.where(
        (assessment) =>
            assessment.academicPeriodId.equals(filter.academicPeriodId!),
      );
    } else {
      query
        ..where(
          (assessment) =>
              assessment.createdAt.isBiggerOrEqualValue(filter.startDate),
        )
        ..where(
          (assessment) => assessment.createdAt.isSmallerThanValue(filter.endDate),
        );
    }
    if (filter.studentId != null) {
      query.where((assessment) => assessment.studentId.equals(filter.studentId!));
    }

    final rows = await query.get();
    final result = <int, int>{};
    for (final assessment in rows) {
      result.update(
        assessment.studentId,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }
    return result;
  }

  Future<Map<int, String>> _latestProgressNotesByStudent(
    ReportFilter filter,
  ) async {
    final query = _database.select(_database.sessions)
      ..where((session) => session.progressNote.isNotNull())
      ..where((session) => session.deletedAt.isNull())
      ..orderBy([(session) => OrderingTerm.desc(session.sessionDate)]);
    _applySessionSelectFilter(query, filter);

    final result = <int, String>{};
    for (final session in await query.get()) {
      final note = session.progressNote?.trim();
      if (note == null || note.isEmpty || result.containsKey(session.studentId)) {
        continue;
      }
      result[session.studentId] = note;
    }
    return result;
  }

  void _applyPaymentFilter(
    JoinedSelectStatement<HasResultSet, dynamic> query,
    ReportFilter filter,
  ) {
    if (filter.academicPeriodId != null) {
      query.where(
        _database.invoices.academicPeriodId.equals(filter.academicPeriodId!) |
            _database.sessions.academicPeriodId.equals(filter.academicPeriodId!),
      );
    } else {
      query
        ..where(_database.payments.paidAt.isBiggerOrEqualValue(filter.startDate))
        ..where(_database.payments.paidAt.isSmallerThanValue(filter.endDate));
    }
  }

  void _applySessionFilter(
    JoinedSelectStatement<HasResultSet, dynamic> query,
    ReportFilter filter,
  ) {
    if (filter.academicPeriodId != null) {
      query.where(
        _database.sessions.academicPeriodId.equals(filter.academicPeriodId!),
      );
    } else {
      query
        ..where(
          _database.sessions.sessionDate.isBiggerOrEqualValue(filter.startDate),
        )
        ..where(_database.sessions.sessionDate.isSmallerThanValue(filter.endDate));
    }
    if (filter.studentId != null) {
      query.where(_database.sessions.studentId.equals(filter.studentId!));
    }
    if (filter.subjectId != null) {
      query.where(_database.sessions.subjectId.equals(filter.subjectId!));
    }
  }

  void _applySessionSelectFilter(
    SimpleSelectStatement<$SessionsTable, Session> query,
    ReportFilter filter,
  ) {
    if (filter.academicPeriodId != null) {
      query.where(
        (session) => session.academicPeriodId.equals(filter.academicPeriodId!),
      );
    } else {
      query
        ..where(
          (session) => session.sessionDate.isBiggerOrEqualValue(filter.startDate),
        )
        ..where((session) => session.sessionDate.isSmallerThanValue(filter.endDate));
    }
    if (filter.studentId != null) {
      query.where((session) => session.studentId.equals(filter.studentId!));
    }
    if (filter.subjectId != null) {
      query.where((session) => session.subjectId.equals(filter.subjectId!));
    }
  }

  void _applyInvoiceSelectFilter(
    SimpleSelectStatement<$InvoicesTable, Invoice> query,
    ReportFilter filter,
  ) {
    if (filter.academicPeriodId != null) {
      query.where(
        (invoice) => invoice.academicPeriodId.equals(filter.academicPeriodId!),
      );
    } else {
      query
        ..where(
          (invoice) => invoice.createdAt.isBiggerOrEqualValue(filter.startDate),
        )
        ..where((invoice) => invoice.createdAt.isSmallerThanValue(filter.endDate));
    }
    if (filter.studentId != null) {
      query.where((invoice) => invoice.studentId.equals(filter.studentId!));
    }
  }

  void _applyInvoiceJoinFilter(
    JoinedSelectStatement<HasResultSet, dynamic> query,
    ReportFilter filter,
  ) {
    if (filter.academicPeriodId != null) {
      query.where(
        _database.invoices.academicPeriodId.equals(filter.academicPeriodId!) |
            _database.sessions.academicPeriodId.equals(filter.academicPeriodId!),
      );
    } else {
      query
        ..where(_database.invoices.createdAt.isBiggerOrEqualValue(filter.startDate))
        ..where(_database.invoices.createdAt.isSmallerThanValue(filter.endDate));
    }
  }

  int _positive(int value) => value < 0 ? 0 : value;

  String _dateLabel(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}

class _AttendanceAccumulator {
  _AttendanceAccumulator({
    required this.studentId,
    required this.studentName,
    this.whatsapp,
  });

  final int studentId;
  final String studentName;
  final String? whatsapp;
  int present = 0;
  int permission = 0;
  int absent = 0;
  int cancelled = 0;
  int rescheduled = 0;

  void add(String status) {
    switch (status) {
      case AttendanceStatus.present:
        present++;
      case AttendanceStatus.permission:
        permission++;
      case AttendanceStatus.absent:
        absent++;
      case AttendanceStatus.cancelled:
        cancelled++;
      case AttendanceStatus.rescheduled:
        rescheduled++;
    }
  }

  AttendanceReportRow toRow() {
    return AttendanceReportRow(
      studentId: studentId,
      studentName: studentName,
      whatsapp: whatsapp,
      present: present,
      permission: permission,
      absent: absent,
      cancelled: cancelled,
      rescheduled: rescheduled,
    );
  }
}
