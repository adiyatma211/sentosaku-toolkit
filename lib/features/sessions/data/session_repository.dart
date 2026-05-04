import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/logging/app_logger.dart';
import '../../../core/reminders/invoice_reminder_service.dart';

class SessionDetail {
  const SessionDetail({
    required this.session,
    required this.student,
    required this.subject,
    required this.schedule,
    this.assessment,
    this.invoice,
  });

  final Session session;
  final Student student;
  final Subject subject;
  final Schedule schedule;
  final Assessment? assessment;
  final Invoice? invoice;
}

typedef SessionListItem = SessionDetail;

class SessionAssessmentFormData {
  const SessionAssessmentFormData({
    this.pemahamanMateri,
    this.keaktifanTanyaJawab,
    this.ketepatanKerapianTugas,
    this.konsistensiKehadiranFokus,
    this.targetMateriDrilling,
    this.sikapBelajarRespon,
    this.summaryNote,
  });

  final String? pemahamanMateri;
  final String? keaktifanTanyaJawab;
  final String? ketepatanKerapianTugas;
  final String? konsistensiKehadiranFokus;
  final String? targetMateriDrilling;
  final String? sikapBelajarRespon;
  final String? summaryNote;

  bool get hasContent =>
      _hasText(pemahamanMateri) ||
      _hasText(keaktifanTanyaJawab) ||
      _hasText(ketepatanKerapianTugas) ||
      _hasText(konsistensiKehadiranFokus) ||
      _hasText(targetMateriDrilling) ||
      _hasText(sikapBelajarRespon) ||
      _hasText(summaryNote);

  static bool _hasText(String? value) =>
      value != null && value.trim().isNotEmpty;
}

class StudentAttendanceRecapFilter {
  const StudentAttendanceRecapFilter({
    required this.startDate,
    required this.endDate,
    this.studentId,
    this.academicPeriodId,
  });

  final DateTime startDate;
  final DateTime endDate;
  final int? studentId;
  final int? academicPeriodId;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is StudentAttendanceRecapFilter &&
            other.startDate == startDate &&
            other.endDate == endDate &&
            other.studentId == studentId &&
            other.academicPeriodId == academicPeriodId;
  }

  @override
  int get hashCode =>
      Object.hash(startDate, endDate, studentId, academicPeriodId);
}

class StudentAttendanceRecapItem {
  const StudentAttendanceRecapItem({
    required this.studentId,
    required this.studentName,
    required this.presentCount,
    required this.permissionCount,
    required this.absentCount,
    required this.cancelledCount,
    required this.rescheduledCount,
  });

  final int studentId;
  final String studentName;
  final int presentCount;
  final int permissionCount;
  final int absentCount;
  final int cancelledCount;
  final int rescheduledCount;

  int get totalCount =>
      presentCount +
      permissionCount +
      absentCount +
      cancelledCount +
      rescheduledCount;
}

class SessionFormData {
  const SessionFormData({
    required this.scheduleId,
    required this.attendanceStatus,
    required this.feeAmount,
    this.material,
    this.homework,
    this.progressNote,
    this.assessment,
  });

  final int scheduleId;
  final String attendanceStatus;
  final int feeAmount;
  final String? material;
  final String? homework;
  final String? progressNote;
  final SessionAssessmentFormData? assessment;
}

class SessionRepository {
  const SessionRepository(
    this._database,
    this._logger, {
    InvoiceReminderService? invoiceReminderService,
  }) : _invoiceReminderService = invoiceReminderService;

  final AppDatabase _database;
  final AppLogger _logger;
  final InvoiceReminderService? _invoiceReminderService;

  Stream<List<SessionListItem>> watchSessions() {
    final query = _joinedSessionQuery()
      ..orderBy([
        OrderingTerm.desc(_database.sessions.sessionDate),
        OrderingTerm.desc(_database.sessions.startTime),
      ]);
    return query.watch().map(_mapRows);
  }

  Stream<List<SessionListItem>> watchStudentSessions(int studentId) {
    final query = _joinedSessionQuery()
      ..where(_database.sessions.studentId.equals(studentId))
      ..orderBy([
        OrderingTerm.desc(_database.sessions.sessionDate),
        OrderingTerm.desc(_database.sessions.startTime),
      ]);
    return query.watch().map(_mapRows);
  }

  Stream<SessionDetail?> watchSessionById(int id) {
    final query = _joinedSessionQuery()
      ..where(_database.sessions.id.equals(id));
    return query.watchSingleOrNull().map(_mapRowOrNull);
  }

