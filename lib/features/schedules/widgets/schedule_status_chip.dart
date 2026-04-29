import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';

class ScheduleStatusChip extends StatelessWidget {
  const ScheduleStatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      ScheduleStatus.done => ('Selesai', Colors.green),
      ScheduleStatus.cancelled => ('Batal', Colors.red),
      ScheduleStatus.rescheduled => ('Reschedule', Colors.blue),
      ScheduleStatus.noShow => ('No show', Colors.orange),
      _ => ('Terjadwal', Colors.teal),
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
