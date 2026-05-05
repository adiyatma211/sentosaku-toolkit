import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/feedback/app_toast.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

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
                  value: _ExportType.excel,
                  child: Text('Export Excel (.xlsx)'),
                ),
              ],
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => ref.refresh(incomeReportProvider.future),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
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
                      accentColor: Colors.green,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Detail pembayaran',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        _CountBadge(
                          label: '${report.rows.length} transaksi',
                          color: Colors.green,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (report.rows.isEmpty)
                      const _ReportEmptyState(
                        icon: Icons.payments_outlined,
                        title: 'Belum ada pembayaran',
                        message: 'Tidak ada transaksi masuk pada periode ini.',
                      )
                    else
                      ...report.rows.map(
                        (row) => _PaymentRowCard(
                          studentName: row.studentName,
                          paidAt: dateFormat.format(row.paidAt),
                          method: row.method,
                          periodLabel: row.periodLabel,
                          amount: currencyFormat.format(row.amount),
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
                    child: Text(
                      'Gagal memuat laporan pendapatan: $error',
                      style: TextStyle(color: colorScheme.error),
                    ),
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

class _PaymentRowCard extends StatelessWidget {
  const _PaymentRowCard({
    required this.studentName,
    required this.paidAt,
    required this.method,
    required this.amount,
    this.periodLabel,
  });

  final String studentName;
  final String paidAt;
  final String method;
  final String amount;
  final String? periodLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.green.withValues(alpha: .12),
              foregroundColor: Colors.green,
              child: Text(
                _initial(studentName),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    studentName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _MetaPill(icon: Icons.schedule_outlined, label: paidAt),
                      _MetaPill(icon: Icons.wallet_outlined, label: method),
                      if (periodLabel != null && periodLabel!.isNotEmpty)
                        _MetaPill(
                          icon: Icons.event_note_outlined,
                          label: periodLabel!,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'Diterima',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _initial(String name) {
    final trimmed = name.trim();
    return trimmed.isEmpty ? '?' : trimmed.characters.first.toUpperCase();
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: .65),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 5),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

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
