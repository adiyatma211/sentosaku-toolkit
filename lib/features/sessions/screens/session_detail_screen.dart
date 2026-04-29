import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../data/session_repository.dart';
import '../providers/session_provider.dart';
import '../widgets/attendance_status_chip.dart';

class SessionDetailScreen extends ConsumerWidget {
  const SessionDetailScreen({super.key, required this.sessionId});

  final int sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(sessionDetailProvider(sessionId));

    return AppBackScope(
      fallbackPath: '/sessions',
      child: Scaffold(
        appBar: AppBar(title: const Text('Detail sesi')),
        body: sessionState.when(
          data: (detail) {
            if (detail == null) {
              return const Center(child: Text('Sesi tidak ditemukan.'));
            }
            return _SessionDetailContent(detail: detail);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Gagal memuat detail sesi: $error'),
            ),
          ),
        ),
      ),
    );
  }
}

class _SessionDetailContent extends StatelessWidget {
  const _SessionDetailContent({required this.detail});

  final SessionDetail detail;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMMM yyyy');
    final timeFormat = DateFormat.Hm();
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    final session = detail.session;

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
                    AttendanceStatusChip(status: session.attendanceStatus),
                  ],
                ),
                const SizedBox(height: 16),
                _InfoRow(label: 'Jadwal asal', value: '#${detail.schedule.id}'),
                _InfoRow(label: 'Mata pelajaran', value: detail.subject.name),
                _InfoRow(
                  label: 'Tanggal',
                  value: dateFormat.format(session.sessionDate),
                ),
                _InfoRow(
                  label: 'Waktu',
                  value:
                      '${timeFormat.format(session.startTime)} - ${timeFormat.format(session.endTime)}',
                ),
                _InfoRow(label: 'Materi', value: session.material),
                _InfoRow(label: 'PR', value: session.homework),
                _InfoRow(label: 'Catatan progress', value: session.note),
                _InfoRow(
                  label: 'Biaya',
                  value: currencyFormat.format(session.feeAmount),
                ),
                _InfoRow(label: 'Invoice', value: _invoiceLabel(detail)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _invoiceLabel(SessionDetail detail) {
    final invoice = detail.invoice;
    if (invoice == null) return '-';
    return '#${invoice.id} • ${_invoiceStatusLabel(invoice.status)}';
  }

  String _invoiceStatusLabel(String status) {
    return switch (status) {
      InvoiceStatus.unpaid => 'Belum dibayar',
      InvoiceStatus.partial => 'Sebagian',
      InvoiceStatus.paid => 'Lunas',
      InvoiceStatus.cancelled => 'Dibatalkan',
      _ => status,
    };
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
            width: 130,
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          Expanded(child: Text(value == null || value!.isEmpty ? '-' : value!)),
        ],
      ),
    );
  }
}
