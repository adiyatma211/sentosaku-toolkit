import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/navigation/app_back_scope.dart';
import '../providers/report_provider.dart';
import '../widgets/report_filter_bar.dart';
import '../widgets/report_summary_card.dart';
import '../widgets/student_report_tile.dart';

class StudentReportScreen extends ConsumerWidget {
  const StudentReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportState = ref.watch(studentReportProvider);
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    final colorScheme = Theme.of(context).colorScheme;

    return AppBackScope(
      fallbackPath: '/reports',
      child: Scaffold(
        appBar: AppBar(title: const Text('Laporan Per Siswa')),
        body: RefreshIndicator(
          onRefresh: () => ref.refresh(studentReportProvider.future),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              const ReportFilterBar(),
              const SizedBox(height: 16),
              reportState.when(
                data: (report) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.count(
                      crossAxisCount: MediaQuery.sizeOf(context).width >= 700
                          ? 4
                          : 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ReportSummaryCard(
                          title: 'Sesi selesai',
                          value: '${report.totalSessions}',
                          icon: Icons.event_available,
                          accentColor: colorScheme.primary,
                          compact: true,
                        ),
                        ReportSummaryCard(
                          title: 'Total tagihan',
                          value: currencyFormat.format(
                            report.totalInvoiceAmount,
                          ),
                          icon: Icons.receipt,
                          accentColor: colorScheme.tertiary,
                          compact: true,
                        ),
                        ReportSummaryCard(
                          title: 'Total bayar',
                          value: currencyFormat.format(report.totalPaidAmount),
                          icon: Icons.payments,
                          accentColor: Colors.green,
                          compact: true,
                        ),
                        ReportSummaryCard(
                          title: 'Outstanding',
                          value: currencyFormat.format(
                            report.outstandingAmount,
                          ),
                          icon: Icons.account_balance_wallet,
                          accentColor: colorScheme.error,
                          compact: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Ringkasan siswa',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        _CountBadge(
                          label: '${report.rows.length} siswa',
                          color: colorScheme.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (report.rows.isEmpty)
                      const _ReportEmptyState(
                        icon: Icons.groups_outlined,
                        title: 'Belum ada data siswa',
                        message: 'Tidak ada aktivitas siswa pada periode ini.',
                      )
                    else
                      ...report.rows.map((row) => StudentReportTile(row: row)),
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
                    child: Text('Gagal memuat laporan per siswa: $error'),
                  ),
                ),
              ),
            ],
          ),
        ),
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
