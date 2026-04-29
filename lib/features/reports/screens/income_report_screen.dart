import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/navigation/app_back_scope.dart';
import '../providers/export_report_provider.dart';
import '../providers/report_provider.dart';
import '../widgets/report_filter_bar.dart';
import '../widgets/report_summary_card.dart';

class IncomeReportScreen extends ConsumerWidget {
  const IncomeReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportState = ref.watch(incomeReportProvider);
    final exportState = ref.watch(exportReportNotifierProvider);
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    final dateFormat = DateFormat('dd MMM yyyy HH:mm', 'id_ID');

    return AppBackScope(
      fallbackPath: '/reports',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Laporan Pendapatan'),
          actions: [
            PopupMenuButton<_ExportType>(
              enabled: !exportState.isLoading,
              icon: exportState.isLoading
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.ios_share),
              onSelected: (type) => _exportReport(context, ref, type),
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: _ExportType.pdf,
                  child: Text('Export PDF'),
                ),
                PopupMenuItem(
                  value: _ExportType.csv,
                  child: Text('Export CSV'),
                ),
              ],
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => ref.refresh(incomeReportProvider.future),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const ReportFilterBar(),
              const SizedBox(height: 16),
              reportState.when(
                data: (report) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReportSummaryCard(
                      title: 'Total pendapatan',
                      value: currencyFormat.format(report.totalIncome),
                      subtitle: '${report.totalPayments} pembayaran diterima',
                      icon: Icons.payments,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Detail pembayaran',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    if (report.rows.isEmpty)
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('Belum ada pembayaran pada periode ini.'),
                        ),
                      )
                    else
                      ...report.rows.map(
                        (row) => Card(
                          child: ListTile(
                            title: Text(row.studentName),
                            subtitle: Text(
                              '${dateFormat.format(row.paidAt)} | ${row.method}'
                              '${row.periodLabel == null ? '' : ' | ${row.periodLabel}'}',
                            ),
                            trailing: Text(
                              currencyFormat.format(row.amount),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, stackTrace) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Gagal memuat laporan pendapatan: $error'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _exportReport(
    BuildContext context,
    WidgetRef ref,
    _ExportType type,
  ) async {
    try {
      final notifier = ref.read(exportReportNotifierProvider.notifier);
      final file = switch (type) {
        _ExportType.pdf => await notifier.exportPdf(),
        _ExportType.csv => await notifier.exportCsv(),
      };
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Export berhasil: ${file.path}')));
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Export gagal: $error')));
    }
  }
}

enum _ExportType { pdf, csv }
