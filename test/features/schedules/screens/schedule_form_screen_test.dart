import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:sentosa_catat_app/core/database/app_database.dart';
import 'package:sentosa_catat_app/core/database/database_provider.dart';
import 'package:sentosa_catat_app/features/schedules/providers/schedule_provider.dart';
import 'package:sentosa_catat_app/features/schedules/screens/schedule_form_screen.dart';

import '../../../helpers/fakes/fake_local_reminder_service.dart';
import '../../../helpers/pump_app.dart';
import '../../../helpers/seed_data.dart';
import '../../../helpers/test_app_database.dart';

void main() {
  Finder fieldByLabel(String label) {
    return find.byWidgetPredicate(
      (widget) => widget is TextField && widget.decoration?.labelText == label,
    );
  }

  testWidgets('empty state jika belum ada siswa aktif', (tester) async {
    final database = TestAppDatabase();
    addTearDown(database.close);

    await pumpApp(
      tester,
      const ScheduleFormScreen(),
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    await tester.pumpAndSettle();

    expect(find.text('Belum ada siswa aktif'), findsOneWidget);
    expect(find.text('Tambah siswa'), findsOneWidget);
  });

  testWidgets('pilih siswa isi default subject jika kosong', (tester) async {
    final database = TestAppDatabase();
    addTearDown(database.close);
    final student = await seedStudent(
      database,
      name: 'Citra',
      rateAmount: 150000,
    );
    await (database.update(database.students)
          ..where((t) => t.id.equals(student.id)))
        .write(const StudentsCompanion(defaultSubject: Value('Fisika')));

    await pumpApp(
      tester,
      const ScheduleFormScreen(),
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DropdownButtonFormField<int>).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Citra').last);
    await tester.pumpAndSettle();

    expect(find.text('Fisika'), findsOneWidget);
  });

  testWidgets('validasi repeatCount weekly', (tester) async {
    final database = TestAppDatabase();
    addTearDown(database.close);
    await seedStudent(database, name: 'Dewi');

    await pumpApp(
      tester,
      const ScheduleFormScreen(),
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DropdownButtonFormField<int>).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dewi').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DropdownButtonFormField<String>).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mingguan').last);
    await tester.pumpAndSettle();

    await tester.enterText(fieldByLabel('Jumlah pengulangan *'), '0');
    await tester.ensureVisible(find.byIcon(Icons.save_outlined).last);
    await tester.tap(find.byIcon(Icons.save_outlined).last);
    await tester.pump();

    expect(find.text('Jumlah pengulangan harus lebih dari 0'), findsOneWidget);
  });

  testWidgets('validasi jam selesai lebih besar dari jam mulai', (
    tester,
  ) async {
    final database = TestAppDatabase();
    addTearDown(database.close);
    await seedStudent(database, name: 'Fajar');
    final reminder = FakeLocalReminderService();

    await pumpApp(
      tester,
      ScheduleFormScreen(
        initialDate: DateTime(2026, 4, 10),
        initialStartTime: TimeOfDay(hour: 16, minute: 0),
        initialEndTime: TimeOfDay(hour: 15, minute: 0),
      ),
      overrides: [
        databaseProvider.overrideWithValue(database),
        localReminderServiceProvider.overrideWithValue(reminder),
      ],
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DropdownButtonFormField<int>).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fajar').last);
    await tester.pumpAndSettle();
    await tester.enterText(fieldByLabel('Mata pelajaran *'), 'Matematika');
    await tester.ensureVisible(find.byIcon(Icons.save_outlined).last);
    await tester.tap(find.byIcon(Icons.save_outlined).last);

    final savedSchedules = await database.select(database.schedules).get();
    expect(savedSchedules, isEmpty);
    expect(reminder.scheduledSchedules, isEmpty);
  });
}
