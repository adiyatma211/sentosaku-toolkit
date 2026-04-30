import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentosa_catat_app/core/constants/app_constants.dart';
import 'package:sentosa_catat_app/features/sessions/data/session_repository.dart';
import 'package:sentosa_catat_app/features/sessions/providers/session_provider.dart';

import '../../../helpers/provider_test_harness.dart';
import '../../../helpers/seed_data.dart';
import '../../../helpers/test_app_database.dart';

void main() {
  test('sessionFormNotifierProvider success menyimpan session', () async {
    final database = TestAppDatabase();
    final container = createProviderContainer(database: database);
    final student = await seedStudent(database);
    final subject = await seedSubject(database, studentId: student.id);
    final schedule = await seedSchedule(
      database,
      studentId: student.id,
      subjectId: subject.id,
      date: dateOnly(2026, 4, 10),
    );

    final sessionId = await container
        .read(sessionFormNotifierProvider.notifier)
        .createSessionFromSchedule(
          SessionFormData(
            scheduleId: schedule.id,
            attendanceStatus: AttendanceStatus.present,
            feeAmount: 150000,
            material: 'Integral',
          ),
        );

    expect(sessionId, greaterThan(0));
    expect(container.read(sessionFormNotifierProvider), isA<AsyncData<void>>());
  });

  test('sessionFormNotifierProvider error menyimpan AsyncError', () async {
    final database = TestAppDatabase();
    final container = createProviderContainer(database: database);

    await expectLater(
      container
          .read(sessionFormNotifierProvider.notifier)
          .createSessionFromSchedule(
            const SessionFormData(
              scheduleId: 999,
              attendanceStatus: AttendanceStatus.present,
              feeAmount: 150000,
            ),
          ),
      throwsA(isA<StateError>()),
    );

    expect(
      container.read(sessionFormNotifierProvider),
      isA<AsyncError<void>>(),
    );
    expect(
      container.read(sessionFormNotifierProvider).error,
      isA<StateError>(),
    );
  });

  test('sessionsProvider membaca stream session list', () async {
    final database = TestAppDatabase();
    final container = createProviderContainer(database: database);
    final student = await seedStudent(database, name: 'Alya');
    final subject = await seedSubject(
      database,
      studentId: student.id,
      name: 'Fisika',
    );
    final schedule = await seedSchedule(
      database,
      studentId: student.id,
      subjectId: subject.id,
      date: dateOnly(2026, 4, 12),
    );
    await seedSession(
      database,
      scheduleId: schedule.id,
      studentId: student.id,
      subjectId: subject.id,
      sessionDate: schedule.date,
      feeAmount: 175000,
    );

    final sessions = await container
        .read(sessionRepositoryProvider)
        .watchSessions()
        .first;

    expect(sessions, hasLength(1));
    expect(sessions.single.student.name, 'Alya');
    expect(sessions.single.subject.name, 'Fisika');
    expect(sessions.single.session.feeAmount, 175000);
  });

  test('sessionDetailProvider membaca detail stream by id', () async {
    final database = TestAppDatabase();
    final container = createProviderContainer(database: database);
    final student = await seedStudent(database, name: 'Bima');
    final subject = await seedSubject(
      database,
      studentId: student.id,
      name: 'Kimia',
    );
    final schedule = await seedSchedule(
      database,
      studentId: student.id,
      subjectId: subject.id,
      date: dateOnly(2026, 4, 14),
    );
    final session = await seedSession(
      database,
      scheduleId: schedule.id,
      studentId: student.id,
      subjectId: subject.id,
      sessionDate: schedule.date,
    );

    final detail = await container
        .read(sessionRepositoryProvider)
        .watchSessionById(session.id)
        .first;

    expect(detail, isNotNull);
    expect(detail!.session.id, session.id);
    expect(detail.student.name, 'Bima');
    expect(detail.subject.name, 'Kimia');
  });
}
