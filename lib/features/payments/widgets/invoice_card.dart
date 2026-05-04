import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/reminders/invoice_reminder_service.dart';
import '../data/payment_repository.dart';
import 'invoice_status_chip.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({super.key, required this.detail, required this.onTap});

  final InvoiceListItem detail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    final invoice = detail.invoice;
    final remaining = invoice.amount - invoice.paidAmount;
    final reminder = detail.reminderInfo;
    final dateFormat = DateFormat('d MMM yyyy');

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      detail.student.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  InvoiceStatusChip(status: invoice.status),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                invoice.periodLabel.isEmpty
                    ? 'Invoice #${invoice.id}'
                    : invoice.periodLabel,
              ),
              const SizedBox(height: 6),
              Text(
                invoice.dueDate == null
                    ? reminder.label
                    : 'Jatuh tempo ${dateFormat.format(invoice.dueDate!)} • ${reminder.label}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: reminder.stage == InvoiceReminderStage.overdue
                      ? Colors.red.shade700
                      : reminder.stage == InvoiceReminderStage.dueSoon
                      ? Colors.orange.shade700
                      : null,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _Amount(
                      label: 'Total',
                      value: currencyFormat.format(invoice.amount),
                    ),
                  ),
                  Expanded(
                    child: _Amount(
                      label: 'Dibayar',
                      value: currencyFormat.format(invoice.paidAmount),
                    ),
                  ),
                  Expanded(
                    child: _Amount(
                      label: 'Sisa',
                      value: currencyFormat.format(remaining),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Amount extends StatelessWidget {
  const _Amount({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
