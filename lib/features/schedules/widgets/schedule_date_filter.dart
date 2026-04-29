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
    final dateFormat = DateFormat('EEEE, d MMMM yyyy');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            IconButton(
              onPressed: () =>
                  onDateChanged(selectedDate.subtract(const Duration(days: 1))),
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: TextButton.icon(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) onDateChanged(picked);
                },
                icon: const Icon(Icons.calendar_today_outlined),
                label: Text(dateFormat.format(selectedDate)),
              ),
            ),
            IconButton(
              onPressed: () =>
                  onDateChanged(selectedDate.add(const Duration(days: 1))),
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
