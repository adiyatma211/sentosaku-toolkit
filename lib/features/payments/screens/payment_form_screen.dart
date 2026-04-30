import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/feedback/app_toast.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../data/payment_repository.dart';
import '../providers/payment_provider.dart';

class PaymentFormScreen extends ConsumerStatefulWidget {
  const PaymentFormScreen({super.key, required this.invoiceId});

  final int invoiceId;

  @override
  ConsumerState<PaymentFormScreen> createState() => _PaymentFormScreenState();
}

class _PaymentFormScreenState extends ConsumerState<PaymentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  String _method = PaymentMethod.cash;
  DateTime _paidAt = DateTime.now();
  bool _initialized = false;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceState = ref.watch(invoiceDetailProvider(widget.invoiceId));
    final submitState = ref.watch(paymentFormNotifierProvider);

    return AppBackScope(
      fallbackPath: '/payments/${widget.invoiceId}',
      child: Scaffold(
        appBar: AppBar(title: const Text('Catat pembayaran')),
        body: invoiceState.when(
          data: (detail) {
            if (detail == null) {
              return const Center(child: Text('Invoice tidak ditemukan.'));
            }
            _initialize(detail);
            return _PaymentFormContent(
              formKey: _formKey,
              detail: detail,
              amountController: _amountController,
              noteController: _noteController,
              method: _method,
              paidAt: _paidAt,
              isSubmitting: submitState.isLoading,
              onMethodChanged: (value) {
                if (value == null) return;
                setState(() => _method = value);
              },
              onPickDate: _pickDate,
              onSubmit: () => _submit(detail),
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
    );
  }

  void _initialize(InvoiceDetail detail) {
    if (_initialized) return;
    _amountController.text = detail.remainingAmount.toString();
    _initialized = true;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _paidAt,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() => _paidAt = DateTime(picked.year, picked.month, picked.day));
  }

  Future<void> _submit(InvoiceDetail detail) async {
    if (!_formKey.currentState!.validate()) return;
    final amount = int.parse(_amountController.text.trim());

    try {
      await ref
          .read(paymentFormNotifierProvider.notifier)
          .insertPayment(
            PaymentFormData(
              invoiceId: detail.invoice.id,
              amount: amount,
              method: _method,
              paidAt: _paidAt,
              note: _noteController.text,
            ),
          );
      if (!mounted) return;
      context.go('/payments/${detail.invoice.id}');
    } catch (error) {
      if (!mounted) return;
      AppToast.error(context, 'Gagal mencatat pembayaran', details: '$error');
    }
  }
}

class _PaymentFormContent extends StatelessWidget {
  const _PaymentFormContent({
    required this.formKey,
    required this.detail,
    required this.amountController,
    required this.noteController,
    required this.method,
    required this.paidAt,
    required this.isSubmitting,
    required this.onMethodChanged,
    required this.onPickDate,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final InvoiceDetail detail;
  final TextEditingController amountController;
  final TextEditingController noteController;
  final String method;
  final DateTime paidAt;
  final bool isSubmitting;
  final ValueChanged<String?> onMethodChanged;
  final VoidCallback onPickDate;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    final dateFormat = DateFormat('d MMMM yyyy');

    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detail.student.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sisa tagihan: ${currencyFormat.format(detail.remainingAmount)}',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: amountController,
            decoration: const InputDecoration(
              labelText: 'Nominal pembayaran',
              prefixText: 'Rp ',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              final amount = int.tryParse(value?.trim() ?? '');
              if (amount == null) return 'Nominal wajib diisi';
              if (amount <= 0) return 'Nominal wajib lebih dari 0';
              if (amount > detail.remainingAmount) {
                return 'Nominal melebihi sisa tagihan';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: method,
            decoration: const InputDecoration(
              labelText: 'Metode',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: PaymentMethod.cash, child: Text('Cash')),
              DropdownMenuItem(
                value: PaymentMethod.transfer,
                child: Text('Transfer'),
              ),
              DropdownMenuItem(
                value: PaymentMethod.ewallet,
                child: Text('E-wallet'),
              ),
              DropdownMenuItem(
                value: PaymentMethod.other,
                child: Text('Lainnya'),
              ),
            ],
            onChanged: isSubmitting ? null : onMethodChanged,
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: isSubmitting ? null : onPickDate,
            icon: const Icon(Icons.calendar_today_outlined),
            label: Text(dateFormat.format(paidAt)),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: noteController,
            decoration: const InputDecoration(
              labelText: 'Catatan',
              border: OutlineInputBorder(),
            ),
            minLines: 2,
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: isSubmitting ? null : onSubmit,
            icon: isSubmitting
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save_outlined),
            label: const Text('Simpan pembayaran'),
          ),
        ],
      ),
    );
  }
}
