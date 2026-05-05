import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/logging/logger_provider.dart';
import '../../academic/providers/academic_period_provider.dart';
import '../../academic/providers/assessment_provider.dart';
import '../../academic/providers/progress_report_provider.dart';
import '../../dashboard/providers/dashboard_provider.dart';
import '../../payments/providers/payment_provider.dart';
import '../../reports/providers/report_provider.dart';
import '../../schedules/providers/schedule_provider.dart';
import '../../schedules/providers/subject_provider.dart';
import '../../sessions/providers/session_provider.dart';
import '../../students/providers/student_provider.dart';
import '../data/backup_repository.dart';

class BackupStatus {
  const BackupStatus({
    required this.lastBackup,
    required this.fileExists,
    required this.fileSizeBytes,
    required this.age,
  });

  final BackupMetadataData? lastBackup;
  final bool fileExists;
  final int? fileSizeBytes;
  final Duration? age;

  bool get hasBackup => lastBackup != null;
  bool get isStale => age != null && age! > const Duration(days: 7);
  bool get hasWarning => !hasBackup || isStale || !fileExists;

  String get warningMessage {
    if (!hasBackup) return 'Belum ada backup. Buat backup pertama sekarang.';
    if (!fileExists) {
      return 'Metadata backup ada, tetapi file backup terakhir tidak ditemukan.';
    }
    if (isStale) return 'Backup terakhir sudah lebih dari 7 hari.';
    return 'Backup terakhir tersedia dan masih baru.';
  }
}

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

final backupStatusProvider = FutureProvider<BackupStatus>((ref) async {
  final lastBackup = await ref.watch(lastBackupProvider.future);
  if (lastBackup == null) {
    return const BackupStatus(
      lastBackup: null,
      fileExists: false,
      fileSizeBytes: null,
      age: null,
    );
  }

  final file = File(lastBackup.filePath);
  final exists = await file.exists();
  return BackupStatus(
    lastBackup: lastBackup,
    fileExists: exists,
    fileSizeBytes: exists ? await file.length() : null,
    age: DateTime.now().difference(lastBackup.createdAt),
  );
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
      ref.invalidate(backupStatusProvider);
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
      _invalidateDatabaseDependents();
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      ref.invalidate(databaseProvider);
      state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  void _invalidateDatabaseDependents() {
    ref.invalidate(databaseProvider);
    ref.invalidate(studentRepositoryProvider);
    ref.invalidate(studentsProvider);
    ref.invalidate(activeStudentsProvider);
    ref.invalidate(subjectRepositoryProvider);
    ref.invalidate(activeSubjectsProvider);
    ref.invalidate(subjectsByStudentProvider);
    ref.invalidate(scheduleRepositoryProvider);
    ref.invalidate(todaySchedulesProvider);
    ref.invalidate(scheduleByDateProvider);
    ref.invalidate(sessionRepositoryProvider);
    ref.invalidate(sessionsProvider);
    ref.invalidate(studentSessionsProvider);
    ref.invalidate(studentAttendanceRecapProvider);
    ref.invalidate(paymentRepositoryProvider);
    ref.invalidate(unpaidInvoicesProvider);
    ref.invalidate(dueSoonInvoicesProvider);
    ref.invalidate(overdueInvoicesProvider);
    ref.invalidate(invoicesProvider);
    ref.invalidate(academicPeriodRepositoryProvider);
    ref.invalidate(academicPeriodsProvider);
    ref.invalidate(assessmentRepositoryProvider);
    ref.invalidate(assessmentReviewItemsProvider);
    ref.invalidate(assessmentSummaryProvider);
    ref.invalidate(progressReportRepositoryProvider);
    ref.invalidate(studentProgressReportsProvider);
    ref.invalidate(studentPeriodProgressReportProvider);
    ref.invalidate(reportRepositoryProvider);
    ref.invalidate(incomeReportProvider);
    ref.invalidate(unpaidReportProvider);
    ref.invalidate(attendanceReportProvider);
    ref.invalidate(studentReportProvider);
    ref.invalidate(exportReportDataProvider);
    ref.invalidate(dashboardRepositoryProvider);
    ref.invalidate(dashboardSummaryProvider);
    ref.invalidate(backupRepositoryProvider);
    ref.invalidate(backupHistoryProvider);
    ref.invalidate(lastBackupProvider);
    ref.invalidate(backupStatusProvider);
  }
}
