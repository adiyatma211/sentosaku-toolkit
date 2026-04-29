import 'package:flutter/material.dart';

class UnpaidEmptyState extends StatelessWidget {
  const UnpaidEmptyState({super.key, required this.showingAll});

  final bool showingAll;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.receipt_long_outlined, size: 56),
            const SizedBox(height: 12),
            Text(
              showingAll
                  ? 'Belum ada invoice.'
                  : 'Tidak ada tagihan belum dibayar.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              showingAll
                  ? 'Invoice akan muncul setelah sesi billable dibuat.'
                  : 'Tagihan unpaid dan partial akan tampil di sini.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
