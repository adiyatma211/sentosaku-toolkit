import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/navigation/app_back_scope.dart';
import '../../../core/showcase/app_showcase.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    startRequestedShowcase(
      context: context,
      ref: ref,
      tour: AppShowcaseTour.reports,
      keys: _reportShowcaseKeys,
    );

    return AppBackScope(
      fallbackPath: '/dashboard',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Laporan'),
          actions: [
            IconButton(
              tooltip: 'Mulai panduan laporan',
              onPressed: () => startAppShowcase(context, _reportShowcaseKeys),
              icon: const Icon(Icons.help_outline_rounded),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(incomeReportProvider);
            ref.invalidate(unpaidReportProvider);
            ref.invalidate(studentReportProvider);
            ref.invalidate(exportReportDataProvider);
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 144),
            children: [
              AppShowcaseTarget(
                showcaseKey: AppShowcaseKeys.reportFilter,
                title: 'Periode laporan',
                description: 'Pilih periode',
                child: _ReportHeroHeader(filterLabel: filterLabel),
              ),
              const SizedBox(height: 18),
              Text(
                'Ringkasan',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              AppShowcaseTarget(
                showcaseKey: AppShowcaseKeys.reportSummary,
                title: 'Ringkasan laporan',
                description: 'Ringkasan laporan',
                child: GridView.count(
                  crossAxisCount: MediaQuery.sizeOf(context).width >= 700
                      ? 4
                      : 2,
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
                        accentColor: Colors.green,
                        compact: true,
                      ),
                      loading: () => const _LoadingCard(title: 'Pendapatan'),
                      error: (error, stackTrace) =>
                          _ErrorCard(message: '$error'),
                    ),
                    unpaidState.when(
                      data: (report) => ReportSummaryCard(
                        title: 'Outstanding',
                        value: currencyFormat.format(report.totalOutstanding),
                        subtitle: '${report.invoiceCount} invoice',
                        icon: Icons.receipt_long,
                        accentColor: colorScheme.error,
                        compact: true,
                      ),
                      loading: () => const _LoadingCard(title: 'Outstanding'),
                      error: (error, stackTrace) =>
                          _ErrorCard(message: '$error'),
                    ),
                    studentState.when(
                      data: (report) => ReportSummaryCard(
                        title: 'Sesi selesai',
                        value: '${report.totalSessions}',
                        subtitle: '${report.rows.length} siswa tercatat',
                        icon: Icons.school,
                        accentColor: colorScheme.primary,
                        compact: true,
                      ),
                      loading: () => const _LoadingCard(title: 'Sesi selesai'),
                      error: (error, stackTrace) =>
                          _ErrorCard(message: '$error'),
                    ),
                    studentState.when(
                      data: (report) => ReportSummaryCard(
                        title: 'Sisa per siswa',
                        value: currencyFormat.format(report.outstandingAmount),
                        subtitle: 'Periode terpilih',
                        icon: Icons.account_balance_wallet,
                        accentColor: colorScheme.tertiary,
                        compact: true,
                      ),
                      loading: () =>
                          const _LoadingCard(title: 'Sisa per siswa'),
                      error: (error, stackTrace) =>
                          _ErrorCard(message: '$error'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              Text(
                'Jenis laporan',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              AppShowcaseTarget(
                showcaseKey: AppShowcaseKeys.reportMenu,
                title: 'Jenis laporan',
                description: 'Buka jenis laporan',
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth >= 860
                        ? 3
                        : constraints.maxWidth >= 560
                        ? 2
                        : 1;
                    return GridView.count(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: columns == 1 ? 1.85 : 1.55,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _ReportMenuCard(
                          title: 'Periode Akademik',
                          subtitle:
                              'Kelola semester, assignment siswa, dan baseline laporan.',
                          badge: 'Academic',
                          icon: Icons.school_outlined,
                          accentColor: colorScheme.secondary,
                          path: '/academic-periods',
                        ),
                        _ReportMenuCard(
                          title: 'Pendapatan',
                          subtitle: 'Pembayaran masuk dan tren pemasukan.',
                          badge: 'Income',
                          icon: Icons.trending_up_rounded,
                          accentColor: Colors.green,
                          path: '/reports/income',
                        ),
                        _ReportMenuCard(
                          title: 'Tagihan Belum Dibayar',
                          subtitle: 'Invoice unpaid/partial dan sisa tagihan.',
                          badge: 'Outstanding',
                          icon: Icons.warning_amber_rounded,
                          accentColor: colorScheme.error,
                          path: '/reports/unpaid',
                        ),
                        _ReportMenuCard(
                          title: 'Per Siswa',
                          subtitle: 'Sesi, tagihan, pembayaran, dan sisa.',
                          badge: 'Student',
                          icon: Icons.groups_rounded,
                          accentColor: colorScheme.primary,
                          path: '/reports/students',
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final _reportShowcaseKeys = [
  AppShowcaseKeys.reportFilter,
  AppShowcaseKeys.reportSummary,
  AppShowcaseKeys.reportMenu,
];

class _ReportHeroHeader extends StatelessWidget {
  const _ReportHeroHeader({required this.filterLabel});

  final String filterLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colorScheme.primary, colorScheme.secondary],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: .22),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -28,
            top: -38,
            child: Icon(
              Icons.analytics_rounded,
              size: 145,
              color: Colors.white.withValues(alpha: .13),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .18),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  filterLabel,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Pusat Laporan',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pantau pendapatan, tagihan belum lunas, dan performa siswa dalam satu tampilan.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: .88),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReportMenuCard extends StatelessWidget {
  const _ReportMenuCard({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.icon,
    required this.accentColor,
    required this.path,
  });

  final String title;
  final String subtitle;
  final String badge;
  final IconData icon;
  final Color accentColor;
  final String path;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go(path),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(icon, color: accentColor),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withValues(
                        alpha: .7,
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      badge,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Buka laporan',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: accentColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                    color: accentColor,
                  ),
                ],
              ),
            ],
          ),
        ),
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
      compact: true,
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
