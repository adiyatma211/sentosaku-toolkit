import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentosa_catat_app/core/database/database_provider.dart';
import 'package:sentosa_catat_app/features/sessions/screens/session_form_screen.dart';

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

  testWidgets('render info jadwal dan detail dasar', (tester) async {
    final database = TestAppDatabase();
    addTearDown(database.close);
    final student = await seedStudent(
      database,
      name: 'Alya',
      rateAmount: 175000,
    );
    final subject = await seedSubject(
      database,
      studentId: student.id,
      name: 'Matematika',
    );
    final schedule = await seedSchedule(
      database,
      studentId: student.id,
      subjectId: subject.id,
      date: dateOnly(2026, 4, 10),
      startTime: timeOn(dateOnly(2026, 4, 10), 9),
      endTime: timeOn(dateOnly(2026, 4, 10), 10, 30),
    );

    await pumpApp(
      tester,
      SessionFormScreen(scheduleId: schedule.id),
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    await tester.pumpAndSettle();

    expect(find.text('Alya'), findsOneWidget);
    expect(find.text('Matematika'), findsOneWidget);
    expect(find.text('10 April 2026'), findsOneWidget);
    expect(find.text('09.00 - 10.30'), findsOneWidget);
    expect(editableTextWithValue('175000'), findsOneWidget);
    expect(find.text('Assessment terstruktur'), findsOneWidget);
    expect(find.text('Simpan sesi'), findsOneWidget);
  });

  testWidgets('validasi lalu submit sukses dasar', (tester) async {
    final database = TestAppDatabase();
    addTearDown(database.close);
    final student = await seedStudent(database, rateAmount: 150000);
    final subject = await seedSubject(database, studentId: student.id);
    final schedule = await seedSchedule(
      database,
      studentId: student.id,
      subjectId: subject.id,
      date: dateOnly(2026, 4, 11),
    );

    await pumpApp(
      tester,
      SessionFormScreen(scheduleId: schedule.id),
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    await tester.pumpAndSettle();

    await tester.enterText(fieldByLabel('Biaya sesi'), '');
    await tester.tap(find.text('Simpan sesi'));
    await tester.pumpAndSettle();
    expect(find.text('Biaya wajib diisi'), findsOneWidget);

    await tester.enterText(fieldByLabel('Biaya sesi'), '150000');
    await tester.enterText(fieldByLabel('Materi'), 'Turunan');
    await tester.enterText(
      fieldByLabel('Pemahaman materi'),
      'Sudah memahami turunan dasar.',
    );
    await tester.tap(find.text('Simpan sesi'));
    await tester.pumpAndSettle();

    final sessions = await database.select(database.sessions).get();
    final assessments = await database.select(database.assessments).get();
    expect(sessions, hasLength(1));
    expect(assessments, hasLength(1));
    expect(assessments.single.pemahamanMateri, 'Sudah memahami turunan dasar.');
    expect(find.text('session-${sessions.single.id}'), findsOneWidget);
  });

  testWidgets('jadwal tidak ditemukan state', (tester) async {
    final database = TestAppDatabase();
    addTearDown(database.close);

    await pumpApp(
      tester,
      const SessionFormScreen(scheduleId: 999),
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    await tester.pumpAndSettle();

    expect(find.text('Jadwal tidak ditemukan.'), findsOneWidget);
  });
}
