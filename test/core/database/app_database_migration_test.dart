import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:sentosa_catat_app/core/database/app_database.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  test('migrates schema version 5 to latest safely', () async {
    final tempDir = await Directory.systemTemp.createTemp(
      'sentosa_catat_migration_test_',
    );
    final dbFile = File(p.join(tempDir.path, 'migration.sqlite'));

    final sqlite = sqlite3.open(dbFile.path);
    addTearDown(() async {
      if (await dbFile.exists()) {
        await dbFile.delete();
      }
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    sqlite.execute('PRAGMA foreign_keys = OFF;');
    sqlite.execute('PRAGMA user_version = 5;');
    sqlite.execute('''
      CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        parent_name TEXT,
        whatsapp TEXT,
        address TEXT,
        school TEXT,
        grade TEXT,
        default_subject TEXT,
        rate_type TEXT NOT NULL DEFAULT 'per_session',
        rate_amount INTEGER NOT NULL DEFAULT 0,
        status TEXT NOT NULL DEFAULT 'active',
        note TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        deleted_at TEXT
      );
    ''');
    sqlite.execute('''
      CREATE TABLE subjects (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        student_id INTEGER,
        name TEXT NOT NULL,
        default_rate_amount INTEGER NOT NULL DEFAULT 0,
        is_active INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      );
    ''');
    sqlite.execute('''
      CREATE TABLE schedules (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        student_id INTEGER NOT NULL,
        subject_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        start_time TEXT NOT NULL,
        end_time TEXT NOT NULL,
        schedule_type TEXT NOT NULL DEFAULT 'once',
        status TEXT NOT NULL DEFAULT 'scheduled',
        recurrence_group_id TEXT,
        reminder_enabled INTEGER NOT NULL DEFAULT 0,
        note TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        deleted_at TEXT
      );
    ''');
    sqlite.execute('''
      CREATE TABLE sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        schedule_id INTEGER,
        student_id INTEGER NOT NULL,
        subject_id INTEGER NOT NULL,
        session_date TEXT NOT NULL,
        start_time TEXT NOT NULL,
        end_time TEXT NOT NULL,
        attendance_status TEXT NOT NULL DEFAULT 'present',
        material TEXT,
        homework TEXT,
        note TEXT,
        fee_amount INTEGER NOT NULL DEFAULT 0,
        invoice_id INTEGER,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        deleted_at TEXT
      );
    ''');
    sqlite.execute('''
      CREATE TABLE invoices (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        student_id INTEGER NOT NULL,
        session_id INTEGER,
        period_label TEXT NOT NULL DEFAULT '',
        amount INTEGER NOT NULL DEFAULT 0,
        paid_amount INTEGER NOT NULL DEFAULT 0,
        status TEXT NOT NULL DEFAULT 'unpaid',
        due_date TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        deleted_at TEXT
      );
    ''');
    sqlite.execute('''
      CREATE TABLE payments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        invoice_id INTEGER NOT NULL,
        amount INTEGER NOT NULL DEFAULT 0,
        method TEXT NOT NULL DEFAULT 'cash',
        paid_at TEXT NOT NULL,
        note TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        deleted_at TEXT
      );
    ''');
    sqlite.execute('''
      CREATE TABLE settings (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL,
        updated_at TEXT NOT NULL
      );
    ''');
    sqlite.execute('''
      CREATE TABLE backup_metadata (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        file_name TEXT NOT NULL,
        file_path TEXT NOT NULL,
        created_at TEXT NOT NULL
      );
    ''');
    sqlite.dispose();

    final database = AppDatabase(NativeDatabase(dbFile));
    addTearDown(database.close);

    final versionRow = await database
        .customSelect('PRAGMA user_version;')
        .getSingle();
    expect(versionRow.data['user_version'], 8);

    final tableRows = await database
        .customSelect("SELECT name FROM sqlite_master WHERE type = 'table';")
        .get();
    final tableNames = tableRows
        .map((row) => row.data['name'] as String)
        .toSet();

    expect(tableNames, contains('academic_periods'));
    expect(tableNames, contains('student_periods'));
    expect(tableNames, contains('assessments'));
    expect(tableNames, contains('progress_reports'));
    expect(tableNames, contains('reminder_rules'));
    expect(tableNames, contains('reminder_logs'));

    expect(
      await _columnNames(database, 'students'),
      contains('default_academic_period_id'),
    );
    expect(
      await _columnNames(database, 'schedules'),
      containsAll(['academic_period_id', 'last_rescheduled_at']),
    );
    expect(
      await _columnNames(database, 'sessions'),
      containsAll([
        'academic_period_id',
        'progress_note',
        'is_attendance_source',
      ]),
    );
    expect(
      await _columnNames(database, 'invoices'),
      containsAll(['academic_period_id', 'last_reminded_at']),
    );
    expect(
      await _columnNames(database, 'assessments'),
      containsAll([
        'pemahaman_materi',
        'keaktifan_tanya_jawab',
        'ketepatan_kerapian_tugas',
        'konsistensi_kehadiran_fokus',
        'target_materi_drilling',
        'sikap_belajar_respon',
      ]),
    );

    final indexRows = await database
        .customSelect("SELECT name FROM sqlite_master WHERE type = 'index';")
        .get();
    final indexNames = indexRows
        .map((row) => row.data['name'] as String)
        .toSet();
    expect(indexNames, contains('idx_schedules_academic_period_id'));
    expect(indexNames, contains('idx_sessions_schedule_id'));
    expect(indexNames, contains('idx_assessments_session_per_session'));
    expect(indexNames, contains('idx_invoices_due_date'));
  });
}

Future<Set<String>> _columnNames(AppDatabase database, String tableName) async {
  final rows = await database
      .customSelect('PRAGMA table_info($tableName);')
      .get();
  return rows.map((row) => row.data['name'] as String).toSet();
}
