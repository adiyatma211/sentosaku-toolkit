import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/feedback/app_toast.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../../students/providers/student_provider.dart';
import '../data/academic_period_repository.dart';
import '../providers/academic_period_provider.dart';

class StudentPeriodAssignmentScreen extends ConsumerStatefulWidget {
  const StudentPeriodAssignmentScreen({super.key, required this.studentId});

  final int studentId;

  @override
  ConsumerState<StudentPeriodAssignmentScreen> createState() =>
      _StudentPeriodAssignmentScreenState();
}

class _StudentPeriodAssignmentScreenState
    extends ConsumerState<StudentPeriodAssignmentScreen> {
  int? _periodId;
  String _status = StudentPeriodStatus.active;
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentDetailProvider(widget.studentId));
    final periodsState = ref.watch(academicPeriodsProvider);
    final assignmentsState = ref.watch(
      studentPeriodAssignmentsProvider(widget.studentId),
    );
    final submitState = ref.watch(studentPeriodAssignmentNotifierProvider);
    final dateFormat = DateFormat('d MMM yyyy');

    return AppBackScope(
      fallbackPath: '/students/${widget.studentId}',
      child: Scaffold(
        appBar: AppBar(title: const Text('Assignment periode siswa')),
        body: studentState.when(
          data: (student) {
            if (student == null) {
              return const Center(child: Text('Siswa tidak ditemukan.'));
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  student.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                periodsState.when(
                  data: (periods) => DropdownButtonFormField<int>(
                    value: periods.any((period) => period.id == _periodId)
                        ? _periodId
                        : null,
                    decoration: const InputDecoration(
                      labelText: 'Periode akademik *',
                    ),
                    items: periods
                        .map(
                          (period) => DropdownMenuItem(
                            value: period.id,
                            child: Text(period.name),
                          ),
                        )
                        .toList(),
                    onChanged: submitState.isLoading
                        ? null
                        : (value) => setState(() => _periodId = value),
                  ),
                  loading: () => const LinearProgressIndicator(),
                  error: (error, stackTrace) => Text('$error'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _status,
                  decoration: const InputDecoration(
                    labelText: 'Status assignment',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: StudentPeriodStatus.active,
                      child: Text('Active'),
                    ),
                    DropdownMenuItem(
                      value: StudentPeriodStatus.completed,
                      child: Text('Completed'),
                    ),
                    DropdownMenuItem(
                      value: StudentPeriodStatus.inactive,
                      child: Text('Inactive'),
                    ),
                  ],
                  onChanged: submitState.isLoading
                      ? null
                      : (value) => setState(
                          () => _status = value ?? StudentPeriodStatus.active,
                        ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    labelText: 'Catatan assignment',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: submitState.isLoading ? null : _submit,
                  icon: const Icon(Icons.link_outlined),
                  label: const Text('Assign ke periode'),
                ),
                const SizedBox(height: 24),
                Text(
                  'Riwayat assignment',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                assignmentsState.when(
                  data: (items) => Column(
                    children: items
                        .map(
                          (item) => Card(
                            child: ListTile(
                              title: Text(item.academicPeriod.name),
                              subtitle: Text(
                                '${item.studentPeriod.status} • ${dateFormat.format(item.academicPeriod.startDate)} - ${dateFormat.format(item.academicPeriod.endDate)}',
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stackTrace) =>
                      Text('Gagal memuat riwayat: $error'),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) =>
              Center(child: Text('Gagal memuat siswa: $error')),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_periodId == null) {
      AppToast.warning(context, 'Periode akademik wajib dipilih');
      return;
    }
    try {
      await ref
          .read(studentPeriodAssignmentNotifierProvider.notifier)
          .assign(
            StudentPeriodAssignmentFormData(
              studentId: widget.studentId,
              academicPeriodId: _periodId!,
              status: _status,
              note: _noteController.text,
            ),
          );
      if (!mounted) return;
      AppToast.success(context, 'Assignment periode tersimpan');
      _noteController.clear();
    } catch (error) {
      if (!mounted) return;
      AppToast.error(context, 'Gagal menyimpan assignment', details: '$error');
    }
  }
}
