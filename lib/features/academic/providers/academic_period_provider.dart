import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/logging/logger_provider.dart';
import '../data/academic_period_repository.dart';

final academicPeriodRepositoryProvider = Provider<AcademicPeriodRepository>((
  ref,
) {
  return AcademicPeriodRepository(
    ref.watch(databaseProvider),
    ref.watch(appLoggerProvider),
  );
});

final academicPeriodsProvider = StreamProvider<List<AcademicPeriod>>((ref) {
  return ref.watch(academicPeriodRepositoryProvider).watchAcademicPeriods();
});

final academicPeriodDetailProvider =
    StreamProvider.family<AcademicPeriod?, int>((ref, id) {
      return ref
          .watch(academicPeriodRepositoryProvider)
          .watchAcademicPeriodById(id);
    });

final studentPeriodAssignmentsProvider =
    StreamProvider.family<List<StudentPeriodAssignmentDetail>, int>((
      ref,
      studentId,
    ) {
      return ref
          .watch(academicPeriodRepositoryProvider)
          .watchStudentAssignments(studentId);
    });

final academicPeriodFormNotifierProvider =
    AsyncNotifierProvider.autoDispose<AcademicPeriodFormNotifier, void>(
      AcademicPeriodFormNotifier.new,
    );

class AcademicPeriodFormNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<int> addPeriod(AcademicPeriodFormData data) async {
    state = const AsyncLoading();
    try {
      final id = await ref
          .read(academicPeriodRepositoryProvider)
          .insertAcademicPeriod(data);
      state = const AsyncData(null);
      return id;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> updatePeriod(int id, AcademicPeriodFormData data) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref
          .read(academicPeriodRepositoryProvider)
          .updateAcademicPeriod(id, data);
    });
  }

  Future<void> setActive(int id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref
          .read(academicPeriodRepositoryProvider)
          .setAcademicPeriodActive(id);
    });
  }
}

final studentPeriodAssignmentNotifierProvider =
    AsyncNotifierProvider.autoDispose<StudentPeriodAssignmentNotifier, void>(
      StudentPeriodAssignmentNotifier.new,
    );

class StudentPeriodAssignmentNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<int> assign(StudentPeriodAssignmentFormData data) async {
    state = const AsyncLoading();
    try {
      final id = await ref
          .read(academicPeriodRepositoryProvider)
          .assignStudentToPeriod(data);
      state = const AsyncData(null);
      return id;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
