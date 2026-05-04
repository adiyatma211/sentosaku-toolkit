import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/logging/logger_provider.dart';
import '../data/local_reminder_service.dart';
import '../data/schedule_repository.dart';

final localReminderServiceProvider = Provider<LocalReminderService>((ref) {
  return LocalReminderService(
    ref.watch(databaseProvider),
    ref.watch(appLoggerProvider),
  );
});

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepository(
    ref.watch(databaseProvider),
    ref.watch(localReminderServiceProvider),
    ref.watch(appLoggerProvider),
  );
});

final selectedScheduleDateProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

final scheduleByDateProvider =
    StreamProvider.family<List<ScheduleDetail>, DateTime>((ref, date) {
      return ref.watch(scheduleRepositoryProvider).watchSchedulesByDate(date);
    });

final todaySchedulesProvider = StreamProvider<List<ScheduleDetail>>((ref) {
  return ref.watch(scheduleRepositoryProvider).watchTodaySchedules();
});

final scheduleDetailProvider = StreamProvider.family<ScheduleDetail?, int>((
  ref,
  id,
) {
  return ref.watch(scheduleRepositoryProvider).watchScheduleById(id);
});

final scheduleFormNotifierProvider =
    AsyncNotifierProvider.autoDispose<ScheduleFormNotifier, void>(
      ScheduleFormNotifier.new,
    );

class ScheduleFormNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<int> addSchedule(ScheduleFormData data) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(scheduleRepositoryProvider);
      final int id;
      if (data.scheduleType == ScheduleType.weekly) {
        final ids = await repository.insertWeeklySchedules(data);
        id = ids.first;
      } else {
        id = await repository.insertSchedule(data);
      }
      state = const AsyncData(null);
      return id;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> updateSchedule(int id, ScheduleFormData data) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref.read(scheduleRepositoryProvider).updateSchedule(id, data);
    });
  }

  Future<void> reschedule(
    int id,
    DateTime newDate,
    DateTime newStartTime,
    DateTime newEndTime,
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref
          .read(scheduleRepositoryProvider)
          .reschedule(id, newDate, newStartTime, newEndTime);
    });
  }

  Future<void> cancelSchedule(int id, {String? reason}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref
          .read(scheduleRepositoryProvider)
          .cancelSchedule(id, reason: reason);
    });
  }
}
