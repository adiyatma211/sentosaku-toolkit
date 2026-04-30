import 'package:sentosa_catat_app/core/database/app_database.dart';
import 'package:sentosa_catat_app/features/schedules/data/local_reminder_service.dart';

class FakeLocalReminderService extends LocalReminderService {
  FakeLocalReminderService();

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
}
