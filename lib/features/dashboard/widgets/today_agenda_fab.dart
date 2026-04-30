import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../schedules/data/schedule_repository.dart';
import '../../schedules/providers/schedule_provider.dart';
import '../../schedules/widgets/schedule_status_chip.dart';

class TodayAgendaFab extends StatelessWidget {
  const TodayAgendaFab({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 72,
      height: 78,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(
            dimension: 56,
            child: FloatingActionButton(
              tooltip: 'Absen Hari Ini',
              onPressed: onPressed,
              child: const Icon(Icons.add_rounded, size: 28),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Absen',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

void showTodayAgendaSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => const _TodayAgendaSheet(),
  );
}

class _TodayAgendaSheet extends ConsumerWidget {
  const _TodayAgendaSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesState = ref.watch(todaySchedulesProvider);

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * .78,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Agenda Les Hari Ini',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Tutup',
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Flexible(
              child: schedulesState.when(
                data: (schedules) => schedules.isEmpty
                    ? const _TodayAgendaEmptyState()
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: schedules.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) =>
                            _TodayAgendaTile(detail: schedules[index]),
                      ),
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 48),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stackTrace) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text('Gagal memuat agenda hari ini: $error'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TodayAgendaEmptyState extends StatelessWidget {
  const _TodayAgendaEmptyState();

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.event_available_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              'Belum ada jadwal hari ini',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              'Tambahkan jadwal les agar agenda tampil di sini.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                router.go('/schedules/new');
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text('Buat Jadwal'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TodayAgendaTile extends StatelessWidget {
  const _TodayAgendaTile({required this.detail});

  final ScheduleDetail detail;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final schedule = detail.schedule;
    final canCreateSession = _canCreateSession(schedule.status);
    final timeFormat = DateFormat.Hm();
    final timeText =
        '${timeFormat.format(schedule.startTime)} - ${timeFormat.format(schedule.endTime)}';

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: canCreateSession
            ? () {
                Navigator.of(context).pop();
                router.go('/schedules/${schedule.id}/session/new');
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detail.student.name,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          detail.subject.name,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                  ScheduleStatusChip(status: schedule.status),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(child: Text(timeText)),
                  const SizedBox(width: 12),
                  FilledButton.tonalIcon(
                    onPressed: canCreateSession
                        ? () {
                            Navigator.of(context).pop();
                            router.go('/schedules/${schedule.id}/session/new');
                          }
                        : null,
                    icon: Icon(
                      canCreateSession
                          ? Icons.fact_check_outlined
                          : Icons.lock_outline_rounded,
                    ),
                    label: Text(
                      canCreateSession
                          ? 'Isi Absen'
                          : _statusLabel(schedule.status),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _canCreateSession(String status) {
    return status != ScheduleStatus.done && status != ScheduleStatus.cancelled;
  }

  String _statusLabel(String status) {
    return switch (status) {
      ScheduleStatus.done => 'Selesai',
      ScheduleStatus.cancelled => 'Batal',
      ScheduleStatus.rescheduled => 'Reschedule',
      ScheduleStatus.noShow => 'No show',
      _ => 'Terjadwal',
    };
  }
}