  Stream<List<StudentAttendanceRecapItem>> watchStudentAttendanceRecap(
    StudentAttendanceRecapFilter filter,
  ) {
    final query =
        (_database.select(_database.sessions).join([
            innerJoin(
              _database.students,
              _database.students.id.equalsExp(_database.sessions.studentId),
            ),
          ]))
          ..where(
            _database.sessions.sessionDate.isBiggerOrEqualValue(
              filter.startDate,
            ),
          )
          ..where(
            _database.sessions.sessionDate.isSmallerThanValue(filter.endDate),
          )
          ..where(_database.sessions.isAttendanceSource.equals(true))
          ..where(_database.sessions.deletedAt.isNull())
          ..where(_database.students.deletedAt.isNull());

    if (filter.studentId != null) {
      query.where(_database.sessions.studentId.equals(filter.studentId!));
    }
    if (filter.academicPeriodId != null) {
      query.where(
        _database.sessions.academicPeriodId.equals(filter.academicPeriodId!),
      );
    }

    return query.watch().map(_mapAttendanceRecapRows);
  }

  Future<int> createSessionFromSchedule(SessionFormData data) async {
    const action = 'sessions.createSessionFromSchedule';
    final logData = {
      'scheduleId': data.scheduleId,
      'attendanceStatus': data.attendanceStatus,
      'feeAmount': data.feeAmount,
    };
    _logger.logTransactionStart(action, logData);
    try {
      _validate(data);

      int? createdInvoiceId;
      final sessionId = await _database.transaction(() async {
        final schedule =
            await (_database.select(_database.schedules)
                  ..where((schedule) => schedule.id.equals(data.scheduleId))
                  ..where((schedule) => schedule.deletedAt.isNull()))
                .getSingleOrNull();
        if (schedule == null) {
          throw StateError('Jadwal tidak ditemukan.');
        }

        final duplicate =
            await (_database.select(_database.sessions)
                  ..where(
                    (session) => session.scheduleId.equals(data.scheduleId),
                  )
                  ..where((session) => session.deletedAt.isNull()))
                .getSingleOrNull();
        if (duplicate != null) {
          throw StateError('Jadwal ini sudah memiliki sesi.');
        }

        final student =
            await (_database.select(_database.students)
                  ..where((student) => student.id.equals(schedule.studentId))
                  ..where((student) => student.deletedAt.isNull()))
                .getSingleOrNull();
        if (student == null) {
          throw StateError('Siswa jadwal tidak ditemukan.');
        }

        final subject =
            await (_database.select(_database.subjects)
                  ..where((subject) => subject.id.equals(schedule.subjectId)))
                .getSingleOrNull();
        if (subject == null) {
          throw StateError('Mata pelajaran jadwal tidak ditemukan.');
        }

        final academicPeriodId =
            schedule.academicPeriodId ??
            await _resolveStudentAcademicPeriodId(student.id, schedule.date) ??
            student.defaultAcademicPeriodId;
        final academicPeriod = academicPeriodId == null
            ? null
            : await (_database.select(_database.academicPeriods)
                    ..where((period) => period.id.equals(academicPeriodId))
                    ..where((period) => period.deletedAt.isNull()))
                  .getSingleOrNull();

        final now = DateTime.now();
        final sessionId = await _database
            .into(_database.sessions)
            .insert(
              SessionsCompanion.insert(
                scheduleId: Value(schedule.id),
                studentId: schedule.studentId,
                subjectId: schedule.subjectId,
                academicPeriodId: Value(academicPeriodId),
                sessionDate: Value(schedule.date),
                startTime: Value(schedule.startTime),
                endTime: Value(schedule.endTime),
                attendanceStatus: Value(data.attendanceStatus),
                material: Value(_blankToNull(data.material)),
                homework: Value(_blankToNull(data.homework)),
                note: Value(_blankToNull(data.progressNote)),
                progressNote: Value(_blankToNull(data.progressNote)),
                feeAmount: Value(data.feeAmount),
                isAttendanceSource: const Value(true),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );

        final assessment = data.assessment;
        if (assessment != null && assessment.hasContent) {
          await _database
              .into(_database.assessments)
              .insert(
                AssessmentsCompanion.insert(
                  sessionId: Value(sessionId),
                  studentId: student.id,
                  academicPeriodId: Value(academicPeriodId),
                  assessmentType: const Value(AssessmentType.session),
                  pemahamanMateri: Value(
                    _blankToNull(assessment.pemahamanMateri),
                  ),
                  keaktifanTanyaJawab: Value(
                    _blankToNull(assessment.keaktifanTanyaJawab),
                  ),
                  ketepatanKerapianTugas: Value(
                    _blankToNull(assessment.ketepatanKerapianTugas),
                  ),
                  konsistensiKehadiranFokus: Value(
                    _blankToNull(assessment.konsistensiKehadiranFokus),
                  ),
                  targetMateriDrilling: Value(
                    _blankToNull(assessment.targetMateriDrilling),
                  ),
                  sikapBelajarRespon: Value(
                    _blankToNull(assessment.sikapBelajarRespon),
                  ),
                  summaryNote: Value(_blankToNull(assessment.summaryNote)),
                  createdAt: Value(now),
                  updatedAt: Value(now),
                ),
              );
        }

        await (_database.update(
          _database.schedules,
        )..where((schedule) => schedule.id.equals(data.scheduleId))).write(
          SchedulesCompanion(
            status: Value(_scheduleStatusForAttendance(data.attendanceStatus)),
            updatedAt: Value(now),
          ),
        );

        final shouldCreateInvoice =
            data.attendanceStatus == AttendanceStatus.present &&
            student.rateType == RateType.perSession &&
            data.feeAmount > 0;
        if (shouldCreateInvoice) {
          final invoiceId = await _database
              .into(_database.invoices)
              .insert(
                InvoicesCompanion.insert(
                  studentId: student.id,
                  sessionId: Value(sessionId),
                  academicPeriodId: Value(academicPeriodId),
                  periodLabel: Value(
                    academicPeriod?.name ?? _periodLabel(schedule.date),
                  ),
                  amount: Value(data.feeAmount),
                  dueDate: Value(_defaultInvoiceDueDate(schedule.date)),
                  status: const Value(InvoiceStatus.unpaid),
                  createdAt: Value(now),
                  updatedAt: Value(now),
                ),
              );
          createdInvoiceId = invoiceId;
          await (_database.update(
            _database.sessions,
          )..where((session) => session.id.equals(sessionId))).write(
            SessionsCompanion(
              invoiceId: Value(invoiceId),
              updatedAt: Value(now),
            ),
          );
        }

        return sessionId;
      });
      if (createdInvoiceId != null) {
        await _invoiceReminderService?.syncInvoiceReminderById(
          createdInvoiceId!,
        );
      }
      _logger.logTransactionSuccess(action, {
        ...logData,
        'sessionId': sessionId,
      });
      return sessionId;
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  JoinedSelectStatement<HasResultSet, dynamic> _joinedSessionQuery() {
    return (_database.select(_database.sessions).join([
        innerJoin(
          _database.students,
          _database.students.id.equalsExp(_database.sessions.studentId),
        ),
        innerJoin(
          _database.subjects,
          _database.subjects.id.equalsExp(_database.sessions.subjectId),
        ),
        innerJoin(
          _database.schedules,
          _database.schedules.id.equalsExp(_database.sessions.scheduleId),
        ),
        leftOuterJoin(
          _database.assessments,
          _database.assessments.sessionId.equalsExp(_database.sessions.id) &
              _database.assessments.assessmentType.equals(
                AssessmentType.session,
              ) &
              _database.assessments.deletedAt.isNull(),
        ),
        leftOuterJoin(
          _database.invoices,
          _database.invoices.id.equalsExp(_database.sessions.invoiceId),
        ),
      ]))
      ..where(_database.sessions.deletedAt.isNull())
      ..where(_database.students.deletedAt.isNull())
      ..where(_database.schedules.deletedAt.isNull());
  }

  List<SessionListItem> _mapRows(List<TypedResult> rows) {
    return rows.map(_mapRow).toList(growable: false);
  }

  List<StudentAttendanceRecapItem> _mapAttendanceRecapRows(
    List<TypedResult> rows,
  ) {
    final buckets = <int, _AttendanceRecapAccumulator>{};
    for (final row in rows) {
      final session = row.readTable(_database.sessions);
      final student = row.readTable(_database.students);
      final bucket = buckets.putIfAbsent(
        student.id,
        () => _AttendanceRecapAccumulator(student.id, student.name),
      );
      bucket.add(session.attendanceStatus);
    }

    final items = buckets.values.map((bucket) => bucket.build()).toList();
    items.sort((a, b) => a.studentName.compareTo(b.studentName));
    return items;
  }

  SessionDetail? _mapRowOrNull(TypedResult? row) {
    return row == null ? null : _mapRow(row);
  }

  SessionDetail _mapRow(TypedResult row) {
    return SessionDetail(
      session: row.readTable(_database.sessions),
      student: row.readTable(_database.students),
      subject: row.readTable(_database.subjects),
      schedule: row.readTable(_database.schedules),
      assessment: row.readTableOrNull(_database.assessments),
      invoice: row.readTableOrNull(_database.invoices),
    );
  }

  void _validate(SessionFormData data) {
    if (data.feeAmount < 0) {
      throw ArgumentError.value(
        data.feeAmount,
        'feeAmount',
        'Biaya tidak valid',
      );
    }
    const allowedStatuses = {
      AttendanceStatus.present,
      AttendanceStatus.permission,
      AttendanceStatus.absent,
      AttendanceStatus.cancelled,
      AttendanceStatus.rescheduled,
    };
    if (!allowedStatuses.contains(data.attendanceStatus)) {
      throw ArgumentError.value(
        data.attendanceStatus,
        'attendanceStatus',
        'Status absensi tidak valid',
      );
    }
  }

  String _scheduleStatusForAttendance(String attendanceStatus) {
    return switch (attendanceStatus) {
      AttendanceStatus.present => ScheduleStatus.done,
      AttendanceStatus.permission => ScheduleStatus.done,
      AttendanceStatus.absent => ScheduleStatus.noShow,
      AttendanceStatus.cancelled => ScheduleStatus.cancelled,
      AttendanceStatus.rescheduled => ScheduleStatus.rescheduled,
      _ => ScheduleStatus.done,
    };
  }

  String _periodLabel(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    return 'Sesi ${date.year}-$month';
  }

  DateTime _defaultInvoiceDueDate(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    return normalized.add(const Duration(days: 7));
  }

  String? _blankToNull(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  Future<int?> _resolveStudentAcademicPeriodId(
    int studentId,
    DateTime referenceDate,
  ) async {
    final date = DateTime(
      referenceDate.year,
      referenceDate.month,
      referenceDate.day,
    );
    final assignments =
        await (_database.select(_database.studentPeriods).join([
                innerJoin(
                  _database.academicPeriods,
                  _database.academicPeriods.id.equalsExp(
                    _database.studentPeriods.academicPeriodId,
                  ),
                ),
              ])
              ..where(_database.studentPeriods.studentId.equals(studentId))
              ..where(
                _database.studentPeriods.status.equals(
                  StudentPeriodStatus.active,
                ),
              )
              ..where(_database.studentPeriods.deletedAt.isNull())
              ..where(_database.academicPeriods.deletedAt.isNull())
              ..orderBy([
                OrderingTerm.desc(_database.academicPeriods.isActive),
                OrderingTerm.desc(_database.academicPeriods.startDate),
              ]))
            .get();

    for (final row in assignments) {
      final period = row.readTable(_database.academicPeriods);
      final start = DateTime(
        period.startDate.year,
        period.startDate.month,
        period.startDate.day,
      );
      final end = DateTime(
        period.endDate.year,
        period.endDate.month,
        period.endDate.day,
      );
      if (!date.isBefore(start) && !date.isAfter(end)) {
        return period.id;
      }
    }
    return assignments.isEmpty
        ? null
        : assignments.first.readTable(_database.academicPeriods).id;
  }
}

class _AttendanceRecapAccumulator {
  _AttendanceRecapAccumulator(this.studentId, this.studentName);

  final int studentId;
  final String studentName;
  int presentCount = 0;
  int permissionCount = 0;
  int absentCount = 0;
  int cancelledCount = 0;
  int rescheduledCount = 0;

  void add(String status) {
    switch (status) {
      case AttendanceStatus.present:
        presentCount++;
        break;
      case AttendanceStatus.permission:
        permissionCount++;
        break;
      case AttendanceStatus.absent:
        absentCount++;
        break;
      case AttendanceStatus.cancelled:
        cancelledCount++;
        break;
      case AttendanceStatus.rescheduled:
        rescheduledCount++;
        break;
    }
  }

  StudentAttendanceRecapItem build() {
    return StudentAttendanceRecapItem(
      studentId: studentId,
      studentName: studentName,
      presentCount: presentCount,
      permissionCount: permissionCount,
      absentCount: absentCount,
      cancelledCount: cancelledCount,
      rescheduledCount: rescheduledCount,
    );
  }
}
