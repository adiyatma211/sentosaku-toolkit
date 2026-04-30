import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/feedback/app_toast.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../providers/student_provider.dart';
import '../widgets/student_status_chip.dart';

class StudentDetailScreen extends ConsumerWidget {
  const StudentDetailScreen({super.key, required this.studentId});

  final int studentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentState = ref.watch(studentDetailProvider(studentId));
    final submitState = ref.watch(studentFormNotifierProvider);

    return AppBackScope(
      fallbackPath: '/students',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail siswa'),
          actions: [
            IconButton(
              onPressed: () => context.go('/students/$studentId/edit'),
              icon: const Icon(Icons.edit),
              tooltip: 'Edit',
            ),
          ],
        ),
        body: studentState.when(
          data: (student) {
            if (student == null) {
              return const Center(child: Text('Siswa tidak ditemukan.'));
            }

            return _StudentDetailContent(
              student: student,
              isSubmitting: submitState.isLoading,
              onDeactivate: () => _confirmDeactivate(context, ref),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Gagal memuat detail siswa: $error'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDeactivate(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nonaktifkan siswa?'),
        content: const Text(
          'Siswa tidak akan muncul di daftar siswa aktif, tetapi riwayat tetap aman.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Nonaktifkan'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    await ref
        .read(studentFormNotifierProvider.notifier)
        .deactivateStudent(studentId);
    if (!context.mounted) return;

    final state = ref.read(studentFormNotifierProvider);
    if (state.hasError) {
      AppToast.error(
        context,
        'Gagal menonaktifkan siswa',
        details: '${state.error}',
      );
      return;
    }

    context.go('/students');
  }
}

class _StudentDetailContent extends StatelessWidget {
  const _StudentDetailContent({
    required this.student,
    required this.isSubmitting,
    required this.onDeactivate,
  });

  final Student student;
  final bool isSubmitting;
  final VoidCallback onDeactivate;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      children: [
        _ProfileHeaderCard(student: student, currencyFormat: currencyFormat),
        const SizedBox(height: 16),
        _InfoSection(
          title: 'Kontak & Lokasi',
          icon: Icons.contact_phone_outlined,
          rows: [
            _InfoItem(
              Icons.family_restroom_outlined,
              'Orang tua',
              student.parentName,
            ),
            _InfoItem(Icons.chat_outlined, 'WhatsApp', student.whatsapp),
            _InfoItem(Icons.location_on_outlined, 'Alamat', student.address),
          ],
        ),
        const SizedBox(height: 16),
        _InfoSection(
          title: 'Akademik',
          icon: Icons.school_outlined,
          rows: [
            _InfoItem(Icons.apartment_outlined, 'Sekolah', student.school),
            _InfoItem(Icons.badge_outlined, 'Kelas', student.grade),
            _InfoItem(
              Icons.menu_book_outlined,
              'Mata pelajaran',
              student.defaultSubject,
            ),
          ],
        ),
        const SizedBox(height: 16),
        _InfoSection(
          title: 'Pembayaran',
          icon: Icons.payments_outlined,
          rows: [
            _InfoItem(
              Icons.sell_outlined,
              'Tipe tarif',
              _rateTypeLabel(student.rateType),
            ),
            _InfoItem(
              Icons.attach_money_outlined,
              'Tarif',
              currencyFormat.format(student.rateAmount),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _InfoSection(
          title: 'Catatan',
          icon: Icons.notes_outlined,
          rows: [
            _InfoItem(Icons.sticky_note_2_outlined, 'Catatan', student.note),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: FilledButton.tonalIcon(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: student.status == StudentStatus.inactive || isSubmitting
                ? null
                : onDeactivate,
            icon: isSubmitting
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.person_off_outlined),
            label: const Text('Nonaktifkan siswa'),
          ),
        ),
      ],
    );
  }
}

class _ProfileHeaderCard extends StatelessWidget {
  const _ProfileHeaderCard({
    required this.student,
    required this.currencyFormat,
  });

  final Student student;
  final NumberFormat currencyFormat;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.primaryContainer.withValues(alpha: .72),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  child: Text(
                    _initial(student.name),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: colorScheme.onPrimaryContainer,
                            ),
                      ),
                      const SizedBox(height: 6),
                      StudentStatusChip(status: student.status),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _HeaderPill(
                  icon: Icons.menu_book_outlined,
                  label: _fallback(student.defaultSubject),
                ),
                _HeaderPill(
                  icon: Icons.payments_outlined,
                  label:
                      '${_rateTypeLabel(student.rateType)} • ${currencyFormat.format(student.rateAmount)}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderPill extends StatelessWidget {
  const _HeaderPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: .82),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: colorScheme.primary),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({
    required this.title,
    required this.icon,
    required this.rows,
  });

  final String title;
  final IconData icon;
  final List<_InfoItem> rows;

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
            const SizedBox(height: 12),
            ...rows.map((row) => _InfoRow(item: row)),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.item});

  final _InfoItem item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, size: 18, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 10),
          SizedBox(
            width: 102,
            child: Text(
              item.label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _fallback(item.value),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem {
  const _InfoItem(this.icon, this.label, this.value);

  final IconData icon;
  final String label;
  final String? value;
}

String _initial(String name) {
  final trimmed = name.trim();
  return trimmed.isEmpty ? '?' : trimmed.substring(0, 1).toUpperCase();
}

String _fallback(String? value) {
  final trimmed = value?.trim() ?? '';
  return trimmed.isEmpty ? '-' : trimmed;
}

String _rateTypeLabel(String value) {
  return switch (value) {
    RateType.monthly => 'Bulanan',
    RateType.package => 'Paket',
    _ => 'Per sesi',
  };
}
