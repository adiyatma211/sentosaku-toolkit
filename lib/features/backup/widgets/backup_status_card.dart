import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/backup_provider.dart';

class BackupStatusCard extends StatelessWidget {
  const BackupStatusCard({required this.status, super.key});

  final BackupStatus status;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy HH:mm', 'id_ID');
    final lastBackup = status.lastBackup;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: status.hasWarning ? colorScheme.errorContainer : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  status.hasWarning ? Icons.warning_amber : Icons.verified,
                  color: status.hasWarning
                      ? colorScheme.onErrorContainer
                      : colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lastBackup == null
                            ? 'Belum pernah backup'
                            : 'Backup terakhir ${dateFormat.format(lastBackup.createdAt)}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(status.warningMessage),
                    ],
                  ),
                ),
              ],
            ),
            if (lastBackup != null) ...[
              const SizedBox(height: 12),
              Text('File: ${lastBackup.fileName}'),
              Text('Lokasi: ${lastBackup.filePath}'),
              Text('Ukuran: ${_formatBytes(status.fileSizeBytes)}'),
            ],
          ],
        ),
      ),
    );
  }

  String _formatBytes(int? bytes) {
    if (bytes == null) return 'tidak tersedia';
    if (bytes < 1024) return '$bytes B';
    final kb = bytes / 1024;
    if (kb < 1024) return '${kb.toStringAsFixed(1)} KB';
    return '${(kb / 1024).toStringAsFixed(1)} MB';
  }
}
