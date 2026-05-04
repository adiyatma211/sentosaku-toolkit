import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' show Value;
import 'package:sentosa_catat_app/core/constants/app_constants.dart';
import 'package:sentosa_catat_app/core/database/app_database.dart';
import 'package:sentosa_catat_app/core/logging/app_logger.dart';
import 'package:sentosa_catat_app/features/students/data/student_repository.dart';

import '../../../helpers/seed_data.dart';
import '../../../helpers/test_app_database.dart';

void main() {
  late TestAppDatabase database;
  late StudentRepository repository;

  setUp(() {
    database = TestAppDatabase();
    repository = StudentRepository(database, AppLogger());
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'insertStudent menyimpan default academic period yang tersedia',
    () async {
      final period = await seedAcademicPeriod(database);

      final id = await repository.insertStudent(
        StudentFormData(
          name: 'Alya',
          defaultSubject: 'Matematika',
          defaultAcademicPeriodId: period.id,
          rateType: RateType.monthly,
          rateAmount: 400000,
          status: StudentStatus.active,
        ),
      );

      final student = await (database.select(
        database.students,
      )..where((t) => t.id.equals(id))).getSingle();

      expect(student.defaultAcademicPeriodId, period.id);
    },
  );

  test(
    'updateStudent mempertahankan null jika academic period tidak valid',
    () async {
      final student = await seedStudent(database);

      await repository.updateStudent(
        student.id,
        const StudentFormData(
          name: 'Budi Update',
          defaultSubject: 'Fisika',
          defaultAcademicPeriodId: 999999,
          rateType: RateType.perSession,
          rateAmount: 175000,
          status: StudentStatus.active,
        ),
      );

      final updated = await (database.select(
        database.students,
      )..where((t) => t.id.equals(student.id))).getSingle();

      expect(updated.defaultAcademicPeriodId, isNull);
    },
  );

  test('watchAcademicPeriods hanya menampilkan periode non deleted', () async {
    final activePeriod = await seedAcademicPeriod(
      database,
      name: 'Semester Aktif',
      isActive: true,
    );
    final oldPeriod = await seedAcademicPeriod(
      database,
      name: 'Semester Lama',
      isActive: false,
    );
    await (database.update(database.academicPeriods)
          ..where((t) => t.id.equals(oldPeriod.id)))
        .write(AcademicPeriodsCompanion(deletedAt: Value(DateTime.now())));

    final periods = await repository.watchAcademicPeriods().first;

    expect(periods.map((period) => period.id), [activePeriod.id]);
  });
}
