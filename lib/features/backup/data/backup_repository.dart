import 'dart:io';

import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../core/database/app_database.dart';
import '../../../core/logging/app_logger.dart';

class BackupRepository {
  const BackupRepository(this._database, this._logger);

  final AppDatabase _database;
  final AppLogger _logger;

  Future<File> getDatabaseFile() => AppDatabase.databaseFile();

  Future<BackupMetadataData> backupDatabase() async {
    const action = 'backup.backupDatabase';
    final logData = <String, Object?>{};
    _logger.logTransactionStart(action, logData);
    try {
      final source = await getDatabaseFile();
      if (!await source.exists()) {
        throw StateError('File database tidak ditemukan.');
      }

      await _database.customStatement('PRAGMA wal_checkpoint(TRUNCATE)');

      final backupDirectory = await _backupDirectory();
      final timestamp = DateFormat(
        'yyyy-MM-dd_HH-mm-ss',
      ).format(DateTime.now());
      final fileName = 'backup_private_teacher_$timestamp.db';
      final destination = File(p.join(backupDirectory.path, fileName));

      await source.copy(destination.path);

      final companion = BackupMetadataCompanion.insert(
        fileName: fileName,
        filePath: destination.path,
        createdAt: Value(DateTime.now()),
      );
      final id = await _database
          .into(_database.backupMetadata)
          .insert(companion);
      final backup = BackupMetadataData(
        id: id,
        fileName: fileName,
        filePath: destination.path,
        createdAt: companion.createdAt.value,
      );
      _logger.logTransactionSuccess(action, {
        'backupId': id,
        'fileName': fileName,
        'filePath': destination.path,
      });
      return backup;
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Stream<List<BackupMetadataData>> watchBackupHistory() {
    return (_database.select(_database.backupMetadata)..orderBy([
          (table) => OrderingTerm.desc(table.createdAt),
          (table) => OrderingTerm.desc(table.id),
        ]))
        .watch();
  }

  Stream<BackupMetadataData?> watchLastBackup() {
    final query = _database.select(_database.backupMetadata)
      ..orderBy([
        (table) => OrderingTerm.desc(table.createdAt),
        (table) => OrderingTerm.desc(table.id),
      ])
      ..limit(1);
    return query.watchSingleOrNull();
  }

  Future<void> validateRestoreFile(String path) async {
    final normalizedPath = path.trim();
    if (normalizedPath.isEmpty) {
      throw ArgumentError('Path file restore wajib diisi.');
    }

    final extension = p.extension(normalizedPath).toLowerCase();
    if (extension != '.db' && extension != '.sqlite') {
      throw ArgumentError('File restore harus berformat .db atau .sqlite.');
    }

    final file = File(normalizedPath);
    if (!await file.exists()) {
      throw ArgumentError('File restore tidak ditemukan.');
    }
    if (await file.length() <= 0) {
      throw ArgumentError('File restore kosong.');
    }

    final activeDatabaseFile = await getDatabaseFile();
    if (p.equals(
      p.normalize(file.absolute.path),
      p.normalize(activeDatabaseFile.absolute.path),
    )) {
      throw ArgumentError('File restore tidak boleh memakai database aktif.');
    }

    _validateSqliteDatabase(normalizedPath);
  }

  void _validateSqliteDatabase(String path) {
    const requiredTables = {
      'students',
      'subjects',
      'schedules',
      'sessions',
      'invoices',
      'payments',
      'settings',
    };

    Database? sqlite;
    try {
      sqlite = sqlite3.open(path, mode: OpenMode.readOnly);
      final integrity = sqlite.select('PRAGMA integrity_check').first.values.first;
      if (integrity != 'ok') {
        throw StateError('Integrity check gagal: $integrity');
      }

      final userVersion = sqlite.userVersion;
      if (userVersion <= 0) {
        throw StateError('Versi database backup tidak dikenali.');
      }
      if (userVersion > _database.schemaVersion) {
        throw StateError(
          'Backup dibuat oleh versi aplikasi lebih baru (schema $userVersion).',
        );
      }

      final rows = sqlite.select(
        "SELECT name FROM sqlite_master WHERE type = 'table'",
      );
      final tableNames = rows.map((row) => row['name'] as String).toSet();
      final missingTables = requiredTables.difference(tableNames);
      if (missingTables.isNotEmpty) {
        throw StateError(
          'Backup tidak memiliki tabel aplikasi: ${missingTables.join(', ')}.',
        );
      }
    } catch (error) {
      throw ArgumentError('File restore bukan database SQLite valid: $error');
    } finally {
      sqlite?.dispose();
    }
  }

  Future<File> restoreDatabase(String path) async {
    const action = 'backup.restoreDatabase';
    final logData = {'restorePath': path.trim()};
    _logger.logTransactionStart(action, logData);
    try {
      await validateRestoreFile(path);

      final databaseFile = await getDatabaseFile();
      final backupDirectory = await _backupDirectory();
      final timestamp = DateFormat(
        'yyyy-MM-dd_HH-mm-ss',
      ).format(DateTime.now());
      final safetyBackup = File(
        p.join(backupDirectory.path, 'safety_before_restore_$timestamp.db'),
      );

      if (await databaseFile.exists()) {
        await _database.customStatement('PRAGMA wal_checkpoint(TRUNCATE)');
        await databaseFile.copy(safetyBackup.path);
      }

      await _database.close();

      try {
        await _deleteSidecarFiles(databaseFile.path);
        await File(path.trim()).copy(databaseFile.path);
        _validateSqliteDatabase(databaseFile.path);
      } catch (_) {
        if (await safetyBackup.exists()) {
          await safetyBackup.copy(databaseFile.path);
        }
        rethrow;
      }
      _logger.logTransactionSuccess(action, {
        ...logData,
        'safetyBackupPath': safetyBackup.path,
      });
      return safetyBackup;
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Future<Directory> _backupDirectory() async {
    final documents = await getApplicationDocumentsDirectory();
    final directory = Directory(p.join(documents.path, 'backups'));
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory;
  }

  Future<void> _deleteSidecarFiles(String databasePath) async {
    for (final path in ['$databasePath-wal', '$databasePath-shm']) {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    }
  }
}
