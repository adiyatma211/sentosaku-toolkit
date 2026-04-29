import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../providers/student_provider.dart';
import '../widgets/student_status_chip.dart';

class StudentDetailScreen extends ConsumerWidget {
  const StudentDetailScreen({super.key, required this.studentId});

  final int studentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentState = ref.watch(studentDetailProvider(studentId));
    final submitState = ref.watch(studentFormNotifierProvider);

    return AppBackScope(
      fallbackPath: '/students',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail siswa'),
          actions: [
            IconButton(
              onPressed: () => context.go('/students/$studentId/edit'),
              icon: const Icon(Icons.edit),
              tooltip: 'Edit',
            ),
          ],
        ),
        body: studentState.when(
          data: (student) {
            if (student == null) {
              return const Center(child: Text('Siswa tidak ditemukan.'));
            }

            return _StudentDetailContent(
              student: student,
              isSubmitting: submitState.isLoading,
              onDeactivate: () => _confirmDeactivate(context, ref),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Gagal memuat detail siswa: $error'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDeactivate(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nonaktifkan siswa?'),
        content: const Text(
          'Siswa tidak akan muncul di daftar siswa aktif, tetapi riwayat tetap aman.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Nonaktifkan'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    await ref
        .read(studentFormNotifierProvider.notifier)
        .deactivateStudent(studentId);
    if (!context.mounted) return;

    final state = ref.read(studentFormNotifierProvider);
    if (state.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menonaktifkan siswa: ${state.error}')),
      );
      return;
    }

    context.go('/students');
  }
}

class _StudentDetailContent extends StatelessWidget {
  const _StudentDetailContent({
    required this.student,
    required this.isSubmitting,
    required this.onDeactivate,
  });

  final Student student;
  final bool isSubmitting;
  final VoidCallback onDeactivate;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        student.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    StudentStatusChip(status: student.status),
                  ],
                ),
                const SizedBox(height: 16),
                _InfoRow(label: 'Orang tua', value: student.parentName),
                _InfoRow(label: 'WhatsApp', value: student.whatsapp),
                _InfoRow(label: 'Alamat', value: student.address),
                _InfoRow(label: 'Sekolah', value: student.school),
                _InfoRow(label: 'Kelas', value: student.grade),
                _InfoRow(
                  label: 'Mata pelajaran',
                  value: student.defaultSubject,
                ),
                _InfoRow(
                  label: 'Tipe tarif',
                  value: _rateTypeLabel(student.rateType),
                ),
                _InfoRow(
                  label: 'Tarif',
                  value: currencyFormat.format(student.rateAmount),
                ),
                _InfoRow(label: 'Catatan', value: student.note),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.tonalIcon(
          onPressed: student.status == 'inactive' || isSubmitting
              ? null
              : onDeactivate,
          icon: isSubmitting
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.person_off_outlined),
          label: const Text('Nonaktifkan siswa'),
        ),
      ],
    );
  }

  String _rateTypeLabel(String value) {
    return switch (value) {
      'monthly' => 'Bulanan',
      'package' => 'Paket',
      _ => 'Per sesi',
    };
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          Expanded(child: Text(value == null || value!.isEmpty ? '-' : value!)),
        ],
      ),
    );
  }
}
