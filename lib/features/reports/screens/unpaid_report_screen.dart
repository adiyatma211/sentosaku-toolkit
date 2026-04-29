import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/navigation/app_back_scope.dart';
import '../providers/export_report_provider.dart';
import '../providers/report_provider.dart';
import '../widgets/report_summary_card.dart';
import '../widgets/unpaid_invoice_tile.dart';

class UnpaidReportScreen extends ConsumerWidget {
  const UnpaidReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportState = ref.watch(unpaidReportProvider);
    final exportState = ref.watch(exportReportNotifierProvider);
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return AppBackScope(
      fallbackPath: '/reports',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tagihan Belum Dibayar'),
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
          onRefresh: () => ref.refresh(unpaidReportProvider.future),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              reportState.when(
                data: (report) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReportSummaryCard(
                      title: 'Total outstanding',
                      value: currencyFormat.format(report.totalOutstanding),
                      subtitle: '${report.invoiceCount} invoice belum lunas',
                      icon: Icons.receipt_long,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Daftar invoice',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    if (report.rows.isEmpty)
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('Tidak ada tagihan belum dibayar.'),
                        ),
                      )
                    else
                      ...report.rows.map((row) => UnpaidInvoiceTile(row: row)),
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
                    child: Text('Gagal memuat tagihan belum dibayar: $error'),
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
