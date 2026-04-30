import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:showcaseview/showcaseview.dart';

enum AppShowcaseTour { dashboard, students, schedules, payments, reports }

final appShowcaseTourRequestProvider = StateProvider<AppShowcaseTour?>(
  (ref) => null,
);

class AppShowcaseKeys {
  const AppShowcaseKeys._();

  static final dashboardHero = GlobalKey();
  static final dashboardSummary = GlobalKey();
  static final dashboardQuickActions = GlobalKey();
  static final shellDashboard = GlobalKey();
  static final shellStudents = GlobalKey();
  static final shellSchedules = GlobalKey();
  static final shellPayments = GlobalKey();
  static final shellAttendanceFab = GlobalKey();

  static final studentSearch = GlobalKey();
  static final studentAdd = GlobalKey();
  static final studentList = GlobalKey();

  static final scheduleDateFilter = GlobalKey();
  static final scheduleAdd = GlobalKey();
  static final scheduleList = GlobalKey();

  static final paymentFilter = GlobalKey();
  static final paymentList = GlobalKey();

  static final reportFilter = GlobalKey();
  static final reportSummary = GlobalKey();
  static final reportMenu = GlobalKey();
}

class AppShowcaseTarget extends StatelessWidget {
  const AppShowcaseTarget({
    super.key,
    required this.showcaseKey,
    required this.title,
    required this.description,
    required this.child,
    this.shapeBorder,
  });

  final GlobalKey showcaseKey;
  final String title;
  final String description;
  final Widget child;
  final ShapeBorder? shapeBorder;

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: showcaseKey,
      title: title,
      description: description,
      targetShapeBorder:
          shapeBorder ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: child,
    );
  }
}

void startAppShowcase(BuildContext context, List<GlobalKey> keys) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!context.mounted) return;
    ShowcaseView.get().startShowCase(keys);
  });
}

void startRequestedShowcase({
  required BuildContext context,
  required WidgetRef ref,
  required AppShowcaseTour tour,
  required List<GlobalKey> keys,
}) {
  final requestedTour = ref.watch(appShowcaseTourRequestProvider);
  if (requestedTour != tour) return;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!context.mounted) return;
    ref.read(appShowcaseTourRequestProvider.notifier).state = null;
    ShowcaseView.get().startShowCase(keys);
  });
}

void requestShowcaseTour(WidgetRef ref, AppShowcaseTour tour) {
  ref.read(appShowcaseTourRequestProvider.notifier).state = tour;
}
