import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../../../core/reminders/invoice_reminder_service.dart';
import '../data/payment_repository.dart';
import '../providers/payment_provider.dart';
import '../widgets/invoice_status_chip.dart';
import '../widgets/payment_history_tile.dart';

class InvoiceDetailScreen extends ConsumerWidget {
  const InvoiceDetailScreen({super.key, required this.invoiceId});

  final int invoiceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoiceState = ref.watch(invoiceDetailProvider(invoiceId));

    return AppBackScope(
      fallbackPath: '/payments',
      child: Scaffold(
        appBar: AppBar(title: const Text('Detail invoice')),
        body: invoiceState.when(
          data: (detail) {
            if (detail == null) {
              return const Center(child: Text('Invoice tidak ditemukan.'));
            }
            return _InvoiceDetailContent(detail: detail);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Gagal memuat invoice: $error'),
            ),
          ),
        ),
      ),
    );
  }
}

class _InvoiceDetailContent extends ConsumerWidget {
  const _InvoiceDetailContent({required this.detail});

  final InvoiceDetail detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoice = detail.invoice;
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    final dateFormat = DateFormat('d MMMM yyyy');
    final historyState = ref.watch(paymentHistoryProvider(invoice.id));
    final canPay =
        invoice.status != InvoiceStatus.paid &&
        invoice.status != InvoiceStatus.cancelled;
    final reminderInfo = detail.reminderInfo;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
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
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    InvoiceStatusChip(status: invoice.status),
                  ],
                ),
                const SizedBox(height: 16),
                _InfoRow(label: 'Invoice', value: '#${invoice.id}'),
                _InfoRow(label: 'Periode', value: invoice.periodLabel),
                _InfoRow(
                  label: 'Sesi',
                  value: detail.session == null
                      ? '-'
                      : '#${detail.session!.id}',
                ),
                _InfoRow(
                  label: 'Total',
                  value: currencyFormat.format(invoice.amount),
                ),
                _InfoRow(
                  label: 'Dibayar',
                  value: currencyFormat.format(invoice.paidAmount),
                ),
                _InfoRow(
                  label: 'Sisa',
                  value: currencyFormat.format(detail.remainingAmount),
                ),
                _InfoRow(
                  label: 'Jatuh tempo',
                  value: invoice.dueDate == null
                      ? '-'
                      : dateFormat.format(invoice.dueDate!),
                ),
                _InfoRow(label: 'Reminder', value: reminderInfo.label),
                _InfoRow(
                  label: 'Reminder terakhir',
                  value: reminderInfo.lastRemindedAt == null
                      ? '-'
                      : dateFormat.format(reminderInfo.lastRemindedAt!),
                ),
              ],
            ),
          ),
        ),
        if (reminderInfo.needsFollowUp) ...[
          const SizedBox(height: 12),
          Card(
            color: reminderInfo.stage == InvoiceReminderStage.overdue
                ? Colors.red.withValues(alpha: 0.08)
                : Colors.orange.withValues(alpha: 0.08),
            child: ListTile(
              leading: Icon(
                reminderInfo.stage == InvoiceReminderStage.overdue
                    ? Icons.warning_amber_rounded
                    : Icons.notifications_active_outlined,
                color: reminderInfo.stage == InvoiceReminderStage.overdue
                    ? Colors.red.shade700
                    : Colors.orange.shade700,
              ),
              title: const Text('Perlu follow-up pembayaran'),
              subtitle: Text(reminderInfo.label),
            ),
          ),
        ],
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: canPay
              ? () => context.go('/payments/${invoice.id}/pay')
              : null,
          icon: const Icon(Icons.add_card_outlined),
          label: const Text('Catat pembayaran'),
        ),
        const SizedBox(height: 24),
        Text(
          'Riwayat pembayaran',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        historyState.when(
          data: (payments) {
            if (payments.isEmpty) return const Text('Belum ada pembayaran.');
            return Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: payments
                      .map((payment) => PaymentHistoryTile(payment: payment))
                      .toList(growable: false),
                ),
              ),
            );
          },
          loading: () => const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stackTrace) => Text('Gagal memuat pembayaran: $error'),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          Expanded(child: Text(value == null || value!.isEmpty ? '-' : value!)),
        ],
      ),
    );
  }
}
