import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';

class AcademicPeriodChip extends StatelessWidget {
  const AcademicPeriodChip({super.key, required this.period});

  final AcademicPeriod period;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(
        period.isActive
            ? Icons.check_circle_outline
            : Icons.calendar_today_outlined,
        size: 16,
      ),
      label: Text(period.isActive ? '${period.name} aktif' : period.name),
    );
  }
}
