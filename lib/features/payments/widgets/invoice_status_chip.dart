import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';

class InvoiceStatusChip extends StatelessWidget {
  const InvoiceStatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      InvoiceStatus.unpaid => ('Belum dibayar', Colors.orange),
      InvoiceStatus.partial => ('Sebagian', Colors.blue),
      InvoiceStatus.paid => ('Lunas', Colors.green),
      InvoiceStatus.cancelled => ('Dibatalkan', Colors.grey),
      _ => (status, Colors.grey),
    };

    return Chip(
      label: Text(label),
      visualDensity: VisualDensity.compact,
      side: BorderSide(color: color.withValues(alpha: 0.4)),
      backgroundColor: color.withValues(alpha: 0.12),
      labelStyle: TextStyle(color: color.shade700),
    );
  }
}
