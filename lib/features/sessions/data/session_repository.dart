import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/logging/app_logger.dart';

class SessionDetail {
  const SessionDetail({
    required this.session,
    required this.student,
    required this.subject,
    required this.schedule,
    this.invoice,
  });

  final Session session;
  final Student student;
  final Subject subject;
  final Schedule schedule;
  final Invoice? invoice;
}

typedef SessionListItem = SessionDetail;

class SessionFormData {
  const SessionFormData({
    required this.scheduleId,
    required this.attendanceStatus,
    required this.feeAmount,
    this.material,
    this.homework,
    this.progressNote,
  });

  final int scheduleId;
  final String attendanceStatus;
  final int feeAmount;
  final String? material;
  final String? homework;
  final String? progressNote;
}

class SessionRepository {
  const SessionRepository(this._database, this._logger);

  final AppDatabase _database;
  final AppLogger _logger;

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

        final now = DateTime.now();
        final sessionId = await _database
            .into(_database.sessions)
            .insert(
              SessionsCompanion.insert(
                scheduleId: Value(schedule.id),
                studentId: schedule.studentId,
                subjectId: schedule.subjectId,
                sessionDate: Value(schedule.date),
                startTime: Value(schedule.startTime),
                endTime: Value(schedule.endTime),
                attendanceStatus: Value(data.attendanceStatus),
                material: Value(_blankToNull(data.material)),
                homework: Value(_blankToNull(data.homework)),
                note: Value(_blankToNull(data.progressNote)),
                feeAmount: Value(data.feeAmount),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );

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
                  periodLabel: Value(_periodLabel(schedule.date)),
                  amount: Value(data.feeAmount),
                  status: const Value(InvoiceStatus.unpaid),
                  createdAt: Value(now),
                  updatedAt: Value(now),
                ),
              );
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

  SessionDetail? _mapRowOrNull(TypedResult? row) {
    return row == null ? null : _mapRow(row);
  }

  SessionDetail _mapRow(TypedResult row) {
    return SessionDetail(
      session: row.readTable(_database.sessions),
      student: row.readTable(_database.students),
      subject: row.readTable(_database.subjects),
      schedule: row.readTable(_database.schedules),
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

  String? _blankToNull(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
