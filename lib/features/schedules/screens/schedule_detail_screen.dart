import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../data/schedule_repository.dart';
import '../providers/schedule_provider.dart';
import '../widgets/schedule_status_chip.dart';

class ScheduleDetailScreen extends ConsumerWidget {
  const ScheduleDetailScreen({super.key, required this.scheduleId});

  final int scheduleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleState = ref.watch(scheduleDetailProvider(scheduleId));
    final submitState = ref.watch(scheduleFormNotifierProvider);

    return AppBackScope(
      fallbackPath: '/schedules',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail jadwal'),
          actions: [
            IconButton(
              onPressed: () => context.go('/schedules/$scheduleId/edit'),
              icon: const Icon(Icons.edit),
              tooltip: 'Edit / Reschedule',
            ),
          ],
        ),
        body: scheduleState.when(
          data: (detail) {
            if (detail == null) {
              return const Center(child: Text('Jadwal tidak ditemukan.'));
            }
            return _ScheduleDetailContent(
              detail: detail,
              isSubmitting: submitState.isLoading,
              onCancel: () => _confirmCancel(context, ref),
              onCreateSession: () =>
                  context.go('/schedules/$scheduleId/session/new'),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Gagal memuat detail jadwal: $error'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmCancel(BuildContext context, WidgetRef ref) async {
    final reasonController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Batalkan jadwal?'),
        content: TextField(
          controller: reasonController,
          decoration: const InputDecoration(labelText: 'Alasan (opsional)'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Batalkan jadwal'),
          ),
        ],
      ),
    );
    final reason = reasonController.text;
    reasonController.dispose();

    if (confirmed != true || !context.mounted) return;
    await ref
        .read(scheduleFormNotifierProvider.notifier)
        .cancelSchedule(scheduleId, reason: reason);
    if (!context.mounted) return;

    final state = ref.read(scheduleFormNotifierProvider);
    if (state.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membatalkan jadwal: ${state.error}')),
      );
      return;
    }
    context.go('/schedules');
  }
}

class _ScheduleDetailContent extends StatelessWidget {
  const _ScheduleDetailContent({
    required this.detail,
    required this.isSubmitting,
    required this.onCancel,
    required this.onCreateSession,
  });

  final ScheduleDetail detail;
  final bool isSubmitting;
  final VoidCallback onCancel;
  final VoidCallback onCreateSession;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMMM yyyy');
    final timeFormat = DateFormat.Hm();
    final schedule = detail.schedule;

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
                    ScheduleStatusChip(status: schedule.status),
                  ],
                ),
                const SizedBox(height: 16),
                _InfoRow(label: 'Mata pelajaran', value: detail.subject.name),
                _InfoRow(
                  label: 'Tanggal',
                  value: dateFormat.format(schedule.date),
                ),
                _InfoRow(
                  label: 'Waktu',
                  value:
                      '${timeFormat.format(schedule.startTime)} - ${timeFormat.format(schedule.endTime)}',
                ),
                _InfoRow(
                  label: 'Tipe',
                  value: _typeLabel(schedule.scheduleType),
                ),
                _InfoRow(
                  label: 'Reminder',
                  value: schedule.reminderEnabled ? 'Aktif' : 'Tidak aktif',
                ),
                _InfoRow(label: 'Catatan', value: schedule.note),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: _canCreateSession(schedule.status)
              ? onCreateSession
              : null,
          icon: const Icon(Icons.fact_check_outlined),
          label: const Text('Tandai selesai / Buat sesi'),
        ),
        const SizedBox(height: 8),
        FilledButton.tonalIcon(
          onPressed: schedule.status == ScheduleStatus.cancelled || isSubmitting
              ? null
              : onCancel,
          icon: isSubmitting
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.event_busy_outlined),
          label: const Text('Batalkan jadwal'),
        ),
      ],
    );
  }

  String _typeLabel(String value) {
    return switch (value) {
      ScheduleType.weekly => 'Mingguan',
      ScheduleType.custom => 'Custom',
      _ => 'Sekali',
    };
  }

  bool _canCreateSession(String status) {
    return status != ScheduleStatus.done &&
        status != ScheduleStatus.cancelled &&
        status != ScheduleStatus.noShow &&
        status != ScheduleStatus.rescheduled;
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
