import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/logging/app_logger.dart';
import 'local_reminder_service.dart';

class ScheduleDetail {
  const ScheduleDetail({
    required this.schedule,
    required this.student,
    required this.subject,
    required this.academicPeriod,
  });

  final Schedule schedule;
  final Student student;
  final Subject subject;
  final AcademicPeriod? academicPeriod;
}

class ScheduleFormData {
  const ScheduleFormData({
    required this.studentId,
    required this.subjectId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.scheduleType,
    required this.reminderEnabled,
    this.academicPeriodId,
    this.reminderOffsetMinutes = 60,
    this.note,
    this.repeatCount = 1,
  });

  final int studentId;
  final int subjectId;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final String scheduleType;
  final bool reminderEnabled;
  final int? academicPeriodId;
  final int reminderOffsetMinutes;
  final String? note;
  final int repeatCount;
}

class ScheduleRepository {
  const ScheduleRepository(this._database, this._reminderService, this._logger);

  final AppDatabase _database;
  final LocalReminderService _reminderService;
  final AppLogger _logger;

  Stream<List<ScheduleDetail>> watchSchedulesByDate(DateTime date) {
    final (start, end) = _dayRange(date);
    final query = _joinedScheduleQuery()
      ..where(_database.schedules.date.isBiggerOrEqualValue(start))
      ..where(_database.schedules.date.isSmallerThanValue(end))
      ..orderBy([OrderingTerm.asc(_database.schedules.startTime)]);
    return query.watch().map(_mapRows);
  }

  Stream<List<ScheduleDetail>> watchTodaySchedules() {
    return watchSchedulesByDate(DateTime.now());
  }

  Stream<ScheduleDetail?> watchScheduleById(int id) {
    final query = _joinedScheduleQuery()
      ..where(_database.schedules.id.equals(id));
    return query.watchSingleOrNull().map(_mapRowOrNull);
  }

  Future<ScheduleDetail?> getScheduleDetail(int id) async {
    final query = _joinedScheduleQuery()
      ..where(_database.schedules.id.equals(id));
    return _mapRowOrNull(await query.getSingleOrNull());
  }

