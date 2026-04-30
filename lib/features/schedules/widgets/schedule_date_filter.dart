import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleDateFilter extends StatelessWidget {
  const ScheduleDateFilter({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('d MMMM yyyy', 'id_ID');
    final dayFormat = DateFormat('EEEE', 'id_ID');
    final relativeLabel = _relativeLabel(selectedDate);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: .55),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          _DateNavButton(
            icon: Icons.chevron_left_rounded,
            tooltip: 'Hari sebelumnya',
            onPressed: () =>
                onDateChanged(selectedDate.subtract(const Duration(days: 1))),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: InkWell(
              onTap: () => _pickDate(context),
              borderRadius: BorderRadius.circular(18),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      relativeLabel ?? dayFormat.format(selectedDate),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      dateFormat.format(selectedDate),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          _DateNavButton(
            icon: Icons.calendar_today_outlined,
            tooltip: 'Pilih tanggal',
            onPressed: () => _pickDate(context),
          ),
          const SizedBox(width: 8),
          _DateNavButton(
            icon: Icons.chevron_right_rounded,
            tooltip: 'Hari berikutnya',
            onPressed: () =>
                onDateChanged(selectedDate.add(const Duration(days: 1))),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale('id', 'ID'),
    );
    if (picked != null) onDateChanged(picked);
  }

  String? _relativeLabel(DateTime date) {
    final selected = DateTime(date.year, date.month, date.day);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final difference = selected.difference(today).inDays;

    return switch (difference) {
      -1 => 'Kemarin',
      0 => 'Hari ini',
      1 => 'Besok',
      _ => null,
    };
  }
}

class _DateNavButton extends StatelessWidget {
  const _DateNavButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: SizedBox.square(
            dimension: 42,
            child: Icon(icon, color: colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
