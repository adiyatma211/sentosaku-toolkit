import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../schedules/data/schedule_repository.dart';
import '../../schedules/providers/schedule_provider.dart';
import '../../schedules/widgets/schedule_status_chip.dart';
import '../data/dashboard_repository.dart';
import '../providers/dashboard_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryState = ref.watch(dashboardSummaryProvider);
    final todaySchedulesState = ref.watch(todaySchedulesProvider);
    final summary = summaryState.asData?.value;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Sentosaku TutorKit')),
      floatingActionButton: _TodayAgendaFab(
        onPressed: () => _showTodayAgendaSheet(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const _DashboardBottomNavigation(),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(dashboardSummaryProvider.future),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 144),
          children: [
            _HeroHeader(
              colorScheme: colorScheme,
              summary: summary,
              todaySchedulesState: todaySchedulesState,
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ringkasan',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                TextButton.icon(
                  onPressed: () => ref.invalidate(dashboardSummaryProvider),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Refresh'),
                ),
              ],
            ),
            summaryState.when(
              data: (summary) => Column(
                children: [
                  _SummaryGrid(summary: summary),
                  const SizedBox(height: 18),
                  _ActivityChart(summary: summary),
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
                  child: Text('Gagal memuat ringkasan: $error'),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Akses Cepat',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            const _QuickActionGrid(),
          ],
        ),
      ),
    );
  }

  void _showTodayAgendaSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const _TodayAgendaSheet(),
    );
  }
}

