import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/feedback/app_toast.dart';
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
      AppToast.error(
        context,
        'Gagal membatalkan jadwal',
        details: '${state.error}',
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
    final dateFormat = DateFormat('EEEE, d MMMM yyyy', 'id_ID');
    final timeFormat = DateFormat.Hm();
    final schedule = detail.schedule;
    final timeText =
        '${timeFormat.format(schedule.startTime)} - ${timeFormat.format(schedule.endTime)}';
    final address = detail.student.address?.trim();
    final locationText = address == null || address.isEmpty
        ? 'Lokasi belum diisi'
        : address;
    final note = schedule.note?.trim();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
      children: [
        _DetailHeader(
          studentName: detail.student.name,
          subjectName: detail.subject.name,
          status: schedule.status,
          dateText: dateFormat.format(schedule.date),
          timeText: timeText,
        ),
        const SizedBox(height: 16),
        _DetailSection(
          title: 'Waktu & Lokasi',
          icon: Icons.schedule_outlined,
          children: [
            _DetailInfoTile(
              icon: Icons.calendar_today_outlined,
              label: 'Tanggal',
              value: dateFormat.format(schedule.date),
            ),
            _DetailInfoTile(
              icon: Icons.access_time_outlined,
              label: 'Waktu les',
              value: timeText,
            ),
            _DetailInfoTile(
              icon: Icons.place_outlined,
              label: 'Lokasi',
              value: locationText,
            ),
          ],
        ),
        const SizedBox(height: 16),
        _DetailSection(
          title: 'Detail Jadwal',
          icon: Icons.event_note_outlined,
          children: [
            _DetailInfoTile(
              icon: Icons.person_outline_rounded,
              label: 'Murid',
              value: detail.student.name,
            ),
            _DetailInfoTile(
              icon: Icons.menu_book_outlined,
              label: 'Mata pelajaran',
              value: detail.subject.name,
            ),
            _DetailInfoTile(
              icon: Icons.event_repeat_outlined,
              label: 'Tipe jadwal',
              value: _typeLabel(schedule.scheduleType),
            ),
            _DetailInfoTile(
              icon: schedule.reminderEnabled
                  ? Icons.notifications_active_outlined
                  : Icons.notifications_off_outlined,
              label: 'Reminder',
              value: schedule.reminderEnabled ? 'Aktif' : 'Tidak aktif',
            ),
          ],
        ),
        const SizedBox(height: 16),
        _DetailSection(
          title: 'Catatan',
          icon: Icons.sticky_note_2_outlined,
          children: [
            Text(
              note == null || note.isEmpty ? 'Belum ada catatan.' : note,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _canCreateSession(schedule.status)
                ? onCreateSession
                : null,
            icon: const Icon(Icons.fact_check_outlined),
            label: const Text('Tandai selesai / Buat sesi'),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: FilledButton.tonalIcon(
            onPressed:
                schedule.status == ScheduleStatus.cancelled || isSubmitting
                ? null
                : onCancel,
            style: FilledButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            icon: isSubmitting
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.event_busy_outlined),
            label: const Text('Batalkan jadwal'),
          ),
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

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({
    required this.studentName,
    required this.subjectName,
    required this.status,
    required this.dateText,
    required this.timeText,
  });

  final String studentName;
  final String subjectName;
  final String status;
  final String dateText;
  final String timeText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colorScheme.primary, colorScheme.secondary],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: .18),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -24,
            top: -34,
            child: Icon(
              Icons.event_available_rounded,
              size: 126,
              color: Colors.white.withValues(alpha: .12),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          studentName,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subjectName,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: .88),
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ScheduleStatusChip(status: status),
                ],
              ),
              const SizedBox(height: 22),
              Text(
                timeText,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .18),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        dateText,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: colorScheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DetailInfoTile extends StatelessWidget {
  const _DetailInfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String? value;

  String get _resolvedValue {
    final text = value?.trim();
    return text == null || text.isEmpty ? '-' : text;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 19, color: colorScheme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _resolvedValue,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
