import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/report_models.dart';
import '../providers/report_provider.dart';

class ReportFilterBar extends ConsumerWidget {
  const ReportFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(reportFilterProvider);
    final notifier = ref.read(reportFilterProvider.notifier);
    final dateFormat = DateFormat('dd MMM yyyy', 'id_ID');
    final endInclusive = filter.endDate.subtract(const Duration(days: 1));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Hari ini'),
                  selected: filter.filterType == ReportFilterType.today,
                  onSelected: (_) => notifier.setToday(),
                ),
                ChoiceChip(
                  label: const Text('Minggu ini'),
                  selected: filter.filterType == ReportFilterType.week,
                  onSelected: (_) => notifier.setThisWeek(),
                ),
                ChoiceChip(
                  label: const Text('Bulan ini'),
                  selected: filter.filterType == ReportFilterType.month,
                  onSelected: (_) => notifier.setThisMonth(),
                ),
                ActionChip(
                  avatar: const Icon(Icons.date_range),
                  label: const Text('Custom'),
                  onPressed: () => _pickCustomRange(context, ref, filter),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${dateFormat.format(filter.startDate)} - ${dateFormat.format(endInclusive)}',
              style: Theme.of(context).textTheme.bodySmall,
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
