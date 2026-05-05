import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../academic/providers/academic_period_provider.dart';
import '../data/report_models.dart';
import '../providers/report_provider.dart';

class ReportFilterBar extends ConsumerWidget {
  const ReportFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(reportFilterProvider);
    final periodsState = ref.watch(academicPeriodsProvider);
    final notifier = ref.read(reportFilterProvider.notifier);
    final dateFormat = DateFormat('dd MMM yyyy', 'id_ID');
    final endInclusive = filter.endDate.subtract(const Duration(days: 1));
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.tune_rounded,
                    size: 20,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Periode laporan',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        'Pilih rentang data yang ingin ditampilkan.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  avatar: const Icon(Icons.today_rounded, size: 18),
                  label: const Text('Hari ini'),
                  selected: filter.filterType == ReportFilterType.today,
                  onSelected: (_) => notifier.setToday(),
                ),
                ChoiceChip(
                  avatar: const Icon(Icons.view_week_rounded, size: 18),
                  label: const Text('Minggu ini'),
                  selected: filter.filterType == ReportFilterType.week,
                  onSelected: (_) => notifier.setThisWeek(),
                ),
                ChoiceChip(
                  avatar: const Icon(Icons.calendar_month_rounded, size: 18),
                  label: const Text('Bulan ini'),
                  selected: filter.filterType == ReportFilterType.month,
                  onSelected: (_) => notifier.setThisMonth(),
                ),
                periodsState.maybeWhen(
                  data: (periods) => PopupMenuButton<int>(
                    enabled: periods.isNotEmpty,
                    tooltip: 'Pilih periode akademik',
                    onSelected: (id) {
                      final period = periods.firstWhere(
                        (period) => period.id == id,
                      );
                      notifier.setAcademicPeriod(
                        id: period.id,
                        name: period.name,
                        startDate: period.startDate,
                        endDate: period.endDate,
                      );
                    },
                    itemBuilder: (context) => periods
                        .map(
                          (period) => PopupMenuItem(
                            value: period.id,
                            child: Text(period.name),
                          ),
                        )
                        .toList(growable: false),
                    child: Chip(
                      avatar: const Icon(Icons.school_outlined, size: 18),
                      label: Text(
                        filter.filterType == ReportFilterType.academicPeriod
                            ? filter.academicPeriodName ?? 'Periode akademik'
                            : 'Semester/periode',
                      ),
                      backgroundColor:
                          filter.filterType == ReportFilterType.academicPeriod
                          ? colorScheme.secondaryContainer
                          : null,
                    ),
                  ),
                  orElse: () => const Chip(
                    avatar: Icon(Icons.school_outlined, size: 18),
                    label: Text('Semester/periode'),
                  ),
                ),
                ActionChip(
                  avatar: const Icon(Icons.date_range_rounded, size: 18),
                  label: const Text('Custom'),
                  onPressed: () => _pickCustomRange(context, ref, filter),
                ),
              ],
            ),
            const SizedBox(height: 14),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text('Sertakan rekap kehadiran untuk export'),
              value: filter.includeAttendanceRecap,
              onChanged: notifier.setIncludeAttendanceRecap,
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(
                  alpha: .55,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.event_note_rounded,
                    size: 18,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${dateFormat.format(filter.startDate)} - ${dateFormat.format(endInclusive)}',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickCustomRange(
    BuildContext context,
    WidgetRef ref,
    ReportFilter filter,
  ) async {
    final initialRange = DateTimeRange(
      start: filter.startDate,
      end: filter.endDate.subtract(const Duration(days: 1)),
    );
    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: initialRange,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked == null) return;
    ref
        .read(reportFilterProvider.notifier)
        .setCustomRange(picked.start, picked.end);
  }
}
