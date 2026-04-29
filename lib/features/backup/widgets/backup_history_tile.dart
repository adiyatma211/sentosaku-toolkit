import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';

class BackupHistoryTile extends StatelessWidget {
  const BackupHistoryTile({required this.backup, super.key});

  final BackupMetadataData backup;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy HH:mm', 'id_ID');

    return Card(
      child: ListTile(
        leading: const Icon(Icons.backup),
        title: Text(backup.fileName),
        subtitle: Text(
          '${dateFormat.format(backup.createdAt)}\n${backup.filePath}',
        ),
        isThreeLine: true,
      ),
    );
  }
}
