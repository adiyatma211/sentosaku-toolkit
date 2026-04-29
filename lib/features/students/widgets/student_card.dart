import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import 'student_status_chip.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({super.key, required this.student, required this.onTap});

  final Student student;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(student.name),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(student.defaultSubject ?? '-'),
              Text(
                '${_rateTypeLabel(student.rateType)} • ${currencyFormat.format(student.rateAmount)}',
              ),
              if (student.parentName != null)
                Text('Orang tua: ${student.parentName}'),
            ],
          ),
        ),
        trailing: StudentStatusChip(status: student.status),
      ),
    );
  }

  String _rateTypeLabel(String value) {
    return switch (value) {
      'monthly' => 'Bulanan',
      'package' => 'Paket',
      _ => 'Per sesi',
    };
  }
}
