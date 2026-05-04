import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/logging/app_logger.dart';

abstract class LocalNotificationGateway {
  Future<void> scheduleScheduleReminder({
    required int scheduleId,
    required DateTime scheduledAt,
    required String title,
    required String body,
    required String payload,
  });

  Future<void> cancelScheduleReminder(int scheduleId);
}

class LocalReminderService {
  LocalReminderService(
    this._database,
    this._logger, {
    LocalNotificationGateway? gateway,
  }) : _gateway = gateway;

  final AppDatabase? _database;
  final AppLogger? _logger;
  final LocalNotificationGateway? _gateway;

  Future<void> scheduleReminder(Schedule schedule) {
    return scheduleSessionReminder(schedule);
  }

  Future<void> cancelReminder(int scheduleId) {
    return cancelScheduleReminder(scheduleId);
  }

  Future<void> scheduleSessionReminder(Schedule schedule) async {
    if (!_shouldSchedule(schedule)) {
      await cancelScheduleReminder(schedule.id);
      return;
    }

    final scheduledAt = schedule.startTime.subtract(
      Duration(minutes: schedule.reminderOffsetMinutes),
    );
    final payload = jsonEncode({
      'scheduleId': schedule.id,
      'studentId': schedule.studentId,
      'subjectId': schedule.subjectId,
      'startTime': schedule.startTime.toIso8601String(),
      'offsetMinutes': schedule.reminderOffsetMinutes,
      'lastRescheduledAt': schedule.lastRescheduledAt?.toIso8601String(),
    });

    try {
      await _upsertReminderLog(
        schedule: schedule,
        scheduledAt: scheduledAt,
        status: scheduledAt.isAfter(DateTime.now())
            ? ReminderStatus.scheduled
            : ReminderStatus.failed,
        payload: payload,
      );

      if (_gateway != null && scheduledAt.isAfter(DateTime.now())) {
        await _gateway.scheduleScheduleReminder(
          scheduleId: schedule.id,
          scheduledAt: scheduledAt,
          title: 'Reminder jadwal les',
          body: 'Jadwal dimulai ${schedule.reminderOffsetMinutes} menit lagi.',
          payload: payload,
        );
      }

      _logger?.logInfo('Schedule reminder prepared', {
        'scheduleId': schedule.id,
        'scheduledAt': scheduledAt.toIso8601String(),
        'status': scheduledAt.isAfter(DateTime.now())
            ? ReminderStatus.scheduled
            : ReminderStatus.failed,
      });
    } catch (error, stackTrace) {
      await _upsertReminderLog(
        schedule: schedule,
        scheduledAt: scheduledAt,
        status: ReminderStatus.failed,
        payload: jsonEncode({'scheduleId': schedule.id, 'error': '$error'}),
      );
      _logger?.logError(
        'Schedule reminder scheduling failed',
        error,
        stackTrace,
        {'scheduleId': schedule.id},
      );
      rethrow;
    }
  }

  Future<void> rescheduleSessionReminder(
    Schedule schedule, {
    DateTime? previousStartTime,
  }) async {
    await cancelScheduleReminder(
      schedule.id,
      previousStartTime: previousStartTime,
    );
    await scheduleSessionReminder(schedule);
  }

  Future<void> cancelScheduleReminder(
    int scheduleId, {
    DateTime? previousStartTime,
  }) async {
    final database = _database;
    if (database == null) return;
    final now = DateTime.now();
    await (database.update(database.reminderLogs)
          ..where((log) => log.referenceTable.equals('schedules'))
          ..where((log) => log.referenceId.equals(scheduleId))
          ..where(
            (log) => log.reminderType.equals(ReminderType.scheduleSession),
          )
          ..where((log) => log.status.equals(ReminderStatus.scheduled)))
        .write(
          ReminderLogsCompanion(
            status: const Value(ReminderStatus.cancelled),
            payloadJson: Value(
              jsonEncode({
                'scheduleId': scheduleId,
                'previousStartTime': previousStartTime?.toIso8601String(),
                'cancelledAt': now.toIso8601String(),
              }),
            ),
            updatedAt: Value(now),
          ),
        );

    if (_gateway != null) {
      await _gateway.cancelScheduleReminder(scheduleId);
    }

    _logger?.logInfo('Schedule reminder cancelled', {
      'scheduleId': scheduleId,
      if (previousStartTime != null)
        'previousStartTime': previousStartTime.toIso8601String(),
    });
  }

  bool _shouldSchedule(Schedule schedule) {
    return schedule.reminderEnabled &&
        schedule.status == ScheduleStatus.scheduled;
  }

  Future<void> _upsertReminderLog({
    required Schedule schedule,
    required DateTime scheduledAt,
    required String status,
    required String payload,
  }) async {
    final database = _database;
    if (database == null) return;
    final now = DateTime.now();
    final existing =
        await (database.select(database.reminderLogs)
              ..where((log) => log.referenceTable.equals('schedules'))
              ..where((log) => log.referenceId.equals(schedule.id))
              ..where(
                (log) => log.reminderType.equals(ReminderType.scheduleSession),
              )
              ..orderBy([(log) => OrderingTerm.desc(log.id)]))
            .getSingleOrNull();

    if (existing == null) {
      await database
          .into(database.reminderLogs)
          .insert(
            ReminderLogsCompanion.insert(
              reminderType: Value(ReminderType.scheduleSession),
              referenceTable: 'schedules',
              referenceId: schedule.id,
              scheduledAt: scheduledAt,
              status: Value(status),
              payloadJson: Value(payload),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      return;
    }

    await (database.update(
      database.reminderLogs,
    )..where((log) => log.id.equals(existing.id))).write(
      ReminderLogsCompanion(
        scheduledAt: Value(scheduledAt),
        status: Value(status),
        payloadJson: Value(payload),
        updatedAt: Value(now),
      ),
    );
  }
}
