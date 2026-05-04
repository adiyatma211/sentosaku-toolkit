import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/app_back_scope.dart';
import '../../../core/showcase/app_showcase.dart';
import '../providers/payment_provider.dart';
import '../widgets/invoice_card.dart';
import '../widgets/unpaid_empty_state.dart';

class InvoiceListScreen extends ConsumerWidget {
  const InvoiceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(invoiceReminderSyncProvider);
    final filter = ref.watch(invoiceListFilterProvider);
    final invoicesState = ref.watch(invoicesProvider);
    final dueSoonState = ref.watch(dueSoonInvoicesProvider);
    final overdueState = ref.watch(overdueInvoicesProvider);
    startRequestedShowcase(
      context: context,
      ref: ref,
      tour: AppShowcaseTour.payments,
      keys: _paymentShowcaseKeys,
    );

    return AppBackScope(
      fallbackPath: '/dashboard',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pembayaran'),
          actions: [
            IconButton(
              tooltip: 'Mulai panduan pembayaran',
              onPressed: () => startAppShowcase(context, _paymentShowcaseKeys),
              icon: const Icon(Icons.help_outline_rounded),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: AppShowcaseTarget(
                showcaseKey: AppShowcaseKeys.paymentFilter,
                title: 'Filter invoice',
                description: 'Pantau invoice unpaid/paid',
                child: SegmentedButton<InvoiceListFilter>(
                  segments: const [
                    ButtonSegment(
                      value: InvoiceListFilter.unpaid,
                      label: Text('Belum dibayar'),
                    ),
                    ButtonSegment(
                      value: InvoiceListFilter.all,
                      label: Text('Semua'),
                    ),
                  ],
                  selected: {filter},
                  onSelectionChanged: (selected) {
                    ref
                        .read(invoiceListFilterProvider.notifier)
                        .setFilter(selected.first);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: _ReminderSummaryCard(
                      label: 'Due soon',
                      value: dueSoonState.asData?.value.length,
                      icon: Icons.notifications_active_outlined,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _ReminderSummaryCard(
                      label: 'Overdue',
                      value: overdueState.asData?.value.length,
                      icon: Icons.warning_amber_rounded,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: invoicesState.when(
                data: (invoices) {
                  if (invoices.isEmpty) {
                    return UnpaidEmptyState(
                      showingAll: filter == InvoiceListFilter.all,
                    );
                  }
                  return AppShowcaseTarget(
                    showcaseKey: AppShowcaseKeys.paymentList,
                    title: 'Daftar invoice',
                    description: 'Buka invoice untuk catat pembayaran',
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: invoices.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final detail = invoices[index];
                        return InvoiceCard(
                          detail: detail,
                          onTap: () =>
                              context.go('/payments/${detail.invoice.id}'),
                        );
                      },
                    ),
                  );
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
          ],
        ),
      ),
    );
  }
}

final _paymentShowcaseKeys = [
  AppShowcaseKeys.paymentFilter,
  AppShowcaseKeys.paymentList,
];

class _ReminderSummaryCard extends StatelessWidget {
  const _ReminderSummaryCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final int? value;
  final IconData icon;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, color: color.shade600),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: Theme.of(context).textTheme.labelLarge),
                  Text(
                    value == null ? '...' : '$value invoice',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
