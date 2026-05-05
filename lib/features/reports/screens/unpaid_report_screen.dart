import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/feedback/app_toast.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

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
                  value: _ExportType.excel,
                  child: Text('Export Excel (.xlsx)'),
                ),
              ],
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => ref.refresh(unpaidReportProvider.future),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
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
                      accentColor: colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Daftar invoice',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        _CountBadge(
                          label: '${report.rows.length} invoice',
                          color: colorScheme.error,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (report.rows.isEmpty)
                      const _ReportEmptyState(
                        icon: Icons.task_alt_rounded,
                        title: 'Semua tagihan aman',
                        message: 'Tidak ada tagihan belum dibayar saat ini.',
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
        _ExportType.excel => await notifier.exportExcel(),
      };
      if (!context.mounted) return;
      AppToast.success(context, 'Export berhasil', details: file.path);
    } catch (error) {
      if (!context.mounted) return;
      AppToast.error(context, 'Export gagal', details: '$error');
    }
  }
}

enum _ExportType { pdf, excel }

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _ReportEmptyState extends StatelessWidget {
  const _ReportEmptyState({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            Icon(icon, size: 36, color: colorScheme.primary),
            const SizedBox(height: 10),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 4),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
