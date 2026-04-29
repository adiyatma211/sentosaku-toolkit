import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/app_back_scope.dart';
import '../providers/schedule_provider.dart';
import '../widgets/schedule_card.dart';
import '../widgets/schedule_date_filter.dart';
import '../widgets/schedule_empty_state.dart';

class ScheduleListScreen extends ConsumerWidget {
  const ScheduleListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedScheduleDateProvider);
    final schedulesState = ref.watch(scheduleByDateProvider(selectedDate));

    return AppBackScope(
      fallbackPath: '/dashboard',
      child: Scaffold(
        appBar: AppBar(title: const Text('Jadwal')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.go('/schedules/new'),
          icon: const Icon(Icons.add),
          label: const Text('Tambah'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: ScheduleDateFilter(
                selectedDate: selectedDate,
                onDateChanged: (date) =>
                    ref.read(selectedScheduleDateProvider.notifier).state =
                        DateTime(date.year, date.month, date.day),
              ),
            ),
            Expanded(
              child: schedulesState.when(
                data: (schedules) {
                  if (schedules.isEmpty) {
                    return ScheduleEmptyState(
                      onAdd: () => context.go('/schedules/new'),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                    itemCount: schedules.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final detail = schedules[index];
                      return ScheduleCard(
                        detail: detail,
                        onTap: () =>
                            context.go('/schedules/${detail.schedule.id}'),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text('Gagal memuat jadwal: $error'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
