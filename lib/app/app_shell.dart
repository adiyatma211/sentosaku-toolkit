import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/showcase/app_showcase.dart';

import '../features/dashboard/widgets/today_agenda_fab.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child, required this.location});

  final Widget child;
  final String location;

  static const _items = <_ShellNavigationItem>[
    _ShellNavigationItem(
      label: 'Dashboard',
      path: '/dashboard',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard_rounded,
    ),
    _ShellNavigationItem(
      label: 'Siswa',
      path: '/students',
      icon: Icons.groups_outlined,
      selectedIcon: Icons.groups_rounded,
    ),
    _ShellNavigationItem(
      label: 'Jadwal',
      path: '/schedules',
      icon: Icons.calendar_month_outlined,
      selectedIcon: Icons.calendar_month_rounded,
    ),
    _ShellNavigationItem(
      label: 'Pembayaran',
      path: '/payments',
      icon: Icons.payments_outlined,
      selectedIcon: Icons.payments_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final showAgendaFab = _isRootTabLocation(location);

    return Scaffold(
      body: child,
      floatingActionButton: showAgendaFab
          ? AppShowcaseTarget(
              showcaseKey: AppShowcaseKeys.shellAttendanceFab,
              title: 'Absen sesi',
              description: 'Tombol Absen untuk mencatat sesi hari ini',
              shapeBorder: const CircleBorder(),
              child: TodayAgendaFab(
                onPressed: () => showTodayAgendaSheet(context),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 82,
        color: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            for (final item in _items.take(2))
              _ShellNavigationButton(
                item: item,
                showcaseKey: _showcaseKeyForItem(item),
                selected: _isSelected(location, item),
                onTap: () => _goToPath(context, item.path),
              ),
            const SizedBox(width: 78),
            for (final item in _items.skip(2))
              _ShellNavigationButton(
                item: item,
                showcaseKey: _showcaseKeyForItem(item),
                selected: _isSelected(location, item),
                onTap: () => _goToPath(context, item.path),
              ),
          ],
        ),
      ),
    );
  }

  void _goToPath(BuildContext context, String path) {
    if (path != location) {
      context.go(path);
    }
  }

  bool _isRootTabLocation(String path) {
    return _items.any((item) => path == item.path);
  }

  bool _isSelected(String path, _ShellNavigationItem item) {
    return path == item.path || path.startsWith('${item.path}/');
  }

  GlobalKey _showcaseKeyForItem(_ShellNavigationItem item) {
    return switch (item.path) {
      '/dashboard' => AppShowcaseKeys.shellDashboard,
      '/students' => AppShowcaseKeys.shellStudents,
      '/schedules' => AppShowcaseKeys.shellSchedules,
      '/payments' => AppShowcaseKeys.shellPayments,
      _ => GlobalKey(),
    };
  }
}

class _ShellNavigationButton extends StatelessWidget {
  const _ShellNavigationButton({
    required this.item,
    required this.showcaseKey,
    required this.selected,
    required this.onTap,
  });

  final _ShellNavigationItem item;
  final GlobalKey showcaseKey;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foregroundColor = selected
        ? colorScheme.primary
        : colorScheme.onSurfaceVariant;
    final textStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
      color: foregroundColor,
      fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
    );

    return Expanded(
      child: AppShowcaseTarget(
        showcaseKey: showcaseKey,
        title: item.label,
        description: 'Gunakan bottom nav untuk pindah modul',
        child: Tooltip(
          message: item.label,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? colorScheme.primaryContainer
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Icon(
                      selected ? item.selectedIcon : item.icon,
                      color: selected
                          ? colorScheme.onPrimaryContainer
                          : foregroundColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShellNavigationItem {
  const _ShellNavigationItem({
    required this.label,
    required this.path,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final String path;
  final IconData icon;
  final IconData selectedIcon;
}
