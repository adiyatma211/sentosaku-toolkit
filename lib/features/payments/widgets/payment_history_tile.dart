import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';

class PaymentHistoryTile extends StatelessWidget {
  const PaymentHistoryTile({super.key, required this.payment});

  final Payment payment;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    final dateFormat = DateFormat('d MMM yyyy');

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.payments_outlined),
      title: Text(currencyFormat.format(payment.amount)),
      subtitle: Text(
        '${_methodLabel(payment.method)} • ${dateFormat.format(payment.paidAt)}${_note(payment.note)}',
      ),
    );
  }

  String _methodLabel(String method) {
    return switch (method) {
      PaymentMethod.cash => 'Cash',
      PaymentMethod.transfer => 'Transfer',
      PaymentMethod.ewallet => 'E-wallet',
      PaymentMethod.other => 'Lainnya',
      _ => method,
    };
  }

  String _note(String? note) {
    if (note == null || note.trim().isEmpty) return '';
    return ' • ${note.trim()}';
  }
}