class _TodayAgendaFab extends StatelessWidget {
  const _TodayAgendaFab({required this.onPressed});

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

class _DashboardBottomNavigation extends StatelessWidget {
  const _DashboardBottomNavigation();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      height: 82,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: const Row(
        children: [
          Expanded(
            child: _BottomNavigationAction(
              label: 'Dashboard',
              path: '/dashboard',
              icon: Icons.dashboard_outlined,
              selectedIcon: Icons.dashboard_rounded,
              selected: true,
            ),
          ),
          Expanded(
            child: _BottomNavigationAction(
              label: 'Siswa',
              path: '/students',
              icon: Icons.groups_outlined,
              selectedIcon: Icons.groups_rounded,
            ),
          ),
          SizedBox(width: 84),
          Expanded(
            child: _BottomNavigationAction(
              label: 'Jadwal',
              path: '/schedules',
              icon: Icons.calendar_month_outlined,
              selectedIcon: Icons.calendar_month_rounded,
            ),
          ),
          Expanded(
            child: _BottomNavigationAction(
              label: 'Pembayaran',
              path: '/payments',
              icon: Icons.payments_outlined,
              selectedIcon: Icons.payments_rounded,
            ),
          ),
          Expanded(
            child: _BottomNavigationAction(
              label: 'Laporan',
              path: '/reports',
              icon: Icons.bar_chart_outlined,
              selectedIcon: Icons.bar_chart_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavigationAction extends StatelessWidget {
  const _BottomNavigationAction({
    required this.label,
    required this.path,
    required this.icon,
    required this.selectedIcon,
    this.selected = false,
  });

  final String label;
  final String path;
  final IconData icon;
  final IconData selectedIcon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = selected ? colorScheme.primary : colorScheme.onSurfaceVariant;

    return InkResponse(
      onTap: () => context.go(path),
      radius: 32,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(selected ? selectedIcon : icon, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
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

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({
    required this.colorScheme,
    required this.summary,
    required this.todaySchedulesState,
  });

  final ColorScheme colorScheme;
  final DashboardSummary? summary;
  final AsyncValue<List<ScheduleDetail>> todaySchedulesState;

  @override
  Widget build(BuildContext context) {
    final now = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    final monthlyRevenue = summary == null
        ? '-'
        : currencyFormat.format(summary!.monthlyRevenue);

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
            right: -34,
            top: -42,
            child: Icon(
              Icons.school_rounded,
              size: 150,
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
                  now,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Selamat datang kembali',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Kelola siswa, jadwal, sesi, dan pembayaran tutor dalam satu tempat.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: .88),
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 18),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isCompact = constraints.maxWidth < 620;
                  final scheduleCard = _NearestScheduleCard(
                    schedulesState: todaySchedulesState,
                    colorScheme: colorScheme,
                  );

                  if (isCompact) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: double.infinity, child: scheduleCard),
                        const SizedBox(height: 10),
                        _HeaderRevenueBadge(value: monthlyRevenue),
                      ],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: scheduleCard),
                      const SizedBox(width: 10),
                      _HeaderRevenueBadge(value: monthlyRevenue),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NearestScheduleCard extends StatelessWidget {
  const _NearestScheduleCard({
    required this.schedulesState,
    required this.colorScheme,
  });

  final AsyncValue<List<ScheduleDetail>> schedulesState;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return schedulesState.when(
      data: (schedules) {
        final detail = _nearestSchedule(schedules, DateTime.now());
        if (detail == null) {
          return _NearestScheduleShell(
            child: Wrap(
              spacing: 10,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const _NearestScheduleIcon(icon: Icons.event_busy_outlined),
                Text(
                  'Tidak ada jadwal lagi hari ini',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => context.go('/schedules/new'),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Buat jadwal'),
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          );
        }

        return _NearestScheduleDetailCard(
          detail: detail,
          colorScheme: colorScheme,
        );
      },
      loading: () => _NearestScheduleShell(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Memuat jadwal...',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
      error: (error, stackTrace) => _NearestScheduleShell(
        child: Text(
          'Gagal memuat jadwal hari ini',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _NearestScheduleDetailCard extends StatelessWidget {
  const _NearestScheduleDetailCard({
    required this.detail,
    required this.colorScheme,
  });

  final ScheduleDetail detail;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final schedule = detail.schedule;
    final dateFormat = DateFormat('EEEE, d MMM yyyy', 'id_ID');
    final timeFormat = DateFormat.Hm();
    final dateText = dateFormat.format(schedule.date);
    final timeText =
        '${timeFormat.format(schedule.startTime)} - ${timeFormat.format(schedule.endTime)}';
    final address = detail.student.address?.trim();
    final locationText = address == null || address.isEmpty
        ? 'Lokasi belum diisi'
        : address;

    return _NearestScheduleShell(
      onTap: () => context.go('/schedules/${schedule.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const _NearestScheduleIcon(icon: Icons.event_available_rounded),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Jadwal terdekat',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => context.go('/schedules/${schedule.id}'),
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(0, 34),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Detail'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _NearestScheduleInfoRow(
            icon: Icons.calendar_today_rounded,
            label: 'Tgl',
            value: dateText,
            colorScheme: colorScheme,
          ),
          _NearestScheduleInfoRow(
            icon: Icons.schedule_rounded,
            label: 'Jam',
            value: timeText,
            colorScheme: colorScheme,
          ),
          _NearestScheduleInfoRow(
            icon: Icons.place_outlined,
            label: 'Lokasi',
            value: locationText,
            colorScheme: colorScheme,
            maxLines: 2,
          ),
          _NearestScheduleInfoRow(
            icon: Icons.person_outline_rounded,
            label: 'Murid',
            value: detail.student.name,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 10,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ScheduleStatusChip(status: schedule.status),
              Text(
                detail.subject.name,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NearestScheduleInfoRow extends StatelessWidget {
  const _NearestScheduleInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.colorScheme,
    this.maxLines = 1,
  });

  final IconData icon;
  final String label;
  final String value;
  final ColorScheme colorScheme;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(icon, size: 16, color: colorScheme.primary),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 48,
            child: Text(
              '$label:',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NearestScheduleShell extends StatelessWidget {
  const _NearestScheduleShell({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: const EdgeInsets.all(12), child: child),
      ),
    );
  }
}

class _NearestScheduleIcon extends StatelessWidget {
  const _NearestScheduleIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: colorScheme.primary, size: 18),
    );
  }
}

ScheduleDetail? _nearestSchedule(List<ScheduleDetail> schedules, DateTime now) {
  final activeSchedules = schedules.where((detail) {
    return _isActiveScheduleStatus(detail.schedule.status);
  }).toList();
  if (activeSchedules.isEmpty) return null;

  for (final detail in activeSchedules) {
    if (!detail.schedule.startTime.isBefore(now)) return detail;
  }

  return activeSchedules.last;
}

bool _isActiveScheduleStatus(String status) {
  return status != ScheduleStatus.done && status != ScheduleStatus.cancelled;
}

class _HeaderRevenueBadge extends StatelessWidget {
  const _HeaderRevenueBadge({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .18),
        border: Border.all(color: Colors.white.withValues(alpha: .28)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.account_balance_wallet_rounded,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pendapatan bulan ini',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: .82),
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryGrid extends StatelessWidget {
  const _SummaryGrid({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final items = [
      _SummaryItem(
        title: 'Siswa aktif',
        value: '${summary.activeStudents}',
        icon: Icons.groups_rounded,
        color: const Color(0xFF5E8C52),
      ),
      _SummaryItem(
        title: 'Jadwal hari ini',
        value: '${summary.todaySchedules}',
        icon: Icons.event_available_rounded,
        color: const Color(0xFF7EA16B),
      ),
      _SummaryItem(
        title: 'Sesi bulan ini',
        value: '${summary.completedSessionsThisMonth}',
        icon: Icons.check_circle_rounded,
        color: const Color(0xFF3D7A73),
      ),
      _SummaryItem(
        title: 'Belum dibayar',
        value: '${summary.unpaidInvoices}',
        icon: Icons.receipt_long_rounded,
        color: const Color(0xFFD08A3C),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width >= 760 ? 4 : 2;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: width >= 760 ? 78 : 84,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) => _SummaryCard(item: items[index]),
        );
      },
    );
  }
}

class _SummaryItem {
  const _SummaryItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.item});

  final _SummaryItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon, color: item.color, size: 19),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w700,
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
}

class _ActivityChart extends StatelessWidget {
  const _ActivityChart({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final items = [
      _ChartItem(
        label: 'Siswa aktif',
        value: summary.activeStudents,
        color: const Color(0xFF5E8C52),
      ),
      _ChartItem(
        label: 'Jadwal hari ini',
        value: summary.todaySchedules,
        color: const Color(0xFF7EA16B),
      ),
      _ChartItem(
        label: 'Sesi bulan ini',
        value: summary.completedSessionsThisMonth,
        color: const Color(0xFF3D7A73),
      ),
      _ChartItem(
        label: 'Belum dibayar',
        value: summary.unpaidInvoices,
        color: const Color(0xFFD08A3C),
      ),
    ];
    final maxValue = items.fold<int>(1, (max, item) {
      return item.value > max ? item.value : max;
    });

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aktivitas Bulan Ini',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 4),
            Text(
              'Grafik ringkas dari data dashboard saat ini.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            for (final item in items) ...[
              _ChartBar(item: item, maxValue: maxValue),
              if (item != items.last) const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}

class _ChartItem {
  const _ChartItem({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;
}

class _ChartBar extends StatelessWidget {
  const _ChartBar({required this.item, required this.maxValue});

  final _ChartItem item;
  final int maxValue;

  @override
  Widget build(BuildContext context) {
    final percentage = item.value / maxValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${item.value}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: item.color,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LayoutBuilder(
          builder: (context, constraints) {
            final barWidth = constraints.maxWidth * percentage.clamp(0.0, 1.0);

            return Stack(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 450),
                  curve: Curves.easeOutCubic,
                  width: barWidth,
                  height: 10,
                  decoration: BoxDecoration(
                    color: item.color,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _QuickActionGrid extends StatelessWidget {
  const _QuickActionGrid();

  static const _actions = [
    _QuickAction('Siswa', '/students', Icons.person_add_alt_1_rounded),
    _QuickAction('Jadwal', '/schedules', Icons.calendar_month_rounded),
    _QuickAction('Sesi', '/sessions', Icons.fact_check_rounded),
    _QuickAction('Pembayaran', '/payments', Icons.payments_rounded),
    _QuickAction('Laporan', '/reports', Icons.bar_chart_rounded),
    _QuickAction('Backup', '/backup', Icons.cloud_sync_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 820 ? 6 : 3;
        final itemHeight = constraints.maxWidth >= 560 ? 84.0 : 78.0;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: itemHeight,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _actions.length,
          itemBuilder: (context, index) =>
              _NavigationTile(action: _actions[index]),
        );
      },
    );
  }
}

class _QuickAction {
  const _QuickAction(this.title, this.path, this.icon);

  final String title;
  final String path;
  final IconData icon;
}

class _NavigationTile extends StatelessWidget {
  const _NavigationTile({required this.action});

  final _QuickAction action;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go(action.path),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer.withValues(alpha: .65),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(action.icon, color: colorScheme.primary, size: 20),
              ),
              const SizedBox(height: 6),
              Text(
                action.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
