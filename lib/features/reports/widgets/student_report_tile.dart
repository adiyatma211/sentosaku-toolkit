import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/report_models.dart';

class StudentReportTile extends StatelessWidget {
  const StudentReportTile({super.key, required this.row});

  final StudentReportRow row;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Card(
      child: ListTile(
        title: Text(row.studentName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sesi selesai: ${row.totalSessions}'),
            Text(
              'Total tagihan: ${currencyFormat.format(row.totalInvoiceAmount)}',
            ),
            Text('Total bayar: ${currencyFormat.format(row.totalPaidAmount)}'),
            if (row.whatsapp != null && row.whatsapp!.isNotEmpty)
              Text('WA: ${row.whatsapp}'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              currencyFormat.format(row.outstandingAmount),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Text('Sisa'),
          ],
        ),
      ),
    );
  }
}
