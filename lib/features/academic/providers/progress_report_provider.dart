import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/logging/logger_provider.dart';
import '../data/progress_report_repository.dart';
import 'assessment_provider.dart';

final progressReportRepositoryProvider = Provider<ProgressReportRepository>((
  ref,
) {
  return ProgressReportRepository(
    ref.watch(databaseProvider),
    ref.watch(appLoggerProvider),
    ref.watch(assessmentRepositoryProvider),
  );
});

final studentProgressReportsProvider =
    StreamProvider.family<List<ProgressReport>, int>((ref, studentId) {
      return ref
          .watch(progressReportRepositoryProvider)
          .watchStudentReports(studentId);
    });

final studentPeriodProgressReportProvider =
    StreamProvider.family<ProgressReport?, StudentPeriodKey>((ref, key) {
      return ref
          .watch(progressReportRepositoryProvider)
          .watchStudentPeriodReport(key.studentId, key.academicPeriodId);
    });

final progressReportSnapshotProvider =
    Provider.family<ProgressReportSnapshot?, ProgressReport?>((ref, report) {
      if (report == null) return null;
      return ProgressReportSnapshot(
        report: report,
        attendanceSummary: (jsonDecode(report.attendanceSummaryJson) as Map)
            .cast<String, dynamic>(),
        assessmentSummary: (jsonDecode(report.assessmentSummaryJson) as Map)
            .cast<String, dynamic>(),
      );
    });

final progressReportNotifierProvider =
    AsyncNotifierProvider.autoDispose<ProgressReportNotifier, void>(
      ProgressReportNotifier.new,
    );

class ProgressReportNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<ProgressReportSnapshot> generate(
    int studentId,
    int academicPeriodId, {
    String? teacherNote,
    String status = 'draft',
  }) async {
    state = const AsyncLoading();
    try {
      final snapshot = await ref
          .read(progressReportRepositoryProvider)
          .generateProgressReport(
            studentId,
            academicPeriodId,
            teacherNote: teacherNote,
            status: status,
          );
      state = const AsyncData(null);
      return snapshot;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> updateTeacherNote(
    int reportId,
    String? teacherNote, {
    String? status,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref
          .read(progressReportRepositoryProvider)
          .updateTeacherNote(reportId, teacherNote, status: status);
    });
  }
}
