import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:sentosa_catat_app/core/constants/app_constants.dart';
import 'package:sentosa_catat_app/core/database/app_database.dart';
import 'package:sentosa_catat_app/core/database/database_provider.dart';
import 'package:sentosa_catat_app/features/students/screens/student_form_screen.dart';

import '../../../helpers/pump_app.dart';
import '../../../helpers/seed_data.dart';
import '../../../helpers/test_app_database.dart';

void main() {
  Finder fieldByLabel(String label) {
    return find.byWidgetPredicate(
      (widget) => widget is TextField && widget.decoration?.labelText == label,
    );
  }

  Finder editableTextWithValue(String value) {
    return find.byWidgetPredicate(
      (widget) =>
          widget is EditableText && widget.controller.text.trim() == value,
    );
  }

  Finder academicPeriodDropdown() {
    return find.byWidgetPredicate(
      (widget) => widget is DropdownButtonFormField<int?>,
    );
  }

  testWidgets('validasi nama subject nominal dan wa', (tester) async {
    final database = TestAppDatabase();
    addTearDown(database.close);

    await pumpApp(
      tester,
      const StudentFormScreen(),
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byIcon(Icons.save_outlined).last);
    await tester.tap(find.byIcon(Icons.save_outlined).last);
    await tester.pumpAndSettle();
    expect(find.text('Nama siswa wajib diisi'), findsOneWidget);
    expect(find.text('Mata pelajaran utama wajib diisi'), findsOneWidget);
    expect(find.text('Nominal tarif harus lebih dari 0'), findsOneWidget);

    await tester.enterText(fieldByLabel('Nama siswa *'), 'Alya');
    await tester.enterText(fieldByLabel('Mata pelajaran utama *'), 'Fisika');
    await tester.enterText(fieldByLabel('Nominal tarif *'), '0');
    await tester.enterText(fieldByLabel('WhatsApp'), '08123abc');
    await tester.ensureVisible(find.byIcon(Icons.save_outlined).last);
    await tester.tap(find.byIcon(Icons.save_outlined).last);
    await tester.pumpAndSettle();

    expect(
      find.text('WhatsApp harus angka 8-15 digit jika diisi'),
      findsOneWidget,
    );
    expect(find.text('Nominal tarif harus lebih dari 0'), findsOneWidget);
  });

  testWidgets('mode edit preload data siswa', (tester) async {
    final database = TestAppDatabase();
    addTearDown(database.close);
    final period = await seedAcademicPeriod(
      database,
      name: 'Semester Genap 2025/2026',
    );
    final student = await seedStudent(
      database,
      name: 'Nadia',
      rateType: RateType.monthly,
      rateAmount: 300000,
      whatsapp: '081234567890',
      defaultAcademicPeriodId: period.id,
    );
    await (database.update(
      database.students,
    )..where((t) => t.id.equals(student.id))).write(
      const StudentsCompanion(
        school: Value('SMA 1'),
        grade: Value('12'),
        defaultSubject: Value('Kimia'),
      ),
    );

    await pumpApp(
      tester,
      StudentFormScreen(studentId: student.id),
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    await tester.pumpAndSettle();

    expect(find.text('Edit siswa'), findsOneWidget);
    expect(editableTextWithValue('Nadia'), findsOneWidget);
    expect(editableTextWithValue('Kimia'), findsOneWidget);
    expect(editableTextWithValue('300000'), findsOneWidget);
    expect(editableTextWithValue('081234567890'), findsOneWidget);
    expect(editableTextWithValue('SMA 1'), findsOneWidget);
    expect(find.text('Semester Genap 2025/2026 (aktif)'), findsOneWidget);
  });

  testWidgets('simpan default academic period jika tersedia', (tester) async {
    final database = TestAppDatabase();
    addTearDown(database.close);
    final period = await seedAcademicPeriod(
      database,
      name: 'Semester Ganjil 2026/2027',
    );

    await pumpApp(
      tester,
      const StudentFormScreen(),
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    await tester.pumpAndSettle();

    await tester.enterText(fieldByLabel('Nama siswa *'), 'Rafi');
    await tester.enterText(fieldByLabel('Mata pelajaran utama *'), 'Biologi');
    await tester.enterText(fieldByLabel('Nominal tarif *'), '250000');

    await tester.ensureVisible(academicPeriodDropdown());
    await tester.tap(academicPeriodDropdown());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Semester Ganjil 2026/2027 (aktif)').last);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byIcon(Icons.save_outlined).last);
    await tester.tap(find.byIcon(Icons.save_outlined).last);
    await tester.pumpAndSettle();

    final students = await database.select(database.students).get();
    expect(students, hasLength(1));
    expect(students.single.defaultAcademicPeriodId, period.id);
  });
}
