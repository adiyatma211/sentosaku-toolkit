import 'package:flutter/material.dart';

class AttendanceRecapCard extends StatelessWidget {
  const AttendanceRecapCard({super.key, required this.summary});

  final Map<String, dynamic> summary;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rekap kehadiran',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _pill('Total', '${summary['totalSessions'] ?? 0}'),
                _pill('Hadir', '${summary['presentCount'] ?? 0}'),
                _pill('Izin', '${summary['permissionCount'] ?? 0}'),
                _pill('Absen', '${summary['absentCount'] ?? 0}'),
                _pill('Batal', '${summary['cancelledCount'] ?? 0}'),
                _pill('Reschedule', '${summary['rescheduledCount'] ?? 0}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pill(String label, String value) {
    return Chip(label: Text('$label: $value'));
  }
}
