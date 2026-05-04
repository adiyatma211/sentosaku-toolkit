import 'package:flutter_test/flutter_test.dart';
import 'package:sentosa_catat_app/core/constants/app_constants.dart';
import 'package:sentosa_catat_app/core/logging/app_logger.dart';
import 'package:sentosa_catat_app/features/schedules/data/schedule_repository.dart';

import '../../../helpers/fakes/fake_local_reminder_service.dart';
import '../../../helpers/seed_data.dart';
import '../../../helpers/test_app_database.dart';

void main() {
  late TestAppDatabase database;
  late FakeLocalReminderService reminderService;
  late ScheduleRepository repository;

  setUp(() {
    database = TestAppDatabase();
    reminderService = FakeLocalReminderService();
    repository = ScheduleRepository(database, reminderService, AppLogger());
  });

  tearDown(() async {
    await database.close();
  });

  test('insert single schedule valid', () async {
    final period = await seedAcademicPeriod(database);
    final student = await seedStudent(
      database,
      defaultAcademicPeriodId: period.id,
    );
    final subject = await seedSubject(database, studentId: student.id);
    final date = dateOnly(2026, 4, 20);

    final id = await repository.insertSchedule(
      ScheduleFormData(
        studentId: student.id,
        subjectId: subject.id,
        date: date,
        startTime: timeOn(date, 13),
        endTime: timeOn(date, 14, 30),
        scheduleType: ScheduleType.once,
        reminderEnabled: true,
        note: 'Bab limit',
      ),
    );

    final schedule = await (database.select(
      database.schedules,
    )..where((t) => t.id.equals(id))).getSingle();

    expect(schedule.studentId, student.id);
    expect(schedule.subjectId, subject.id);
    expect(schedule.status, ScheduleStatus.scheduled);
    expect(schedule.scheduleType, ScheduleType.once);
    expect(schedule.academicPeriodId, period.id);
    expect(schedule.reminderOffsetMinutes, 60);
    expect(schedule.note, 'Bab limit');
    expect(reminderService.scheduledSchedules.map((e) => e.id), contains(id));
  });

  test(
    'insert schedule bisa override academic period dan reminder offset',
    () async {
      final defaultPeriod = await seedAcademicPeriod(
        database,
        name: 'Semester A',
      );
      final overridePeriod = await seedAcademicPeriod(
        database,
        name: 'Semester B',
      );
      final student = await seedStudent(
        database,
        defaultAcademicPeriodId: defaultPeriod.id,
      );
      final subject = await seedSubject(database, studentId: student.id);
      final date = dateOnly(2026, 4, 26);

      final id = await repository.insertSchedule(
        ScheduleFormData(
          studentId: student.id,
          subjectId: subject.id,
          academicPeriodId: overridePeriod.id,
          date: date,
          startTime: timeOn(date, 8),
          endTime: timeOn(date, 9),
          scheduleType: ScheduleType.once,
          reminderEnabled: true,
          reminderOffsetMinutes: 30,
        ),
      );

      final schedule = await (database.select(
        database.schedules,
      )..where((t) => t.id.equals(id))).getSingle();

      expect(schedule.academicPeriodId, overridePeriod.id);
      expect(schedule.reminderOffsetMinutes, 30);
    },
  );

  test('reject endTime <= startTime', () async {
    final student = await seedStudent(database);
    final subject = await seedSubject(database, studentId: student.id);
    final date = dateOnly(2026, 4, 20);

    await expectLater(
      () => repository.insertSchedule(
        ScheduleFormData(
          studentId: student.id,
          subjectId: subject.id,
          date: date,
          startTime: timeOn(date, 14),
          endTime: timeOn(date, 14),
          scheduleType: ScheduleType.once,
          reminderEnabled: false,
        ),
      ),
      throwsA(isA<ArgumentError>()),
    );
  });

  test(
    'insert weekly schedules menghasilkan beberapa row dengan recurrenceGroupId sama',
    () async {
      final student = await seedStudent(database);
      final subject = await seedSubject(database, studentId: student.id);
      final date = dateOnly(2026, 4, 21);

      final ids = await repository.insertWeeklySchedules(
        ScheduleFormData(
          studentId: student.id,
          subjectId: subject.id,
          date: date,
          startTime: timeOn(date, 15),
          endTime: timeOn(date, 16),
          scheduleType: ScheduleType.weekly,
          reminderEnabled: true,
          repeatCount: 3,
        ),
      );

      final schedules = await (database.select(
        database.schedules,
      )..where((t) => t.id.isIn(ids))).get();
      final groupIds = schedules.map((e) => e.recurrenceGroupId).toSet();
      final dates = schedules.map((e) => e.date).toList()..sort();

      expect(ids, hasLength(3));
      expect(schedules, hasLength(3));
      expect(groupIds, hasLength(1));
      expect(groupIds.single, isNotNull);
      expect(dates, <DateTime>[
        dateOnly(2026, 4, 21),
        dateOnly(2026, 4, 28),
        dateOnly(2026, 5, 5),
      ]);
    },
  );

  test('cancelSchedule mengubah status dan append reason', () async {
    final student = await seedStudent(database);
    final subject = await seedSubject(database, studentId: student.id);
    final schedule = await seedSchedule(
      database,
      studentId: student.id,
      subjectId: subject.id,
      date: dateOnly(2026, 4, 22),
      note: 'Catatan awal',
      reminderEnabled: true,
    );

    await repository.cancelSchedule(schedule.id, reason: 'Siswa sakit');

    final updated = await (database.select(
      database.schedules,
    )..where((t) => t.id.equals(schedule.id))).getSingle();

    expect(updated.status, ScheduleStatus.cancelled);
    expect(updated.note, 'Catatan awal\nDibatalkan: Siswa sakit');
    expect(reminderService.cancelledScheduleIds, contains(schedule.id));
  });

  test(
    'insert schedule memilih assignment periode siswa sebelum defaultAcademicPeriodId',
    () async {
      final defaultPeriod = await seedAcademicPeriod(
        database,
        name: 'Default',
        startDate: dateOnly(2026, 1, 1),
        endDate: dateOnly(2026, 6, 30),
      );
      final assignedPeriod = await seedAcademicPeriod(
        database,
        name: 'Assigned',
        startDate: dateOnly(2026, 7, 1),
        endDate: dateOnly(2026, 12, 31),
        isActive: false,
      );
      final student = await seedStudent(
        database,
        defaultAcademicPeriodId: defaultPeriod.id,
      );
      await seedStudentPeriod(
        database,
        studentId: student.id,
        academicPeriodId: assignedPeriod.id,
      );
      final subject = await seedSubject(database, studentId: student.id);
      final date = dateOnly(2026, 8, 2);

      final id = await repository.insertSchedule(
        ScheduleFormData(
          studentId: student.id,
          subjectId: subject.id,
          date: date,
          startTime: timeOn(date, 9),
          endTime: timeOn(date, 10),
          scheduleType: ScheduleType.once,
          reminderEnabled: false,
        ),
      );

      final schedule = await (database.select(
        database.schedules,
      )..where((t) => t.id.equals(id))).getSingle();
      expect(schedule.academicPeriodId, assignedPeriod.id);
    },
  );

  test('reschedule menyimpan audit note, marker, dan reminder baru', () async {
    final student = await seedStudent(database);
    final subject = await seedSubject(database, studentId: student.id);
    final schedule = await seedSchedule(
      database,
      studentId: student.id,
      subjectId: subject.id,
      date: dateOnly(2026, 4, 23),
      note: 'Catatan awal',
      reminderEnabled: true,
    );
    final newDate = dateOnly(2026, 4, 25);

    await repository.reschedule(
      schedule.id,
      newDate,
      timeOn(newDate, 10),
      timeOn(newDate, 11, 30),
    );

    final updated = await (database.select(
      database.schedules,
    )..where((t) => t.id.equals(schedule.id))).getSingle();

    expect(updated.status, ScheduleStatus.scheduled);
    expect(updated.date, newDate);
    expect(updated.startTime, timeOn(newDate, 10));
    expect(updated.endTime, timeOn(newDate, 11, 30));
    expect(updated.lastRescheduledAt, isNotNull);
    expect(updated.note, contains('Catatan awal'));
    expect(updated.note, contains('Reschedule'));
    expect(reminderService.cancelledScheduleIds, contains(schedule.id));
    expect(
      reminderService.scheduledSchedules.map((e) => e.id),
      contains(schedule.id),
    );
  });
}
