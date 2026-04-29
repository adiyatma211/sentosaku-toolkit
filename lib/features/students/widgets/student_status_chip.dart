import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';

class StudentStatusChip extends StatelessWidget {
  const StudentStatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      StudentStatus.pending => ('Pending', Colors.orange),
      StudentStatus.inactive => ('Nonaktif', Colors.grey),
      _ => ('Aktif', Colors.green),
    };

    return Chip(
      label: Text(label),
      visualDensity: VisualDensity.compact,
      backgroundColor: color.withValues(alpha: 0.12),
      side: BorderSide(color: color.withValues(alpha: 0.4)),
      labelStyle: TextStyle(color: color.shade700),
    );
  }
}
