import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/showcase/app_showcase.dart';
import '../../academic/providers/academic_period_provider.dart';
import '../../guide/providers/onboarding_provider.dart';
import '../../schedules/data/schedule_repository.dart';
import '../../schedules/providers/schedule_provider.dart';
import '../data/dashboard_repository.dart';
import '../providers/dashboard_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _hasCheckedInitialDashboardTour = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startInitialDashboardTourIfNeeded();
    });
  }

  Future<void> _startInitialDashboardTourIfNeeded() async {
    if (_hasCheckedInitialDashboardTour || !mounted) return;
    _hasCheckedInitialDashboardTour = true;

    if (GoRouterState.of(context).uri.path != '/dashboard') return;

    final onboardingService = ref.read(onboardingServiceProvider);
    final shouldShow = await onboardingService.shouldShowInitialDashboardTour();
    if (!mounted || !shouldShow) return;

    await onboardingService.markInitialDashboardTourSeen();
    if (!mounted || GoRouterState.of(context).uri.path != '/dashboard') return;

    startAppShowcase(context, _dashboardShowcaseKeys);
  }

  @override
  Widget build(BuildContext context) {
    final summaryState = ref.watch(dashboardSummaryProvider);
    final todaySchedulesState = ref.watch(todaySchedulesProvider);
    final academicPeriodsState = ref.watch(academicPeriodsProvider);
    final summary = summaryState.asData?.value;
    startRequestedShowcase(
      context: context,
      ref: ref,
      tour: AppShowcaseTour.dashboard,
      keys: _dashboardShowcaseKeys,
    );

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, automaticallyImplyLeading: false),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(dashboardSummaryProvider.future),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 144),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              decoration: const BoxDecoration(
                color: Color(0xFF7E9E63),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
              child: AppShowcaseTarget(
                showcaseKey: AppShowcaseKeys.dashboardHero,
                title: 'Dashboard',
                description: 'Ini ringkasan aktivitas les Anda',
                child: _HeroHeader(
                  summary: summary,
                  todaySchedulesState: todaySchedulesState,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ringkasan',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () =>
                            ref.invalidate(dashboardSummaryProvider),
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Refresh'),
                      ),
                    ],
                  ),
                  summaryState.when(
                    data: (summary) => Column(
                      children: [
                        AppShowcaseTarget(
                          showcaseKey: AppShowcaseKeys.dashboardSummary,
                          title: 'Ringkasan',
                          description: 'Ini ringkasan aktivitas les Anda',
                          child: _SummaryGrid(summary: summary),
                        ),
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
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _AcademicPeriodShortcutCard(
                    periodsState: academicPeriodsState,
                  ),
                  const SizedBox(height: 10),
                  AppShowcaseTarget(
                    showcaseKey: AppShowcaseKeys.dashboardQuickActions,
                    title: 'Akses cepat',
                    description:
                        'Gunakan akses cepat untuk membuka modul utama.',
                    child: const _QuickActionGrid(),
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

final _dashboardShowcaseKeys = [
  AppShowcaseKeys.dashboardHero,
  AppShowcaseKeys.dashboardSummary,
  AppShowcaseKeys.dashboardQuickActions,
  AppShowcaseKeys.shellAttendanceFab,
  AppShowcaseKeys.shellDashboard,
  AppShowcaseKeys.shellStudents,
  AppShowcaseKeys.shellSchedules,
  AppShowcaseKeys.shellPayments,
];

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.summary, required this.todaySchedulesState});

  final DashboardSummary? summary;
  final AsyncValue<List<ScheduleDetail>> todaySchedulesState;

  @override
  Widget build(BuildContext context) {
    final now = DateFormat('d MMM yyyy', 'id_ID').format(DateTime.now());
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    final monthlyRevenue = summary == null
        ? '-'
        : currencyFormat.format(summary!.monthlyRevenue);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Sentosaku TutorKit',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Material(
              color: Colors.white.withValues(alpha: .18),
              borderRadius: BorderRadius.circular(999),
              child: InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: () => startAppShowcase(context, _dashboardShowcaseKeys),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.help_outline_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _HeroPill(icon: Icons.calendar_today_rounded, label: now),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: _HeroPill(
                icon: Icons.account_balance_wallet_rounded,
                label: monthlyRevenue,
                alignment: MainAxisAlignment.end,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          'Halo',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Ringkasan singkat aktivitas mengajarmu hari ini.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: .88),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        _NearestScheduleCard(schedulesState: todaySchedulesState),
      ],
    );
  }
}

class _NearestScheduleCard extends StatelessWidget {
  const _NearestScheduleCard({required this.schedulesState});

  final AsyncValue<List<ScheduleDetail>> schedulesState;

