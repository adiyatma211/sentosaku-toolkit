import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../schedules/providers/schedule_provider.dart';
import '../../sessions/providers/session_provider.dart';
import '../../students/providers/student_provider.dart';
import '../data/dashboard_repository.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository(
    ref.watch(databaseProvider),
    ref.watch(studentRepositoryProvider),
  );
});

final dashboardSummaryProvider = FutureProvider<DashboardSummary>((ref) {
  final activeStudents = ref.watch(activeStudentsProvider).value;
  final todaySchedules = ref.watch(todaySchedulesProvider).value;
  ref.watch(sessionsProvider).value;
  return ref
      .watch(dashboardRepositoryProvider)
      .getSummary(
        activeStudentCount: activeStudents?.length,
        todayScheduleCount: todaySchedules?.length,
      );
});
