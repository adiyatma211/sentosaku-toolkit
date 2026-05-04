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
    expect(session.progressNote, 'Fokus bagus');
    expect(session.feeAmount, 150000);
  });

  test(
    'createSessionFromSchedule menyimpan assessment dan academic period secara atomik',
    () async {
      final period = await seedAcademicPeriod(database, name: 'Semester Genap');
      final student = await seedStudent(
        database,
        defaultAcademicPeriodId: period.id,
      );
      final subject = await seedSubject(database, studentId: student.id);
      final schedule = await seedSchedule(
        database,
        studentId: student.id,
        subjectId: subject.id,
        date: dateOnly(2026, 4, 16),
      );

      final sessionId = await repository.createSessionFromSchedule(
        SessionFormData(
          scheduleId: schedule.id,
          attendanceStatus: AttendanceStatus.present,
          feeAmount: 180000,
          assessment: const SessionAssessmentFormData(
            pemahamanMateri: 'Memahami konsep dasar dengan baik.',
            keaktifanTanyaJawab: 'Aktif bertanya saat latihan.',
            targetMateriDrilling: 'Lanjut drilling soal cerita.',
            summaryNote: 'Perlu menjaga kerapian langkah hitung.',
          ),
        ),
      );

      final session = await (database.select(
        database.sessions,
      )..where((t) => t.id.equals(sessionId))).getSingle();
      final assessment = await (database.select(
        database.assessments,
      )..where((t) => t.sessionId.equals(sessionId))).getSingle();
      final invoice = await (database.select(
        database.invoices,
      )..where((t) => t.sessionId.equals(sessionId))).getSingle();

      expect(session.academicPeriodId, period.id);
      expect(assessment.academicPeriodId, period.id);
      expect(assessment.pemahamanMateri, 'Memahami konsep dasar dengan baik.');
      expect(assessment.keaktifanTanyaJawab, 'Aktif bertanya saat latihan.');
      expect(invoice.academicPeriodId, period.id);
      expect(invoice.periodLabel, 'Semester Genap');
    },
  );

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
      expect(invoice.dueDate, dateOnly(2026, 4, 19));
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

  test(
    'watchStudentAttendanceRecap menghitung dari session attendance source',
    () async {
      final period = await seedAcademicPeriod(database);
      final student = await seedStudent(database, name: 'Alya');
      final subject = await seedSubject(database, studentId: student.id);
      final baseDate = dateOnly(2026, 4, 20);

      await seedSession(
        database,
        studentId: student.id,
        subjectId: subject.id,
        sessionDate: baseDate,
        academicPeriodId: period.id,
        attendanceStatus: AttendanceStatus.present,
      );
      await seedSession(
        database,
        studentId: student.id,
        subjectId: subject.id,
        sessionDate: baseDate.add(const Duration(days: 1)),
        academicPeriodId: period.id,
        attendanceStatus: AttendanceStatus.permission,
      );
      await seedSession(
        database,
        studentId: student.id,
        subjectId: subject.id,
        sessionDate: baseDate.add(const Duration(days: 2)),
        academicPeriodId: period.id,
        attendanceStatus: AttendanceStatus.cancelled,
        isAttendanceSource: false,
      );

      final recap = await repository
          .watchStudentAttendanceRecap(
            StudentAttendanceRecapFilter(
              startDate: baseDate,
              endDate: baseDate.add(const Duration(days: 7)),
              academicPeriodId: period.id,
            ),
          )
          .first;

      expect(recap, hasLength(1));
      expect(recap.single.studentName, 'Alya');
      expect(recap.single.presentCount, 1);
      expect(recap.single.permissionCount, 1);
      expect(recap.single.cancelledCount, 0);
      expect(recap.single.totalCount, 2);
    },
  );

  test('createSessionFromSchedule memakai assignment periode bila jadwal belum punya period', () async {
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
    final schedule = await seedSchedule(
      database,
      studentId: student.id,
      subjectId: subject.id,
      date: dateOnly(2026, 9, 10),
      academicPeriodId: null,
    );

    final sessionId = await repository.createSessionFromSchedule(
      SessionFormData(
        scheduleId: schedule.id,
        attendanceStatus: AttendanceStatus.present,
        feeAmount: 150000,
      ),
    );

    final session = await (database.select(
      database.sessions,
    )..where((t) => t.id.equals(sessionId))).getSingle();
    expect(session.academicPeriodId, assignedPeriod.id);
  });
}
