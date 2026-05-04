import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sentosa_catat_app/core/constants/app_constants.dart';
import 'package:sentosa_catat_app/core/logging/app_logger.dart';
import 'package:sentosa_catat_app/features/schedules/data/local_reminder_service.dart';

import '../../../helpers/seed_data.dart';
import '../../../helpers/test_app_database.dart';

void main() {
  late TestAppDatabase database;
  late LocalReminderService service;

  setUp(() {
    database = TestAppDatabase();
    service = LocalReminderService(database, AppLogger());
  });

  tearDown(() async {
    await database.close();
  });

  test('scheduleSessionReminder menulis reminder log offline-first', () async {
    final student = await seedStudent(database);
    final subject = await seedSubject(database, studentId: student.id);
    final date = dateOnly(2099, 4, 30);
    final schedule = await seedSchedule(
      database,
      studentId: student.id,
      subjectId: subject.id,
      date: date,
      reminderEnabled: true,
      reminderOffsetMinutes: 45,
      startTime: timeOn(date, 14),
      endTime: timeOn(date, 15),
    );

    await service.scheduleSessionReminder(schedule);

    final log =
        await (database.select(database.reminderLogs)
              ..where((row) => row.referenceTable.equals('schedules'))
              ..where((row) => row.referenceId.equals(schedule.id)))
            .getSingle();
    final payload = jsonDecode(log.payloadJson!) as Map<String, dynamic>;

    expect(log.reminderType, ReminderType.scheduleSession);
    expect(log.status, ReminderStatus.scheduled);
    expect(log.scheduledAt, timeOn(date, 13, 15));
    expect(payload['offsetMinutes'], 45);
  });

  test('cancelScheduleReminder membatalkan log reminder aktif', () async {
    final student = await seedStudent(database);
    final subject = await seedSubject(database, studentId: student.id);
    final date = dateOnly(2099, 5, 1);
    final schedule = await seedSchedule(
      database,
      studentId: student.id,
      subjectId: subject.id,
      date: date,
      reminderEnabled: true,
      startTime: timeOn(date, 9),
      endTime: timeOn(date, 10),
    );

    await service.scheduleSessionReminder(schedule);
    await service.cancelScheduleReminder(schedule.id);

    final log =
        await (database.select(database.reminderLogs)
              ..where((row) => row.referenceTable.equals('schedules'))
              ..where((row) => row.referenceId.equals(schedule.id)))
            .getSingle();

    expect(log.status, ReminderStatus.cancelled);
  });
}
