import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/schedule_repository.dart';
import 'schedule_status_chip.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.detail, required this.onTap});

  final ScheduleDetail detail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat.Hm();

    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(detail.student.name),
        subtitle: Text(
          '${detail.subject.name} • ${timeFormat.format(detail.schedule.startTime)} - ${timeFormat.format(detail.schedule.endTime)}',
        ),
        trailing: ScheduleStatusChip(status: detail.schedule.status),
      ),
    );
  }
}