  @override
  Widget build(BuildContext context) {
    return schedulesState.when(
      data: (schedules) {
        final detail = _nearestSchedule(schedules, DateTime.now());
        if (detail == null) {
          return _NearestScheduleShell(
            leadingIcon: Icons.calendar_month_rounded,
            title: 'Belum ada jadwal lagi hari ini',
            subtitle: 'Tambahkan jadwal baru untuk melengkapi agenda.',
            actionTooltip: 'Buat jadwal',
            onActionTap: () => context.go('/schedules/new'),
          );
        }

        return _NearestScheduleDetailCard(detail: detail);
      },
      loading: () => _NearestScheduleShell(
        leadingIcon: Icons.calendar_month_rounded,
        title: 'Memuat jadwal...',
        subtitle: 'Menyiapkan ringkasan agenda hari ini.',
        actionTooltip: 'Buat jadwal',
        onActionTap: () => context.go('/schedules/new'),
      ),
      error: (error, stackTrace) => _NearestScheduleShell(
        leadingIcon: Icons.calendar_month_rounded,
        title: 'Gagal memuat jadwal hari ini',
        subtitle: 'Coba refresh untuk mengambil data terbaru.',
        actionTooltip: 'Buat jadwal',
        onActionTap: () => context.go('/schedules/new'),
      ),
    );
  }
}

class _NearestScheduleDetailCard extends StatelessWidget {
  const _NearestScheduleDetailCard({required this.detail});

  final ScheduleDetail detail;

  @override
  Widget build(BuildContext context) {
    final schedule = detail.schedule;
    final timeFormat = DateFormat.Hm();
    final timeText =
        '${timeFormat.format(schedule.startTime)} - ${timeFormat.format(schedule.endTime)}';
    final subtitle = '$timeText • ${detail.student.name}';
    final secondaryText = detail.subject.name;

    return _NearestScheduleShell(
      leadingIcon: Icons.calendar_month_rounded,
      title: 'Jadwal terdekat',
      subtitle: subtitle,
      caption: secondaryText,
      onTap: () => context.go('/schedules/${schedule.id}'),
      actionTooltip: 'Buat jadwal',
      onActionTap: () => context.go('/schedules/new'),
    );
  }
}

class _NearestScheduleShell extends StatelessWidget {
  const _NearestScheduleShell({
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.actionTooltip,
    required this.onActionTap,
    this.caption,
    this.onTap,
  });

  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final String? caption;
  final String actionTooltip;
  final VoidCallback onActionTap;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF6F0E8),
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              _NearestScheduleIcon(icon: leadingIcon),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: const Color(0xFF4E6640),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF20261D),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (caption != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        caption!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF66705E),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Tooltip(
                message: actionTooltip,
                child: InkWell(
                  onTap: onActionTap,
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: Color(0xFF7E9E63),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 20,
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

class _NearestScheduleIcon extends StatelessWidget {
  const _NearestScheduleIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: const Color(0xFF7E9E63), size: 20),
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

class _HeroPill extends StatelessWidget {
  const _HeroPill({
    required this.icon,
    required this.label,
    this.alignment = MainAxisAlignment.start,
  });

  final IconData icon;
  final String label;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .18),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisAlignment: alignment,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
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

class _AcademicPeriodShortcutCard extends StatelessWidget {
  const _AcademicPeriodShortcutCard({required this.periodsState});

  final AsyncValue<List<AcademicPeriod>> periodsState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final dateFormat = DateFormat('d MMM yyyy');

    final (title, subtitle) = periodsState.when(
      data: (periods) {
        AcademicPeriod? activePeriod;
        for (final period in periods) {
          if (period.isActive) {
            activePeriod = period;
            break;
          }
        }

        if (activePeriod == null) {
          return (
            'Periode akademik belum diatur',
            'Tambahkan atau aktifkan periode akademik untuk mulai mengelola pembelajaran.',
          );
        }

        return (
          activePeriod.name,
          '${dateFormat.format(activePeriod.startDate)} - ${dateFormat.format(activePeriod.endDate)}',
        );
      },
      loading: () =>
          ('Memuat periode akademik...', 'Buka pengaturan periode akademik.'),
      error: (error, stackTrace) => (
        'Gagal memuat periode akademik',
        'Buka daftar periode akademik untuk memeriksa data aktif.',
      ),
    );

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/academic-periods'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.school_rounded,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Setup Periode Akademik',
                      style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
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
    _QuickAction('Panduan', '/guide', Icons.menu_book_rounded),
    _QuickAction('Backup', '/backup', Icons.cloud_sync_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 820
            ? 4
            : constraints.maxWidth >= 560
            ? 4
            : 2;
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
