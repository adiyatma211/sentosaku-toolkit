import 'package:sentosa_catat_app/core/database/app_database.dart';
import 'package:sentosa_catat_app/core/logging/app_logger.dart';
import 'package:sentosa_catat_app/features/schedules/data/local_reminder_service.dart';

class FakeLocalReminderService extends LocalReminderService {
  FakeLocalReminderService() : super(null, AppLogger());

  final List<Schedule> scheduledSchedules = <Schedule>[];
  final List<int> cancelledScheduleIds = <int>[];

  @override
  Future<void> scheduleReminder(Schedule schedule) async {
    scheduledSchedules.add(schedule);
  }

  @override
  Future<void> cancelReminder(int scheduleId) async {
    cancelledScheduleIds.add(scheduleId);
  }

  @override
  Future<void> scheduleSessionReminder(Schedule schedule) async {
    scheduledSchedules.add(schedule);
  }

  @override
  Future<void> cancelScheduleReminder(
    int scheduleId, {
    DateTime? previousStartTime,
  }) async {
    cancelledScheduleIds.add(scheduleId);
  }

  @override
  Future<void> rescheduleSessionReminder(
    Schedule schedule, {
    DateTime? previousStartTime,
  }) async {
    cancelledScheduleIds.add(schedule.id);
    scheduledSchedules.add(schedule);
  }
}
