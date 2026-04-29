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

    return AppBackScope(
      fallbackPath: '/reports',
      child: Scaffold(
        appBar: AppBar(title: const Text('Laporan Per Siswa')),
        body: RefreshIndicator(
          onRefresh: () => ref.refresh(studentReportProvider.future),
          child: ListView(
            padding: const EdgeInsets.all(16),
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
                        ),
                        ReportSummaryCard(
                          title: 'Total tagihan',
                          value: currencyFormat.format(
                            report.totalInvoiceAmount,
                          ),
                          icon: Icons.receipt,
                        ),
                        ReportSummaryCard(
                          title: 'Total bayar',
                          value: currencyFormat.format(report.totalPaidAmount),
                          icon: Icons.payments,
                        ),
                        ReportSummaryCard(
                          title: 'Outstanding',
                          value: currencyFormat.format(
                            report.outstandingAmount,
                          ),
                          icon: Icons.account_balance_wallet,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Ringkasan siswa',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    if (report.rows.isEmpty)
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('Belum ada data siswa pada periode ini.'),
                        ),
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
