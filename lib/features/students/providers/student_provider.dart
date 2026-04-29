import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/logging/logger_provider.dart';
import '../data/student_repository.dart';

final studentRepositoryProvider = Provider<StudentRepository>((ref) {
  return StudentRepository(
    ref.watch(databaseProvider),
    ref.watch(appLoggerProvider),
  );
});

final studentsProvider = StreamProvider<List<Student>>((ref) {
  return ref.watch(studentRepositoryProvider).watchStudents();
});

final activeStudentsProvider = StreamProvider<List<Student>>((ref) {
  return ref.watch(studentRepositoryProvider).watchActiveStudents();
});

final studentDetailProvider = StreamProvider.family<Student?, int>((ref, id) {
  return ref.watch(studentRepositoryProvider).watchStudentById(id);
});

final studentStatusFilterProvider = StateProvider<String?>((ref) => null);

final studentFormNotifierProvider =
    AsyncNotifierProvider.autoDispose<StudentFormNotifier, void>(
      StudentFormNotifier.new,
    );

class StudentFormNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<int> addStudent(StudentFormData data) async {
    state = const AsyncLoading();
    try {
      final id = await ref.read(studentRepositoryProvider).insertStudent(data);
      state = const AsyncData(null);
      return id;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> updateStudent(int id, StudentFormData data) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref.read(studentRepositoryProvider).updateStudent(id, data);
    });
  }

  Future<void> deactivateStudent(int id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref.read(studentRepositoryProvider).deactivateStudent(id);
    });
  }
}
