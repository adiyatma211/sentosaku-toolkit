import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/session_repository.dart';
import 'attendance_status_chip.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({super.key, required this.detail, required this.onTap});

  final SessionListItem detail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMM yyyy');
    final timeFormat = DateFormat.Hm();

    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(detail.student.name),
        subtitle: Text(
          '${detail.subject.name} • ${dateFormat.format(detail.session.sessionDate)} • '
          '${timeFormat.format(detail.session.startTime)} - ${timeFormat.format(detail.session.endTime)}',
        ),
        trailing: AttendanceStatusChip(status: detail.session.attendanceStatus),
      ),
    );
  }
}
