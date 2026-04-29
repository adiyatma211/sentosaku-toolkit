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
          ..where(
            _database.payments.paidAt.isBiggerOrEqualValue(filter.startDate),
          )
          ..where(_database.payments.paidAt.isSmallerThanValue(filter.endDate))
          ..where(_database.payments.deletedAt.isNull())
          ..where(_database.invoices.deletedAt.isNull())
          ..where(_database.students.deletedAt.isNull())
          ..orderBy([
            OrderingTerm.desc(_database.payments.paidAt),
            OrderingTerm.desc(_database.payments.id),
          ]);

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

  Future<UnpaidReport> getUnpaidReport() async {
    final query =
        (_database.select(_database.invoices).join([
            innerJoin(
              _database.students,
              _database.students.id.equalsExp(_database.invoices.studentId),
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
          );
        })
        .where((row) {
          return row.totalSessions > 0 ||
              row.totalInvoiceAmount > 0 ||
              row.totalPaidAmount > 0 ||
              row.outstandingAmount > 0;
        })
        .toList(growable: false);

    return StudentReport(rows: rows);
  }

  Future<ExportReportData> getExportData(ReportFilter filter) async {
    final income = await getIncomeReport(filter);
    final unpaid = await getUnpaidReport();
    final studentReport = await getStudentReport(filter);

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
      ['Per Siswa', 'Siswa', 'Sesi', 'Outstanding'],
      ...studentReport.rows.map(
        (row) => [
          'Per Siswa',
          row.studentName,
          row.totalSessions.toString(),
          row.outstandingAmount.toString(),
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
      ReportFilterType.custom =>
        'Custom (${_dateLabel(filter.startDate)} - ${_dateLabel(filter.endDate.subtract(const Duration(days: 1)))})',
    };
  }

  Future<Map<int, int>> _sessionCountsByStudent(ReportFilter filter) async {
    final query = _database.select(_database.sessions)
      ..where(
        (session) => session.sessionDate.isBiggerOrEqualValue(filter.startDate),
      )
      ..where(
        (session) => session.sessionDate.isSmallerThanValue(filter.endDate),
      )
      ..where(
        (session) => session.attendanceStatus.equals(AttendanceStatus.present),
      )
      ..where((session) => session.deletedAt.isNull());
    if (filter.studentId != null) {
      query.where((session) => session.studentId.equals(filter.studentId!));
    }
    if (filter.subjectId != null) {
      query.where((session) => session.subjectId.equals(filter.subjectId!));
    }

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
      ..where(
        (invoice) => invoice.createdAt.isBiggerOrEqualValue(filter.startDate),
      )
      ..where((invoice) => invoice.createdAt.isSmallerThanValue(filter.endDate))
      ..where((invoice) => invoice.status.equals(InvoiceStatus.cancelled).not())
      ..where((invoice) => invoice.deletedAt.isNull());
    if (filter.studentId != null) {
      query.where((invoice) => invoice.studentId.equals(filter.studentId!));
    }

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
            _database.invoices.createdAt.isBiggerOrEqualValue(filter.startDate),
          )
          ..where(
            _database.invoices.createdAt.isSmallerThanValue(filter.endDate),
          )
          ..where(
            _database.invoices.status.equals(InvoiceStatus.cancelled).not(),
          )
          ..where(_database.invoices.deletedAt.isNull())
          ..where(_database.sessions.subjectId.equals(filter.subjectId!))
          ..where(_database.sessions.deletedAt.isNull());
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
          ..where(
            _database.payments.paidAt.isBiggerOrEqualValue(filter.startDate),
          )
          ..where(_database.payments.paidAt.isSmallerThanValue(filter.endDate))
          ..where(_database.payments.deletedAt.isNull())
          ..where(_database.invoices.deletedAt.isNull());
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

  int _positive(int value) => value < 0 ? 0 : value;

  String _dateLabel(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}
