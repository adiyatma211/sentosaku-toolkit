import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';

class StudentStatusChip extends StatelessWidget {
  const StudentStatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final (label, color, foreground) = switch (status) {
      StudentStatus.pending => (
        'Pending',
        colorScheme.tertiaryContainer,
        colorScheme.onTertiaryContainer,
      ),
      StudentStatus.inactive => (
        'Nonaktif',
        colorScheme.surfaceContainerHighest,
        colorScheme.onSurfaceVariant,
      ),
      _ => (
        'Aktif',
        colorScheme.secondaryContainer,
        colorScheme.onSecondaryContainer,
      ),
    };

    return Chip(
      label: Text(label),
      visualDensity: VisualDensity.compact,
      backgroundColor: color,
      side: BorderSide(color: foreground.withValues(alpha: 0.18)),
      labelStyle: TextStyle(color: foreground, fontWeight: FontWeight.w700),
    );
  }
}