  Future<int> insertSchedule(ScheduleFormData data) async {
    const action = 'schedules.insertSchedule';
    final logData = _scheduleLogData(data);
    _logger.logTransactionStart(action, logData);
    try {
      _validate(data);
      final id = await _insertScheduleRow(
        data,
        ScheduleType.once,
        null,
        data.date,
      );
      await _tryScheduleReminder(id);
      _logger.logTransactionSuccess(action, {...logData, 'scheduleId': id});
      return id;
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Future<List<int>> insertWeeklySchedules(ScheduleFormData data) async {
    const action = 'schedules.insertWeeklySchedules';
    final logData = _scheduleLogData(data);
    _logger.logTransactionStart(action, logData);
    try {
      _validate(data);
      if (data.repeatCount <= 0) {
        throw ArgumentError.value(
          data.repeatCount,
          'repeatCount',
          'Repeat count harus lebih dari 0',
        );
      }

      final recurrenceGroupId =
          'weekly-${DateTime.now().microsecondsSinceEpoch}';
      final ids = await _database.transaction(() async {
        final insertedIds = <int>[];
        for (var index = 0; index < data.repeatCount; index++) {
          final date = data.date.add(Duration(days: 7 * index));
          insertedIds.add(
            await _insertScheduleRow(
              data,
              ScheduleType.weekly,
              recurrenceGroupId,
              date,
            ),
          );
        }
        return insertedIds;
      });

      for (final id in ids) {
        await _tryScheduleReminder(id);
      }
      _logger.logTransactionSuccess(action, {
        ...logData,
        'scheduleIds': ids,
        'recurrenceGroupId': recurrenceGroupId,
      });
      return ids;
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Future<void> updateSchedule(int id, ScheduleFormData data) async {
    const action = 'schedules.updateSchedule';
    final logData = {'scheduleId': id, ..._scheduleLogData(data)};
    _logger.logTransactionStart(action, logData);
    try {
      _validate(data);
      final now = DateTime.now();
      final academicPeriodId = await _resolveAcademicPeriodId(
        data.studentId,
        data.academicPeriodId,
        data.date,
      );
      await (_database.update(_database.schedules)
            ..where((schedule) => schedule.id.equals(id))
            ..where((schedule) => schedule.deletedAt.isNull()))
          .write(
            SchedulesCompanion(
              studentId: Value(data.studentId),
              subjectId: Value(data.subjectId),
              academicPeriodId: Value(academicPeriodId),
              date: Value(_dateOnly(data.date)),
              startTime: Value(data.startTime),
              endTime: Value(data.endTime),
              scheduleType: Value(data.scheduleType),
              reminderEnabled: Value(data.reminderEnabled),
              reminderOffsetMinutes: Value(data.reminderOffsetMinutes),
              note: Value(_blankToNull(data.note)),
              status: const Value(ScheduleStatus.scheduled),
              updatedAt: Value(now),
            ),
          );
      await _tryScheduleReminder(id);
      _logger.logTransactionSuccess(action, logData);
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Future<void> reschedule(
    int id,
    DateTime newDate,
    DateTime newStartTime,
    DateTime newEndTime,
  ) async {
    const action = 'schedules.reschedule';
    final logData = {
      'scheduleId': id,
      'date': _dateOnly(newDate).toIso8601String(),
      'startTime': newStartTime.toIso8601String(),
      'endTime': newEndTime.toIso8601String(),
    };
    _logger.logTransactionStart(action, logData);
    try {
      final existing =
          await (_database.select(_database.schedules)
                ..where((schedule) => schedule.id.equals(id))
                ..where((schedule) => schedule.deletedAt.isNull()))
              .getSingleOrNull();
      if (existing == null) {
        throw StateError('Jadwal tidak ditemukan');
      }
      if (!newEndTime.isAfter(newStartTime)) {
        throw ArgumentError('Jam selesai harus lebih besar dari jam mulai');
      }

      final now = DateTime.now();
      final oldDate = _dateOnly(existing.date);
      final oldStartTime = existing.startTime;
      final oldEndTime = existing.endTime;
      final rescheduleNote = _appendRescheduleNote(
        existing.note,
        oldDate: oldDate,
        oldStartTime: oldStartTime,
        oldEndTime: oldEndTime,
        newDate: _dateOnly(newDate),
        newStartTime: newStartTime,
        newEndTime: newEndTime,
        changedAt: now,
      );

      await (_database.update(_database.schedules)
            ..where((schedule) => schedule.id.equals(id))
            ..where((schedule) => schedule.deletedAt.isNull()))
          .write(
            SchedulesCompanion(
              date: Value(_dateOnly(newDate)),
              startTime: Value(newStartTime),
              endTime: Value(newEndTime),
              status: const Value(ScheduleStatus.scheduled),
              note: Value(rescheduleNote),
              lastRescheduledAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      final updated = await (_database.select(
        _database.schedules,
      )..where((schedule) => schedule.id.equals(id))).getSingleOrNull();
      if (updated != null) {
        await _reminderService.rescheduleSessionReminder(
          updated,
          previousStartTime: oldStartTime,
        );
      }
      _logger.logTransactionSuccess(action, logData);
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Future<void> cancelSchedule(int id, {String? reason}) async {
    const action = 'schedules.cancelSchedule';
    final logData = {
      'scheduleId': id,
      'hasReason': _blankToNull(reason) != null,
    };
    _logger.logTransactionStart(action, logData);
    try {
      final existing =
          await (_database.select(_database.schedules)
                ..where((schedule) => schedule.id.equals(id))
                ..where((schedule) => schedule.deletedAt.isNull()))
              .getSingleOrNull();
      if (existing == null) {
        _logger.logTransactionSuccess(action, {...logData, 'skipped': true});
        return;
      }

      final reasonText = _blankToNull(reason);
      final note = reasonText == null
          ? existing.note
          : [
              if (existing.note != null && existing.note!.trim().isNotEmpty)
                existing.note!.trim(),
              'Dibatalkan: $reasonText',
            ].join('\n');

      await (_database.update(
        _database.schedules,
      )..where((schedule) => schedule.id.equals(id))).write(
        SchedulesCompanion(
          status: const Value(ScheduleStatus.cancelled),
          note: Value(note),
          updatedAt: Value(DateTime.now()),
        ),
      );
      await _reminderService.cancelReminder(id);
      _logger.logTransactionSuccess(action, logData);
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  JoinedSelectStatement<HasResultSet, dynamic> _joinedScheduleQuery() {
    return (_database.select(_database.schedules).join([
      innerJoin(
        _database.students,
        _database.students.id.equalsExp(_database.schedules.studentId),
      ),
      innerJoin(
        _database.subjects,
        _database.subjects.id.equalsExp(_database.schedules.subjectId),
      ),
      leftOuterJoin(
        _database.academicPeriods,
        _database.academicPeriods.id.equalsExp(
          _database.schedules.academicPeriodId,
        ),
      ),
    ]))..where(_database.schedules.deletedAt.isNull());
  }

  List<ScheduleDetail> _mapRows(List<TypedResult> rows) {
    return rows.map(_mapRow).toList(growable: false);
  }

  ScheduleDetail? _mapRowOrNull(TypedResult? row) {
    return row == null ? null : _mapRow(row);
  }

  ScheduleDetail _mapRow(TypedResult row) {
    return ScheduleDetail(
      schedule: row.readTable(_database.schedules),
      student: row.readTable(_database.students),
      subject: row.readTable(_database.subjects),
      academicPeriod: row.readTableOrNull(_database.academicPeriods),
    );
  }

  Future<int> _insertScheduleRow(
    ScheduleFormData data,
    String scheduleType,
    String? recurrenceGroupId,
    DateTime date,
  ) {
    final now = DateTime.now();
    final offset = date.difference(_dateOnly(data.date));
    return _resolveAcademicPeriodId(
      data.studentId,
      data.academicPeriodId,
      date,
    ).then(
      (academicPeriodId) => _database
          .into(_database.schedules)
          .insert(
            SchedulesCompanion.insert(
              studentId: data.studentId,
              subjectId: data.subjectId,
              academicPeriodId: Value(academicPeriodId),
              date: _dateOnly(date),
              startTime: data.startTime.add(offset),
              endTime: data.endTime.add(offset),
              scheduleType: Value(scheduleType),
              status: const Value(ScheduleStatus.scheduled),
              recurrenceGroupId: Value(recurrenceGroupId),
              reminderEnabled: Value(data.reminderEnabled),
              reminderOffsetMinutes: Value(data.reminderOffsetMinutes),
              note: Value(_blankToNull(data.note)),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          ),
    );
  }

  Future<int?> _resolveAcademicPeriodId(
    int studentId,
    int? requestedAcademicPeriodId, [
    DateTime? referenceDate,
  ]) async {
    if (requestedAcademicPeriodId != null) {
      final existingPeriod =
          await (_database.select(_database.academicPeriods)
                ..where((period) => period.id.equals(requestedAcademicPeriodId))
                ..where((period) => period.deletedAt.isNull()))
              .getSingleOrNull();
      if (existingPeriod == null) {
        throw ArgumentError.value(
          requestedAcademicPeriodId,
          'academicPeriodId',
          'Periode akademik tidak ditemukan',
        );
      }
      return requestedAcademicPeriodId;
    }

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
    final date = referenceDate == null ? null : _dateOnly(referenceDate);
    if (date != null) {
      for (final row in assignments) {
        final period = row.readTable(_database.academicPeriods);
        if (!date.isBefore(_dateOnly(period.startDate)) &&
            !date.isAfter(_dateOnly(period.endDate))) {
          return period.id;
        }
      }
    }
    if (assignments.isNotEmpty) {
      return assignments.first.readTable(_database.academicPeriods).id;
    }

    final student =
        await (_database.select(_database.students)
              ..where((row) => row.id.equals(studentId))
              ..where((row) => row.deletedAt.isNull()))
            .getSingleOrNull();
    return student?.defaultAcademicPeriodId;
  }

  Future<void> _tryScheduleReminder(int id) async {
    final schedule = await (_database.select(
      _database.schedules,
    )..where((schedule) => schedule.id.equals(id))).getSingleOrNull();
    if (schedule == null) return;
    try {
      await _reminderService.scheduleReminder(schedule);
    } catch (_) {
      // Reminder is best-effort in Sprint 03 and must not block scheduling.
    }
  }

  Map<String, Object?> _scheduleLogData(ScheduleFormData data) {
    return {
      'studentId': data.studentId,
      'subjectId': data.subjectId,
      'date': _dateOnly(data.date).toIso8601String(),
      'startTime': data.startTime.toIso8601String(),
      'endTime': data.endTime.toIso8601String(),
      'scheduleType': data.scheduleType,
      'repeatCount': data.repeatCount,
      'reminderEnabled': data.reminderEnabled,
      'academicPeriodId': data.academicPeriodId,
      'reminderOffsetMinutes': data.reminderOffsetMinutes,
    };
  }

  void _validate(ScheduleFormData data) {
    if (!data.endTime.isAfter(data.startTime)) {
      throw ArgumentError('Jam selesai harus lebih besar dari jam mulai');
    }
    if (data.scheduleType != ScheduleType.once &&
        data.scheduleType != ScheduleType.weekly &&
        data.scheduleType != ScheduleType.custom) {
      throw ArgumentError.value(data.scheduleType, 'scheduleType');
    }
    if (data.reminderOffsetMinutes < 0) {
      throw ArgumentError.value(
        data.reminderOffsetMinutes,
        'reminderOffsetMinutes',
        'Offset reminder tidak valid',
      );
    }
  }

  (DateTime, DateTime) _dayRange(DateTime date) {
    final start = _dateOnly(date);
    return (start, start.add(const Duration(days: 1)));
  }

  DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  String? _blankToNull(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  String _appendRescheduleNote(
    String? existingNote, {
    required DateTime oldDate,
    required DateTime oldStartTime,
    required DateTime oldEndTime,
    required DateTime newDate,
    required DateTime newStartTime,
    required DateTime newEndTime,
    required DateTime changedAt,
  }) {
    final noteLines = <String>[
      if (_blankToNull(existingNote) case final existing?) existing,
      'Reschedule ${changedAt.toIso8601String()}: '
          '${oldDate.toIso8601String().split('T').first} '
          '${_timeLabel(oldStartTime)}-${_timeLabel(oldEndTime)} '
          '-> ${newDate.toIso8601String().split('T').first} '
          '${_timeLabel(newStartTime)}-${_timeLabel(newEndTime)}',
    ];
    return noteLines.join('\n');
  }

  String _timeLabel(DateTime value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
