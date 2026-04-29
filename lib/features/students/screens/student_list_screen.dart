import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/app_back_scope.dart';
import '../providers/student_provider.dart';
import '../widgets/student_card.dart';
import '../widgets/student_empty_state.dart';

class StudentListScreen extends ConsumerWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsState = ref.watch(activeStudentsProvider);

    return AppBackScope(
      fallbackPath: '/dashboard',
      child: Scaffold(
        appBar: AppBar(title: const Text('Siswa')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.go('/students/new'),
          icon: const Icon(Icons.add),
          label: const Text('Tambah'),
        ),
        body: studentsState.when(
          data: (students) {
            if (students.isEmpty) {
              return StudentEmptyState(
                onAdd: () => context.go('/students/new'),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: students.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final student = students[index];
                return StudentCard(
                  student: student,
                  onTap: () => context.go('/students/${student.id}'),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Gagal memuat siswa: $error'),
            ),
          ),
        ),
      ),
    );
  }
}
