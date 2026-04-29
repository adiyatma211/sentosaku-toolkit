import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../constants/app_constants.dart';
import 'tables/backup_metadata_table.dart';
import 'tables/invoices_table.dart';
import 'tables/payments_table.dart';
import 'tables/schedules_table.dart';
import 'tables/sessions_table.dart';
import 'tables/settings_table.dart';
import 'tables/students_table.dart';
import 'tables/subjects_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Students,
    Subjects,
    Schedules,
    Sessions,
    Invoices,
    Payments,
    Settings,
    BackupMetadata,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  static const databaseFileName = 'sentosa_catat.sqlite';

  static Future<File> databaseFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File(p.join(directory.path, databaseFileName));
  }

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(students, students.address);
        await migrator.addColumn(students, students.defaultSubject);
        await migrator.addColumn(students, students.note);
      }
      if (from < 3) {
        await migrator.addColumn(schedules, schedules.reminderEnabled);
        await migrator.addColumn(schedules, schedules.note);
      }
      if (from < 4) {
        await migrator.addColumn(sessions, sessions.sessionDate);
        await migrator.addColumn(sessions, sessions.startTime);
        await migrator.addColumn(sessions, sessions.endTime);
        await migrator.addColumn(sessions, sessions.invoiceId);
      }
      if (from < 5) {
        await migrator.addColumn(invoices, invoices.paidAmount);
        await customStatement(
          "UPDATE invoices SET period_label = '' WHERE period_label IS NULL",
        );
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final file = await AppDatabase.databaseFile();
    return NativeDatabase.createInBackground(file);
  });
}
