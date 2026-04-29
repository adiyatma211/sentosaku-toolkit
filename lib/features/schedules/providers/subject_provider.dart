import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/logging/logger_provider.dart';
import '../data/subject_repository.dart';

final subjectRepositoryProvider = Provider<SubjectRepository>((ref) {
  return SubjectRepository(
    ref.watch(databaseProvider),
    ref.watch(appLoggerProvider),
  );
});

final activeSubjectsProvider = StreamProvider<List<Subject>>((ref) {
  return ref.watch(subjectRepositoryProvider).watchActiveSubjects();
});

final subjectsByStudentProvider = StreamProvider.family<List<Subject>, int>((
  ref,
  studentId,
) {
  return ref.watch(subjectRepositoryProvider).watchSubjectsByStudent(studentId);
});
