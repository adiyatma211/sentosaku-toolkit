import 'package:flutter/material.dart';

class StudentEmptyState extends StatelessWidget {
  const StudentEmptyState({super.key, required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.school_outlined, size: 64),
            const SizedBox(height: 16),
            Text(
              'Belum ada siswa aktif',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Tambahkan siswa pertama untuk mulai mencatat jadwal dan sesi.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('Tambah siswa'),
            ),
          ],
        ),
      ),
    );
  }
}
