import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';

class BackupStatusCard extends StatelessWidget {
  const BackupStatusCard({required this.lastBackup, super.key});

  final BackupMetadataData? lastBackup;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy HH:mm', 'id_ID');
    final now = DateTime.now();
    final isMissing = lastBackup == null;
    final isStale =
        !isMissing &&
        now.difference(lastBackup!.createdAt) > const Duration(days: 7);
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: isMissing || isStale ? colorScheme.errorContainer : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              isMissing || isStale ? Icons.warning_amber : Icons.verified,
              color: isMissing || isStale
                  ? colorScheme.onErrorContainer
                  : colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isMissing
                        ? 'Belum pernah backup'
                        : 'Backup terakhir ${dateFormat.format(lastBackup!.createdAt)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isMissing || isStale
                        ? 'Buat backup berkala agar data lokal lebih aman.'
                        : lastBackup!.fileName,
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
