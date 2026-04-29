import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/report_models.dart';

class UnpaidInvoiceTile extends StatelessWidget {
  const UnpaidInvoiceTile({super.key, required this.row});

  final UnpaidReportRow row;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    final dateFormat = DateFormat('dd MMM yyyy', 'id_ID');

    return Card(
      child: ListTile(
        title: Text(row.studentName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (row.periodLabel != null) Text(row.periodLabel!),
            Text('Tagihan: ${currencyFormat.format(row.amount)}'),
            Text('Terbayar: ${currencyFormat.format(row.paidAmount)}'),
            if (row.whatsapp != null && row.whatsapp!.isNotEmpty)
              Text('WA: ${row.whatsapp}'),
            if (row.dueDate != null)
              Text('Jatuh tempo: ${dateFormat.format(row.dueDate!)}'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              currencyFormat.format(row.remaining),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(row.status),
          ],
        ),
      ),
    );
  }
}
