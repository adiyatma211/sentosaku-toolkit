import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sentosa_catat_app/core/constants/app_constants.dart';
import 'package:sentosa_catat_app/core/logging/app_logger.dart';
import 'package:sentosa_catat_app/features/academic/data/assessment_repository.dart';
import 'package:sentosa_catat_app/features/academic/data/progress_report_repository.dart';

import '../../../helpers/seed_data.dart';
import '../../../helpers/test_app_database.dart';

void main() {
  late TestAppDatabase database;
  late ProgressReportRepository repository;

  setUp(() {
    database = TestAppDatabase();
    repository = ProgressReportRepository(
      database,
      AppLogger(),
      AssessmentRepository(database, AppLogger()),
    );
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'generateProgressReport menyimpan snapshot attendance dan assessment',
    () async {
      final period = await seedAcademicPeriod(
        database,
        startDate: dateOnly(2026, 4, 1),
        endDate: dateOnly(2026, 4, 30),
      );
      final student = await seedStudent(
        database,
        defaultAcademicPeriodId: period.id,
      );
      final subject = await seedSubject(database, studentId: student.id);
      await seedSession(
        database,
        studentId: student.id,
        subjectId: subject.id,
        academicPeriodId: period.id,
        sessionDate: dateOnly(2026, 4, 5),
        attendanceStatus: AttendanceStatus.present,
      );
      await seedSession(
        database,
        studentId: student.id,
        subjectId: subject.id,
        academicPeriodId: period.id,
        sessionDate: dateOnly(2026, 4, 12),
        attendanceStatus: AttendanceStatus.permission,
      );
      await seedAssessment(
        database,
        studentId: student.id,
        academicPeriodId: period.id,
        pemahamanMateri: 'Memahami pecahan dengan lebih stabil.',
        targetMateriDrilling: 'Drilling soal cerita pecahan.',
        summaryNote: 'Perlu penguatan kecepatan hitung.',
      );

      final snapshot = await repository.generateProgressReport(
        student.id,
        period.id,
        teacherNote: 'Fokus tetap dijaga.',
        status: ProgressReportStatus.draft,
      );

      expect(snapshot.report.studentId, student.id);
      expect(snapshot.attendanceSummary['presentCount'], 1);
      expect(snapshot.attendanceSummary['permissionCount'], 1);
      expect(snapshot.assessmentSummary['sessionAssessmentCount'], 1);
      expect(snapshot.assessmentSummary['nextTargets'], isNotEmpty);

      final stored = await (database.select(
        database.progressReports,
      )..where((t) => t.id.equals(snapshot.report.id))).getSingle();
      final attendanceJson =
          jsonDecode(stored.attendanceSummaryJson) as Map<String, dynamic>;
      expect(attendanceJson['totalSessions'], 2);
      expect(stored.teacherNote, 'Fokus tetap dijaga.');
    },
  );
}
