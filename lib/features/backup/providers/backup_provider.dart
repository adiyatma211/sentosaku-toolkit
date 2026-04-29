import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/logging/logger_provider.dart';
import '../data/backup_repository.dart';

final backupRepositoryProvider = Provider<BackupRepository>((ref) {
  return BackupRepository(
    ref.watch(databaseProvider),
    ref.watch(appLoggerProvider),
  );
});

final backupHistoryProvider = StreamProvider<List<BackupMetadataData>>((ref) {
  return ref.watch(backupRepositoryProvider).watchBackupHistory();
});

final lastBackupProvider = StreamProvider<BackupMetadataData?>((ref) {
  return ref.watch(backupRepositoryProvider).watchLastBackup();
});

final backupNotifierProvider =
    AsyncNotifierProvider.autoDispose<BackupNotifier, BackupMetadataData?>(
      BackupNotifier.new,
    );

class BackupNotifier extends AsyncNotifier<BackupMetadataData?> {
  @override
  Future<BackupMetadataData?> build() async => null;

  Future<BackupMetadataData> createBackup() async {
    state = const AsyncLoading();
    try {
      final backup = await ref.read(backupRepositoryProvider).backupDatabase();
      ref.invalidate(backupHistoryProvider);
      ref.invalidate(lastBackupProvider);
      state = AsyncData(backup);
      return backup;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}

final restoreNotifierProvider =
    AsyncNotifierProvider.autoDispose<RestoreNotifier, void>(
      RestoreNotifier.new,
    );

class RestoreNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> restore(String path) async {
    state = const AsyncLoading();
    try {
      await ref.read(backupRepositoryProvider).restoreDatabase(path);
      ref.invalidate(databaseProvider);
      ref.invalidate(backupRepositoryProvider);
      ref.invalidate(backupHistoryProvider);
      ref.invalidate(lastBackupProvider);
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
