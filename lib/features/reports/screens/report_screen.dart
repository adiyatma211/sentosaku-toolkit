import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/navigation/app_back_scope.dart';
import '../providers/report_provider.dart';
import '../widgets/report_summary_card.dart';

class ReportScreen extends ConsumerWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incomeState = ref.watch(incomeReportProvider);
    final unpaidState = ref.watch(unpaidReportProvider);
    final studentState = ref.watch(studentReportProvider);
    final filterLabel = ref.watch(reportFilterLabelProvider);
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return AppBackScope(
      fallbackPath: '/dashboard',
      child: Scaffold(
        appBar: AppBar(title: const Text('Laporan')),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(incomeReportProvider);
            ref.invalidate(unpaidReportProvider);
            ref.invalidate(studentReportProvider);
            ref.invalidate(exportReportDataProvider);
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(filterLabel, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: MediaQuery.sizeOf(context).width >= 700 ? 4 : 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  incomeState.when(
                    data: (report) => ReportSummaryCard(
                      title: 'Pendapatan',
                      value: currencyFormat.format(report.totalIncome),
                      subtitle: '${report.totalPayments} pembayaran',
                      icon: Icons.payments,
                    ),
                    loading: () => const _LoadingCard(title: 'Pendapatan'),
                    error: (error, stackTrace) => _ErrorCard(message: '$error'),
                  ),
                  unpaidState.when(
                    data: (report) => ReportSummaryCard(
                      title: 'Outstanding',
                      value: currencyFormat.format(report.totalOutstanding),
                      subtitle: '${report.invoiceCount} invoice',
                      icon: Icons.receipt_long,
                    ),
                    loading: () => const _LoadingCard(title: 'Outstanding'),
                    error: (error, stackTrace) => _ErrorCard(message: '$error'),
                  ),
                  studentState.when(
                    data: (report) => ReportSummaryCard(
                      title: 'Sesi selesai',
                      value: '${report.totalSessions}',
                      subtitle: '${report.rows.length} siswa tercatat',
                      icon: Icons.school,
                    ),
                    loading: () => const _LoadingCard(title: 'Sesi selesai'),
                    error: (error, stackTrace) => _ErrorCard(message: '$error'),
                  ),
                  studentState.when(
                    data: (report) => ReportSummaryCard(
                      title: 'Sisa per siswa',
                      value: currencyFormat.format(report.outstandingAmount),
                      subtitle: 'Periode terpilih',
                      icon: Icons.account_balance_wallet,
                    ),
                    loading: () => const _LoadingCard(title: 'Sisa per siswa'),
                    error: (error, stackTrace) => _ErrorCard(message: '$error'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Jenis laporan',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              _ReportMenuTile(
                title: 'Laporan Pendapatan',
                subtitle: 'Total pembayaran diterima berdasarkan periode',
                icon: Icons.trending_up,
                path: '/reports/income',
              ),
              _ReportMenuTile(
                title: 'Tagihan Belum Dibayar',
                subtitle: 'Daftar invoice unpaid dan partial',
                icon: Icons.warning_amber,
                path: '/reports/unpaid',
              ),
              _ReportMenuTile(
                title: 'Laporan Per Siswa',
                subtitle: 'Sesi, tagihan, pembayaran, dan outstanding',
                icon: Icons.people,
                path: '/reports/students',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportMenuTile extends StatelessWidget {
  const _ReportMenuTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.path,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.go(path),
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ReportSummaryCard(
      title: title,
      value: '...',
      icon: Icons.hourglass_empty,
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return ReportSummaryCard(
      title: 'Gagal memuat',
      value: 'Error',
      subtitle: message,
    );
  }
}
