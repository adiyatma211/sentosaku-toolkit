import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/navigation/app_back_scope.dart';
import '../../../core/showcase/app_showcase.dart';
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
    final scheduleCount = schedulesState.maybeWhen(
      data: (schedules) => schedules.length,
      orElse: () => null,
    );
    startRequestedShowcase(
      context: context,
      ref: ref,
      tour: AppShowcaseTour.schedules,
      keys: _scheduleShowcaseKeys,
    );

    return AppBackScope(
      fallbackPath: '/dashboard',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Jadwal'),
          actions: [
            IconButton(
              tooltip: 'Mulai panduan jadwal',
              onPressed: () => startAppShowcase(context, _scheduleShowcaseKeys),
              icon: const Icon(Icons.help_outline_rounded),
            ),
          ],
        ),
        floatingActionButton: AppShowcaseTarget(
          showcaseKey: AppShowcaseKeys.scheduleAdd,
          title: 'Tambah jadwal',
          description: 'Tambah jadwal les',
          child: FloatingActionButton.extended(
            onPressed: () => context.go('/schedules/new'),
            icon: const Icon(Icons.add),
            label: const Text('Tambah'),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
                child: Column(
                  children: [
                    _ScheduleHeroHeader(
                      selectedDate: selectedDate,
                      scheduleCount: scheduleCount,
                    ),
                    const SizedBox(height: 12),
                    AppShowcaseTarget(
                      showcaseKey: AppShowcaseKeys.scheduleDateFilter,
                      title: 'Tanggal jadwal',
                      description: 'Pilih tanggal jadwal',
                      child: ScheduleDateFilter(
                        selectedDate: selectedDate,
                        onDateChanged: (date) =>
                            ref
                                .read(selectedScheduleDateProvider.notifier)
                                .state = DateTime(
                              date.year,
                              date.month,
                              date.day,
                            ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ActionChip(
                        avatar: const Icon(Icons.today_outlined, size: 18),
                        label: const Text('Hari ini'),
                        onPressed: () {
                          final now = DateTime.now();
                          ref
                              .read(selectedScheduleDateProvider.notifier)
                              .state = DateTime(
                            now.year,
                            now.month,
                            now.day,
                          );
                        },
                      ),
                    ),
                  ],
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

                    return AppShowcaseTarget(
                      showcaseKey: AppShowcaseKeys.scheduleList,
                      title: 'Daftar jadwal',
                      description: 'Buka detail jadwal',
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 2, 16, 112),
                        itemCount: schedules.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final detail = schedules[index];
                          return ScheduleCard(
                            detail: detail,
                            onTap: () =>
                                context.go('/schedules/${detail.schedule.id}'),
                          );
                        },
                      ),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
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
      ),
    );
  }
}

final _scheduleShowcaseKeys = [
  AppShowcaseKeys.scheduleDateFilter,
  AppShowcaseKeys.scheduleAdd,
  AppShowcaseKeys.scheduleList,
];

class _ScheduleHeroHeader extends StatelessWidget {
  const _ScheduleHeroHeader({
    required this.selectedDate,
    required this.scheduleCount,
  });

  final DateTime selectedDate;
  final int? scheduleCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateText = DateFormat(
      'EEEE, d MMMM yyyy',
      'id_ID',
    ).format(selectedDate);
    final countText = scheduleCount == null
        ? 'Memuat jadwal...'
        : '$scheduleCount jadwal hari itu';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colorScheme.primary, colorScheme.secondary],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: .18),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -24,
            top: -30,
            child: Icon(
              Icons.calendar_month_rounded,
              size: 116,
              color: Colors.white.withValues(alpha: .12),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Agenda Les',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Pantau jadwal mengajar dan buka detail sesi dengan cepat.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: .86),
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _HeroPill(icon: Icons.event_outlined, label: dateText),
                  _HeroPill(icon: Icons.list_alt_rounded, label: countText),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .18),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
