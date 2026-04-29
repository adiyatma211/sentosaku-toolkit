import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../data/report_models.dart';
import '../data/report_repository.dart';

final reportRepositoryProvider = Provider<ReportRepository>((ref) {
  return ReportRepository(ref.watch(databaseProvider));
});

final reportFilterProvider =
    NotifierProvider<ReportFilterNotifier, ReportFilter>(
      ReportFilterNotifier.new,
    );

class ReportFilterNotifier extends Notifier<ReportFilter> {
  @override
  ReportFilter build() => ReportFilter.currentMonth();

  void setToday() {
    state = ReportFilter.today().copyWith(
      studentId: state.studentId,
      subjectId: state.subjectId,
    );
  }

  void setThisWeek() {
    state = ReportFilter.thisWeek().copyWith(
      studentId: state.studentId,
      subjectId: state.subjectId,
    );
  }

  void setThisMonth() {
    state = ReportFilter.currentMonth().copyWith(
      studentId: state.studentId,
      subjectId: state.subjectId,
    );
  }

  void setCustomRange(DateTime startDate, DateTime endDate) {
    final normalizedStart = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );
    final normalizedEnd = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
    ).add(const Duration(days: 1));
    state = state.copyWith(
      startDate: normalizedStart,
      endDate: normalizedEnd,
      filterType: ReportFilterType.custom,
    );
  }

  void setStudent(int? studentId) {
    state = state.copyWith(
      studentId: studentId,
      clearStudent: studentId == null,
    );
  }

  void setSubject(int? subjectId) {
    state = state.copyWith(
      subjectId: subjectId,
      clearSubject: subjectId == null,
    );
  }
}

final incomeReportProvider = FutureProvider<IncomeReport>((ref) {
  final filter = ref.watch(reportFilterProvider);
  return ref.watch(reportRepositoryProvider).getIncomeReport(filter);
});

final unpaidReportProvider = FutureProvider<UnpaidReport>((ref) {
  return ref.watch(reportRepositoryProvider).getUnpaidReport();
});

final studentReportProvider = FutureProvider<StudentReport>((ref) {
  final filter = ref.watch(reportFilterProvider);
  return ref.watch(reportRepositoryProvider).getStudentReport(filter);
});

final exportReportDataProvider = FutureProvider<ExportReportData>((ref) {
  final filter = ref.watch(reportFilterProvider);
  return ref.watch(reportRepositoryProvider).getExportData(filter);
});

final reportFilterLabelProvider = Provider<String>((ref) {
  final repository = ref.watch(reportRepositoryProvider);
  final filter = ref.watch(reportFilterProvider);
  return repository.filterLabel(filter);
});
