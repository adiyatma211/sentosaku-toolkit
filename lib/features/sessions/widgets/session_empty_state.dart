import 'package:flutter/material.dart';

class SessionEmptyState extends StatelessWidget {
  const SessionEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.history_edu_outlined,
              size: 56,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Belum ada riwayat sesi',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Buka detail jadwal untuk menandai jadwal selesai dan membuat sesi.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
