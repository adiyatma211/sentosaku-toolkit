import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentosa_catat_app/core/constants/app_constants.dart';
import 'package:sentosa_catat_app/features/schedules/data/schedule_repository.dart';
import 'package:sentosa_catat_app/features/schedules/providers/schedule_provider.dart';

import '../../../helpers/fakes/fake_local_reminder_service.dart';
import '../../../helpers/provider_test_harness.dart';
import '../../../helpers/seed_data.dart';
import '../../../helpers/test_app_database.dart';

void main() {
  test('selectedScheduleDateProvider normalize today init', () {
    final database = TestAppDatabase();
    final container = createProviderContainer(database: database);
    final now = DateTime.now();

    final selectedDate = container.read(selectedScheduleDateProvider);

    expect(selectedDate.year, now.year);
    expect(selectedDate.month, now.month);
    expect(selectedDate.day, now.day);
    expect(selectedDate.hour, 0);
    expect(selectedDate.minute, 0);
  });

  test('addSchedule memilih single untuk once', () async {
    final database = TestAppDatabase();
    final reminder = FakeLocalReminderService();
    final container = createProviderContainer(
      database: database,
      overrides: [localReminderServiceProvider.overrideWithValue(reminder)],
    );
    final student = await seedStudent(database);
    final subject = await seedSubject(database, studentId: student.id);
    final date = dateOnly(2026, 4, 21);

    final scheduleId = await container
        .read(scheduleFormNotifierProvider.notifier)
        .addSchedule(
          ScheduleFormData(
            studentId: student.id,
            subjectId: subject.id,
            date: date,
            startTime: timeOn(date, 15),
            endTime: timeOn(date, 16),
            scheduleType: ScheduleType.once,
            reminderEnabled: true,
          ),
        );

    final schedule = await (database.select(
      database.schedules,
    )..where((t) => t.id.equals(scheduleId))).getSingle();

    expect(schedule.scheduleType, ScheduleType.once);
    expect(reminder.scheduledSchedules, hasLength(1));
    expect(
      container.read(scheduleFormNotifierProvider),
      isA<AsyncData<void>>(),
    );
  });

  test('addSchedule memilih weekly untuk jadwal mingguan', () async {
    final database = TestAppDatabase();
    final reminder = FakeLocalReminderService();
    final container = createProviderContainer(
      database: database,
      overrides: [localReminderServiceProvider.overrideWithValue(reminder)],
    );
    final student = await seedStudent(database);
    final subject = await seedSubject(database, studentId: student.id);
    final date = dateOnly(2026, 4, 22);

    final firstId = await container
        .read(scheduleFormNotifierProvider.notifier)
        .addSchedule(
          ScheduleFormData(
            studentId: student.id,
            subjectId: subject.id,
            date: date,
            startTime: timeOn(date, 10),
            endTime: timeOn(date, 11),
            scheduleType: ScheduleType.weekly,
            reminderEnabled: true,
            repeatCount: 3,
          ),
        );

    final schedules = await database.select(database.schedules).get();
    final weeklySchedules = schedules
        .where((schedule) => schedule.scheduleType == ScheduleType.weekly)
        .toList();

    expect(firstId, weeklySchedules.first.id);
    expect(weeklySchedules, hasLength(3));
    expect(
      weeklySchedules.map((schedule) => schedule.recurrenceGroupId).toSet(),
      hasLength(1),
    );
    expect(reminder.scheduledSchedules, hasLength(3));
  });

  test('updateSchedule dan cancelSchedule success', () async {
    final database = TestAppDatabase();
    final reminder = FakeLocalReminderService();
    final container = createProviderContainer(
      database: database,
      overrides: [localReminderServiceProvider.overrideWithValue(reminder)],
    );
    final student = await seedStudent(database);
    final subject = await seedSubject(database, studentId: student.id);
    final schedule = await seedSchedule(
      database,
      studentId: student.id,
      subjectId: subject.id,
      date: dateOnly(2026, 4, 24),
      note: 'Awal',
    );

    await container
        .read(scheduleFormNotifierProvider.notifier)
        .updateSchedule(
          schedule.id,
          ScheduleFormData(
            studentId: student.id,
            subjectId: subject.id,
            date: schedule.date,
            startTime: timeOn(schedule.date, 13),
            endTime: timeOn(schedule.date, 14),
            scheduleType: ScheduleType.once,
            reminderEnabled: true,
            note: 'Diupdate',
          ),
        );
    await container
        .read(scheduleFormNotifierProvider.notifier)
        .cancelSchedule(schedule.id, reason: 'Siswa izin');

    final updated = await (database.select(
      database.schedules,
    )..where((t) => t.id.equals(schedule.id))).getSingle();

    expect(updated.status, ScheduleStatus.cancelled);
    expect(updated.note, 'Diupdate\nDibatalkan: Siswa izin');
    expect(
      container.read(scheduleFormNotifierProvider),
      isA<AsyncData<void>>(),
    );
  });

  test('updateSchedule error menyimpan AsyncError', () async {
    final database = TestAppDatabase();
    final reminder = FakeLocalReminderService();
    final container = createProviderContainer(
      database: database,
      overrides: [localReminderServiceProvider.overrideWithValue(reminder)],
    );
    final student = await seedStudent(database);
    final subject = await seedSubject(database, studentId: student.id);
    final schedule = await seedSchedule(
      database,
      studentId: student.id,
      subjectId: subject.id,
      date: dateOnly(2026, 4, 25),
    );

    await container
        .read(scheduleFormNotifierProvider.notifier)
        .updateSchedule(
          schedule.id,
          ScheduleFormData(
            studentId: student.id,
            subjectId: subject.id,
            date: schedule.date,
            startTime: timeOn(schedule.date, 16),
            endTime: timeOn(schedule.date, 15),
            scheduleType: ScheduleType.once,
            reminderEnabled: false,
          ),
        );

    expect(
      container.read(scheduleFormNotifierProvider),
      isA<AsyncError<void>>(),
    );
    expect(
      container.read(scheduleFormNotifierProvider).error,
      isA<ArgumentError>(),
    );
  });
}
