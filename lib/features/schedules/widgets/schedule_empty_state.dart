import 'package:flutter/material.dart';

class ScheduleEmptyState extends StatelessWidget {
  const ScheduleEmptyState({super.key, required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.event_busy_outlined, size: 56),
            const SizedBox(height: 12),
            Text(
              'Belum ada jadwal pada tanggal ini.',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('Tambah jadwal'),
            ),
          ],
        ),
      ),
    );
  }
}
