import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/logging/logger_provider.dart';
import '../data/assessment_repository.dart';

class StudentPeriodKey {
  const StudentPeriodKey({
    required this.studentId,
    required this.academicPeriodId,
  });

  final int studentId;
  final int academicPeriodId;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is StudentPeriodKey &&
            other.studentId == studentId &&
            other.academicPeriodId == academicPeriodId;
  }

  @override
  int get hashCode => Object.hash(studentId, academicPeriodId);
}

final assessmentRepositoryProvider = Provider<AssessmentRepository>((ref) {
  return AssessmentRepository(
    ref.watch(databaseProvider),
    ref.watch(appLoggerProvider),
  );
});

final assessmentReviewItemsProvider =
    StreamProvider.family<List<AssessmentReviewItem>, StudentPeriodKey>((
      ref,
      key,
    ) {
      return ref
          .watch(assessmentRepositoryProvider)
          .watchStudentAssessmentsForPeriod(
            key.studentId,
            key.academicPeriodId,
          );
    });

final assessmentSummaryProvider =
    FutureProvider.family<AssessmentPeriodSummary, StudentPeriodKey>((
      ref,
      key,
    ) {
      return ref
          .watch(assessmentRepositoryProvider)
          .getAssessmentSummary(key.studentId, key.academicPeriodId);
    });

final assessmentReviewNotifierProvider =
    AsyncNotifierProvider.autoDispose<AssessmentReviewNotifier, void>(
      AssessmentReviewNotifier.new,
    );

class AssessmentReviewNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<int> saveReviewCycle(AssessmentReviewFormData data) async {
    state = const AsyncLoading();
    try {
      final id = await ref
          .read(assessmentRepositoryProvider)
          .saveReviewCycle(data);
      state = const AsyncData(null);
      return id;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
