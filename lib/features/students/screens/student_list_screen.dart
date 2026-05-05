import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../../../core/showcase/app_showcase.dart';
import '../providers/student_provider.dart';
import '../widgets/student_card.dart';
import '../widgets/student_empty_state.dart';

class StudentListScreen extends ConsumerStatefulWidget {
  const StudentListScreen({super.key});

  @override
  ConsumerState<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends ConsumerState<StudentListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentsState = ref.watch(activeStudentsProvider);
    startRequestedShowcase(
      context: context,
      ref: ref,
      tour: AppShowcaseTour.students,
      keys: _studentShowcaseKeys,
    );

    return AppBackScope(
      fallbackPath: '/dashboard',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Data Siswa'),
          actions: [
            IconButton(
              tooltip: 'Mulai panduan siswa',
              onPressed: () => startAppShowcase(context, _studentShowcaseKeys),
              icon: const Icon(Icons.help_outline_rounded),
            ),
          ],
        ),
        floatingActionButton: AppShowcaseTarget(
          showcaseKey: AppShowcaseKeys.studentAdd,
          title: 'Tambah siswa',
          description: 'Tambah siswa baru',
          child: FloatingActionButton.extended(
            heroTag: 'student-list-add-fab',
            onPressed: () => context.go('/students/new'),
            icon: const Icon(Icons.add),
            label: const Text('Tambah'),
          ),
        ),
        body: studentsState.when(
          data: (students) {
            final filteredStudents = _filterStudents(students);

            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  sliver: SliverList.list(
                    children: [
                      _StudentListHero(totalActive: students.length),
                      const SizedBox(height: 14),
                      AppShowcaseTarget(
                        showcaseKey: AppShowcaseKeys.studentSearch,
                        title: 'Pencarian siswa',
                        description: 'Cari siswa',
                        child: TextField(
                          controller: _searchController,
                          onChanged: (_) => setState(() {}),
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText:
                                'Cari nama, subject, orang tua, atau WhatsApp',
                            prefixIcon: const Icon(Icons.search_outlined),
                            suffixIcon: _searchController.text.isEmpty
                                ? null
                                : IconButton(
                                    tooltip: 'Bersihkan pencarian',
                                    onPressed: () =>
                                        setState(_searchController.clear),
                                    icon: const Icon(Icons.close_rounded),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                if (students.isEmpty)
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 112),
                    sliver: SliverToBoxAdapter(
                      child: StudentEmptyState(
                        onAdd: () => context.go('/students/new'),
                      ),
                    ),
                  )
                else if (filteredStudents.isEmpty)
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 112),
                    sliver: SliverToBoxAdapter(
                      child: _SearchEmptyState(
                        query: _searchController.text.trim(),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 112),
                    sliver: SliverList.separated(
                      itemCount: filteredStudents.length,
                      itemBuilder: (context, index) {
                        final student = filteredStudents[index];
                        final card = StudentCard(
                          student: student,
                          onTap: () => context.go('/students/${student.id}'),
                        );

                        if (index != 0) return card;

                        return AppShowcaseTarget(
                          showcaseKey: AppShowcaseKeys.studentList,
                          title: 'Daftar siswa',
                          description: 'Buka detail siswa',
                          child: card,
                        );
                      },
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                    ),
                  ),
              ],
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

  List<Student> _filterStudents(List<Student> students) {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return students;

    return students.where((student) {
      final searchable = [
        student.name,
        student.defaultSubject,
        student.parentName,
        student.whatsapp,
      ].whereType<String>().join(' ').toLowerCase();
      return searchable.contains(query);
    }).toList();
  }
}

final _studentShowcaseKeys = [
  AppShowcaseKeys.studentSearch,
  AppShowcaseKeys.studentAdd,
  AppShowcaseKeys.studentList,
];

class _StudentListHero extends StatelessWidget {
  const _StudentListHero({required this.totalActive});

  final int totalActive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.primaryContainer.withValues(alpha: .72),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(Icons.groups_rounded, color: colorScheme.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data Siswa',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Kelola profil, kontak, dan tarif murid privat.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer.withValues(
                        alpha: .78,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: colorScheme.surface.withValues(alpha: .78),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    '$totalActive',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: colorScheme.primary,
                    ),
                  ),
                  Text(
                    'Aktif',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
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

class _SearchEmptyState extends StatelessWidget {
  const _SearchEmptyState({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 44,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              'Siswa tidak ditemukan',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              'Tidak ada data siswa aktif yang cocok dengan "$query".',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
