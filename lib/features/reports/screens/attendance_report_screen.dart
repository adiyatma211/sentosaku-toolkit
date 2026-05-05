import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/navigation/app_back_scope.dart';
import '../data/report_models.dart';
import '../providers/report_provider.dart';
import '../widgets/report_filter_bar.dart';
import '../widgets/report_summary_card.dart';

class AttendanceReportScreen extends ConsumerWidget {
  const AttendanceReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportState = ref.watch(attendanceReportProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return AppBackScope(
      fallbackPath: '/reports',
      child: Scaffold(
        appBar: AppBar(title: const Text('Rekap Kehadiran')),
        body: RefreshIndicator(
          onRefresh: () => ref.refresh(attendanceReportProvider.future),
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
                          ? 5
                          : 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ReportSummaryCard(
                          title: 'Hadir',
                          value: '${report.totalPresent}',
                          icon: Icons.check_circle_outline,
                          accentColor: Colors.green,
                          compact: true,
                        ),
                        ReportSummaryCard(
                          title: 'Izin',
                          value: '${report.totalPermission}',
                          icon: Icons.event_note_outlined,
                          accentColor: colorScheme.tertiary,
                          compact: true,
                        ),
                        ReportSummaryCard(
                          title: 'Tidak hadir',
                          value: '${report.totalAbsent}',
                          icon: Icons.cancel_outlined,
                          accentColor: colorScheme.error,
                          compact: true,
                        ),
                        ReportSummaryCard(
                          title: 'Batal',
                          value: '${report.totalCancelled}',
                          icon: Icons.block_outlined,
                          accentColor: Colors.orange,
                          compact: true,
                        ),
                        ReportSummaryCard(
                          title: 'Reschedule',
                          value: '${report.totalRescheduled}',
                          icon: Icons.update_outlined,
                          accentColor: colorScheme.primary,
                          compact: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Rekap per siswa',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (report.rows.isEmpty)
                      const _AttendanceEmptyState()
                    else
                      ...report.rows.map((row) => _AttendanceRowCard(row: row)),
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
                    child: Text('Gagal memuat rekap kehadiran: $error'),
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

class _AttendanceRowCard extends StatelessWidget {
  const _AttendanceRowCard({required this.row});

  final AttendanceReportRow row;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              row.studentName,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _CountPill(label: 'Hadir', value: row.present, color: Colors.green),
                _CountPill(
                  label: 'Izin',
                  value: row.permission,
                  color: colorScheme.tertiary,
                ),
                _CountPill(
                  label: 'Tidak hadir',
                  value: row.absent,
                  color: colorScheme.error,
                ),
                _CountPill(label: 'Batal', value: row.cancelled, color: Colors.orange),
                _CountPill(
                  label: 'Reschedule',
                  value: row.rescheduled,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CountPill extends StatelessWidget {
  const _CountPill({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$label $value',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _AttendanceEmptyState extends StatelessWidget {
  const _AttendanceEmptyState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            Icon(Icons.fact_check_outlined, size: 36, color: colorScheme.primary),
            const SizedBox(height: 10),
            Text(
              'Belum ada data kehadiran',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 4),
            Text(
              'Tidak ada sesi sumber absensi pada periode ini.',
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
