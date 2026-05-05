import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/logging/logger_provider.dart';
import '../data/export_service.dart';
import 'report_provider.dart';

final exportServiceProvider = Provider<ExportService>((ref) {
  return ExportService(ref.watch(appLoggerProvider));
});

final exportReportNotifierProvider =
    AsyncNotifierProvider.autoDispose<ExportReportNotifier, File?>(
      ExportReportNotifier.new,
    );

class ExportReportNotifier extends AsyncNotifier<File?> {
  @override
  Future<File?> build() async => null;

  Future<File> exportPdf() async {
    state = const AsyncLoading();
    try {
      final filter = ref.read(reportFilterProvider);
      final data = await ref
          .read(reportRepositoryProvider)
          .getExportData(filter);
      final file = await ref.read(exportServiceProvider).exportPdf(data);
      state = AsyncData(file);
      return file;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<File> exportCsv() async {
    state = const AsyncLoading();
    try {
      final filter = ref.read(reportFilterProvider);
      final data = await ref
          .read(reportRepositoryProvider)
          .getExportData(filter);
      final file = await ref.read(exportServiceProvider).exportCsv(data);
      state = AsyncData(file);
      return file;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<File> exportExcel() async {
    state = const AsyncLoading();
    try {
      final filter = ref.read(reportFilterProvider);
      final data = await ref
          .read(reportRepositoryProvider)
          .getExportData(filter);
      final file = await ref.read(exportServiceProvider).exportExcel(data);
      state = AsyncData(file);
      return file;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
