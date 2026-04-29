import '../../../core/database/app_database.dart';

class LocalReminderService {
  const LocalReminderService();

  Future<void> scheduleReminder(Schedule schedule) async {
    if (!schedule.reminderEnabled) return;
    // Placeholder for local notification integration in a later sprint.
  }

  Future<void> cancelReminder(int scheduleId) async {
    // Placeholder for local notification cancellation in a later sprint.
  }
}
