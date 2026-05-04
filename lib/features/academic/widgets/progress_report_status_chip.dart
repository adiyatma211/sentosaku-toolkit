import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';

class ProgressReportStatusChip extends StatelessWidget {
  const ProgressReportStatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final (label, color) = switch (status) {
      ProgressReportStatus.finalized => ('Final', colorScheme.primary),
      ProgressReportStatus.exported => ('Exported', colorScheme.tertiary),
      _ => ('Draft', colorScheme.secondary),
    };
    return Chip(
      label: Text(label),
      side: BorderSide(color: color.withValues(alpha: .45)),
      backgroundColor: color.withValues(alpha: .12),
    );
  }
}
