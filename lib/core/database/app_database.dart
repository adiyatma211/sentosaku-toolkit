import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../constants/app_constants.dart';
import 'tables/academic_periods_table.dart';
import 'tables/assessments_table.dart';
import 'tables/backup_metadata_table.dart';
import 'tables/invoices_table.dart';
import 'tables/payments_table.dart';
import 'tables/progress_reports_table.dart';
import 'tables/reminder_logs_table.dart';
import 'tables/reminder_rules_table.dart';
import 'tables/schedules_table.dart';
import 'tables/sessions_table.dart';
import 'tables/settings_table.dart';
import 'tables/student_periods_table.dart';
import 'tables/students_table.dart';
import 'tables/subjects_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Students,
    Subjects,
    AcademicPeriods,
    StudentPeriods,
    Schedules,
    Sessions,
    Assessments,
    Invoices,
    Payments,
    ProgressReports,
    ReminderRules,
    ReminderLogs,
    Settings,
    BackupMetadata,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  static const databaseFileName = 'sentosa_catat.sqlite';

  static Future<File> databaseFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File(p.join(directory.path, databaseFileName));
  }

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
      await _createBaselineIndexes();
    },
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
      if (from < 6) {
        await migrator.createTable(academicPeriods);
        await migrator.createTable(studentPeriods);
        await migrator.createTable(assessments);
        await migrator.createTable(progressReports);
        await migrator.createTable(reminderRules);
        await migrator.createTable(reminderLogs);

        await migrator.addColumn(students, students.defaultAcademicPeriodId);
        await migrator.addColumn(schedules, schedules.academicPeriodId);
        await migrator.addColumn(schedules, schedules.lastRescheduledAt);
        await migrator.addColumn(sessions, sessions.academicPeriodId);
        await migrator.addColumn(sessions, sessions.progressNote);
        await migrator.addColumn(sessions, sessions.isAttendanceSource);
        await migrator.addColumn(invoices, invoices.academicPeriodId);
        await migrator.addColumn(invoices, invoices.lastRemindedAt);
      }
      if (from < 7) {
        await migrator.addColumn(schedules, schedules.reminderOffsetMinutes);
      }
      if (from < 8) {
        await customStatement(
          'ALTER TABLE assessments RENAME TO assessments_old;',
        );
        await migrator.createTable(assessments);
        await customStatement('''
          INSERT INTO assessments (
            id,
            session_id,
            student_id,
            academic_period_id,
            assessment_type,
            review_cycle_label,
            pemahaman_materi,
            keaktifan_tanya_jawab,
            ketepatan_kerapian_tugas,
            konsistensi_kehadiran_fokus,
            target_materi_drilling,
            sikap_belajar_respon,
            summary_note,
            created_at,
            updated_at,
            deleted_at
          )
          SELECT
            id,
            session_id,
            student_id,
            academic_period_id,
            assessment_type,
            review_cycle_label,
            CASE WHEN pemahaman_materi = 0 THEN NULL ELSE CAST(pemahaman_materi AS TEXT) END,
            CASE WHEN keaktifan_tanya_jawab = 0 THEN NULL ELSE CAST(keaktifan_tanya_jawab AS TEXT) END,
            CASE WHEN ketepatan_kerapian_tugas = 0 THEN NULL ELSE CAST(ketepatan_kerapian_tugas AS TEXT) END,
            CASE WHEN konsistensi_kehadiran_fokus = 0 THEN NULL ELSE CAST(konsistensi_kehadiran_fokus AS TEXT) END,
            CASE WHEN target_materi_drilling = 0 THEN NULL ELSE CAST(target_materi_drilling AS TEXT) END,
            CASE WHEN sikap_belajar_respon = 0 THEN NULL ELSE CAST(sikap_belajar_respon AS TEXT) END,
            summary_note,
            created_at,
            updated_at,
            deleted_at
          FROM assessments_old;
        ''');
        await customStatement('DROP TABLE assessments_old;');
      }

      await _createBaselineIndexes();
    },
  );

  Future<void> _createBaselineIndexes() async {
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_student_periods_student_id ON student_periods (student_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_student_periods_academic_period_id ON student_periods (academic_period_id)',
    );
    await customStatement(
      'CREATE UNIQUE INDEX IF NOT EXISTS idx_student_periods_student_period_unique ON student_periods (student_id, academic_period_id) WHERE deleted_at IS NULL',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_schedules_student_id ON schedules (student_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_schedules_academic_period_id ON schedules (academic_period_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_sessions_schedule_id ON sessions (schedule_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_sessions_student_id ON sessions (student_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_sessions_academic_period_id ON sessions (academic_period_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_assessments_session_id ON assessments (session_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_assessments_student_id ON assessments (student_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_assessments_academic_period_id ON assessments (academic_period_id)',
    );
    await customStatement(
      "CREATE UNIQUE INDEX IF NOT EXISTS idx_assessments_session_per_session ON assessments (session_id, assessment_type) WHERE session_id IS NOT NULL AND deleted_at IS NULL AND assessment_type = 'session'",
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_invoices_session_id ON invoices (session_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_invoices_student_id ON invoices (student_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_invoices_academic_period_id ON invoices (academic_period_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_invoices_due_date ON invoices (due_date)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_progress_reports_student_id ON progress_reports (student_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_progress_reports_academic_period_id ON progress_reports (academic_period_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_reminder_logs_reference ON reminder_logs (reference_table, reference_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_reminder_logs_scheduled_at ON reminder_logs (scheduled_at)',
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final file = await AppDatabase.databaseFile();
    return NativeDatabase.createInBackground(file);
  });
}
