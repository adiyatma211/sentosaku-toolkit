import 'package:flutter_test/flutter_test.dart';
import 'package:sentosa_catat_app/core/constants/app_constants.dart';
import 'package:sentosa_catat_app/core/logging/app_logger.dart';
import 'package:sentosa_catat_app/features/sessions/data/session_repository.dart';

import '../../../helpers/seed_data.dart';
import '../../../helpers/test_app_database.dart';

void main() {
  late TestAppDatabase database;
  late SessionRepository repository;

  setUp(() {
    database = TestAppDatabase();
    repository = SessionRepository(database, AppLogger());
  });

  tearDown(() async {
    await database.close();
  });

  test('createSessionFromSchedule membuat session valid', () async {
    final student = await seedStudent(database);
    final subject = await seedSubject(database, studentId: student.id);
    final schedule = await seedSchedule(
      database,
      studentId: student.id,
      subjectId: subject.id,
      date: dateOnly(2026, 4, 10),
    );

    final sessionId = await repository.createSessionFromSchedule(
      SessionFormData(
        scheduleId: schedule.id,
        attendanceStatus: AttendanceStatus.present,
        feeAmount: 150000,
        material: 'Integral',
        homework: 'Latihan 1-10',
        progressNote: 'Fokus bagus',
      ),
    );

    final session = await (database.select(
      database.sessions,
    )..where((t) => t.id.equals(sessionId))).getSingle();

    expect(session.scheduleId, schedule.id);
    expect(session.studentId, student.id);
    expect(session.subjectId, subject.id);
    expect(session.sessionDate, schedule.date);
    expect(session.startTime, schedule.startTime);
    expect(session.endTime, schedule.endTime);
    expect(session.attendanceStatus, AttendanceStatus.present);
    expect(session.material, 'Integral');
    expect(session.homework, 'Latihan 1-10');
    expect(session.note, 'Fokus bagus');
    expect(session.feeAmount, 150000);
  });

  test('update schedule.status sesuai attendance present dan absent', () async {
    final student = await seedStudent(database);
    final subject = await seedSubject(database, studentId: student.id);
    final presentSchedule = await seedSchedule(
      database,
      studentId: student.id,
      subjectId: subject.id,
      date: dateOnly(2026, 4, 10),
    );
    final absentSchedule = await seedSchedule(
      database,
      studentId: student.id,
      subjectId: subject.id,
      date: dateOnly(2026, 4, 11),
    );

    await repository.createSessionFromSchedule(
      SessionFormData(
        scheduleId: presentSchedule.id,
        attendanceStatus: AttendanceStatus.present,
        feeAmount: 150000,
      ),
    );
    await repository.createSessionFromSchedule(
      SessionFormData(
        scheduleId: absentSchedule.id,
        attendanceStatus: AttendanceStatus.absent,
        feeAmount: 150000,
      ),
    );

    final updatedPresent = await (database.select(
      database.schedules,
    )..where((t) => t.id.equals(presentSchedule.id))).getSingle();
    final updatedAbsent = await (database.select(
      database.schedules,
    )..where((t) => t.id.equals(absentSchedule.id))).getSingle();

    expect(updatedPresent.status, ScheduleStatus.done);
    expect(updatedAbsent.status, ScheduleStatus.noShow);
  });

  test(
    'create invoice hanya untuk present + per_session + feeAmount > 0',
    () async {
      final student = await seedStudent(
        database,
        rateType: RateType.perSession,
      );
      final subject = await seedSubject(database, studentId: student.id);
      final schedule = await seedSchedule(
        database,
        studentId: student.id,
        subjectId: subject.id,
        date: dateOnly(2026, 4, 12),
      );

      final sessionId = await repository.createSessionFromSchedule(
        SessionFormData(
          scheduleId: schedule.id,
          attendanceStatus: AttendanceStatus.present,
          feeAmount: 175000,
        ),
      );

      final session = await (database.select(
        database.sessions,
      )..where((t) => t.id.equals(sessionId))).getSingle();
      final invoice = await (database.select(
        database.invoices,
      )..where((t) => t.sessionId.equals(sessionId))).getSingle();

      expect(session.invoiceId, invoice.id);
      expect(invoice.studentId, student.id);
      expect(invoice.amount, 175000);
      expect(invoice.status, InvoiceStatus.unpaid);
      expect(invoice.periodLabel, 'Sesi 2026-04');
    },
  );

  test('tidak membuat invoice untuk monthly atau package', () async {
    final monthlyStudent = await seedStudent(
      database,
      name: 'Monthly',
      rateType: RateType.monthly,
    );
    final packageStudent = await seedStudent(
      database,
      name: 'Package',
      rateType: RateType.package,
    );
    final subject = await seedSubject(database);
    final monthlySchedule = await seedSchedule(
      database,
      studentId: monthlyStudent.id,
      subjectId: subject.id,
      date: dateOnly(2026, 4, 13),
    );
    final packageSchedule = await seedSchedule(
      database,
      studentId: packageStudent.id,
      subjectId: subject.id,
      date: dateOnly(2026, 4, 14),
    );

    await repository.createSessionFromSchedule(
      SessionFormData(
        scheduleId: monthlySchedule.id,
        attendanceStatus: AttendanceStatus.present,
        feeAmount: 150000,
      ),
    );
    await repository.createSessionFromSchedule(
      SessionFormData(
        scheduleId: packageSchedule.id,
        attendanceStatus: AttendanceStatus.present,
        feeAmount: 150000,
      ),
    );

    final invoices = await database.select(database.invoices).get();
    expect(invoices, isEmpty);
  });

  test('reject jika schedule sudah punya session aktif', () async {
    final student = await seedStudent(database);
    final subject = await seedSubject(database, studentId: student.id);
    final schedule = await seedSchedule(
      database,
      studentId: student.id,
      subjectId: subject.id,
      date: dateOnly(2026, 4, 15),
    );
    await seedSession(
      database,
      scheduleId: schedule.id,
      studentId: student.id,
      subjectId: subject.id,
      sessionDate: schedule.date,
    );

    await expectLater(
      () => repository.createSessionFromSchedule(
        SessionFormData(
          scheduleId: schedule.id,
          attendanceStatus: AttendanceStatus.present,
          feeAmount: 150000,
        ),
      ),
      throwsA(isA<StateError>()),
    );
  });
}
