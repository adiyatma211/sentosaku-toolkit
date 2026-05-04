import 'package:flutter_test/flutter_test.dart';
import 'package:sentosa_catat_app/core/constants/app_constants.dart';
import 'package:sentosa_catat_app/core/logging/app_logger.dart';
import 'package:sentosa_catat_app/features/academic/data/academic_period_repository.dart';

import '../../../helpers/seed_data.dart';
import '../../../helpers/test_app_database.dart';

void main() {
  late TestAppDatabase database;
  late AcademicPeriodRepository repository;

  setUp(() {
    database = TestAppDatabase();
    repository = AcademicPeriodRepository(database, AppLogger());
  });

  tearDown(() async {
    await database.close();
  });

  test('assignStudentToPeriod menolak assignment duplikat', () async {
    final student = await seedStudent(database);
    final period = await seedAcademicPeriod(database);

    await repository.assignStudentToPeriod(
      StudentPeriodAssignmentFormData(
        studentId: student.id,
        academicPeriodId: period.id,
      ),
    );

    await expectLater(
      () => repository.assignStudentToPeriod(
        StudentPeriodAssignmentFormData(
          studentId: student.id,
          academicPeriodId: period.id,
        ),
      ),
      throwsA(isA<StateError>()),
    );
  });

  test(
    'assignStudentToPeriod memperbarui defaultAcademicPeriodId untuk kompatibilitas',
    () async {
      final student = await seedStudent(database);
      final period = await seedAcademicPeriod(database);

      await repository.assignStudentToPeriod(
        StudentPeriodAssignmentFormData(
          studentId: student.id,
          academicPeriodId: period.id,
          status: StudentPeriodStatus.active,
        ),
      );

      final updatedStudent = await (database.select(
        database.students,
      )..where((t) => t.id.equals(student.id))).getSingle();
      expect(updatedStudent.defaultAcademicPeriodId, period.id);
    },
  );

  test(
    'getPreferredAcademicPeriodIdForStudent memilih assignment yang mencakup tanggal',
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

      final periodId = await repository.getPreferredAcademicPeriodIdForStudent(
        student.id,
        referenceDate: dateOnly(2026, 8, 10),
      );

      expect(periodId, assignedPeriod.id);
    },
  );
}
