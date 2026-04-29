import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';

class AttendanceStatusChip extends StatelessWidget {
  const AttendanceStatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      AttendanceStatus.present => ('Hadir', Colors.green),
      AttendanceStatus.permission => ('Izin', Colors.blue),
      AttendanceStatus.absent => ('Absen', Colors.orange),
      AttendanceStatus.cancelled => ('Batal', Colors.red),
      AttendanceStatus.rescheduled => ('Reschedule', Colors.purple),
      _ => ('Tidak diketahui', Colors.grey),
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
