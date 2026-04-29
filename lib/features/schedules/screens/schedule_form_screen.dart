import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../../students/providers/student_provider.dart';
import '../data/schedule_repository.dart';
import '../providers/schedule_provider.dart';
import '../providers/subject_provider.dart';

class ScheduleFormScreen extends ConsumerStatefulWidget {
  const ScheduleFormScreen({super.key, this.scheduleId});

  final int? scheduleId;

  bool get isEdit => scheduleId != null;

  @override
  ConsumerState<ScheduleFormScreen> createState() => _ScheduleFormScreenState();
}

class _ScheduleFormScreenState extends ConsumerState<ScheduleFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _repeatCountController = TextEditingController(text: '4');
  final _noteController = TextEditingController();

  int? _studentId;
  DateTime _date = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 15, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 16, minute: 0);
  String _scheduleType = ScheduleType.once;
  bool _reminderEnabled = false;
  bool _didLoadSchedule = false;

  @override
  void dispose() {
    _subjectController.dispose();
    _repeatCountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submitState = ref.watch(scheduleFormNotifierProvider);
    final detailState = widget.scheduleId == null
        ? null
        : ref.watch(scheduleDetailProvider(widget.scheduleId!));

    if (detailState != null) {
      return detailState.when(
        data: (detail) {
          if (detail == null) {
            return AppBackScope(
              fallbackPath: _fallbackPath,
              child: const Scaffold(
                body: Center(child: Text('Jadwal tidak ditemukan.')),
              ),
            );
          }
          _loadSchedule(detail);
          return _buildForm(context, submitState.isLoading);
        },
        loading: () => AppBackScope(
          fallbackPath: _fallbackPath,
          child: const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        ),
        error: (error, stackTrace) => AppBackScope(
          fallbackPath: _fallbackPath,
          child: Scaffold(
            appBar: AppBar(title: const Text('Edit jadwal')),
            body: Center(child: Text('Gagal memuat jadwal: $error')),
          ),
        ),
      );
    }

    return _buildForm(context, submitState.isLoading);
  }

  Widget _buildForm(BuildContext context, bool isSubmitting) {
    final studentsState = ref.watch(activeStudentsProvider);
    final subjectsState = _studentId == null
        ? null
        : ref.watch(subjectsByStudentProvider(_studentId!));
    final dateFormat = DateFormat('d MMMM yyyy');

    return AppBackScope(
      fallbackPath: _fallbackPath,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isEdit ? 'Edit / Reschedule jadwal' : 'Tambah jadwal',
          ),
        ),
        body: studentsState.when(
          data: (students) {
            if (students.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('Tambahkan siswa aktif sebelum membuat jadwal.'),
                ),
              );
            }

            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  DropdownButtonFormField<int>(
                    value: students.any((student) => student.id == _studentId)
                        ? _studentId
                        : null,
                    decoration: const InputDecoration(
                      labelText: 'Siswa aktif *',
                    ),
                    items: students
                        .map(
                          (student) => DropdownMenuItem(
                            value: student.id,
                            child: Text(student.name),
                          ),
                        )
                        .toList(),
                    onChanged: isSubmitting
                        ? null
                        : (value) => _selectStudent(value, students),
                    validator: (value) =>
                        value == null ? 'Siswa wajib dipilih' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _subjectController,
                    decoration: const InputDecoration(
                      labelText: 'Mata pelajaran *',
                      helperText: 'Pilih dari daftar atau ketik subject baru.',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: _required('Mata pelajaran wajib diisi'),
                  ),
                  if (subjectsState != null)
                    subjectsState.when(
                      data: (subjects) => subjects.isEmpty
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: DropdownButtonFormField<int>(
                                decoration: const InputDecoration(
                                  labelText: 'Subject tersimpan',
                                ),
                                items: subjects
                                    .map(
                                      (subject) => DropdownMenuItem(
                                        value: subject.id,
                                        child: Text(subject.name),
                                      ),
                                    )
                                    .toList(),
                                onChanged: isSubmitting
                                    ? null
                                    : (id) {
                                        final subject = subjects.firstWhere(
                                          (subject) => subject.id == id,
                                        );
                                        _subjectController.text = subject.name;
                                      },
                              ),
                            ),
                      loading: () => const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: LinearProgressIndicator(),
                      ),
                      error: (error, stackTrace) => Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text('Gagal memuat subject: $error'),
                      ),
                    ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Tanggal *'),
                    subtitle: Text(dateFormat.format(_date)),
                    trailing: const Icon(Icons.calendar_today_outlined),
                    onTap: isSubmitting ? null : _pickDate,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Jam mulai *'),
                          subtitle: Text(_startTime.format(context)),
                          onTap: isSubmitting
                              ? null
                              : () => _pickTime(isStart: true),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Jam selesai *'),
                          subtitle: Text(_endTime.format(context)),
                          onTap: isSubmitting
                              ? null
                              : () => _pickTime(isStart: false),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _scheduleType,
                    decoration: const InputDecoration(
                      labelText: 'Tipe jadwal *',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: ScheduleType.once,
                        child: Text('Sekali'),
                      ),
                      DropdownMenuItem(
                        value: ScheduleType.weekly,
                        child: Text('Mingguan'),
                      ),
                    ],
                    onChanged: widget.isEdit || isSubmitting
                        ? null
                        : (value) => setState(
                            () => _scheduleType = value ?? ScheduleType.once,
                          ),
                  ),
                  if (!widget.isEdit &&
                      _scheduleType == ScheduleType.weekly) ...[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _repeatCountController,
                      decoration: const InputDecoration(
                        labelText: 'Jumlah pengulangan *',
                      ),
                      keyboardType: TextInputType.number,
                      validator: _validateRepeatCount,
                    ),
                  ],
                  const SizedBox(height: 12),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Reminder'),
                    subtitle: const Text(
                      'Placeholder notifikasi lokal Sprint 03',
                    ),
                    value: _reminderEnabled,
                    onChanged: isSubmitting
                        ? null
                        : (value) => setState(() => _reminderEnabled = value),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _noteController,
                    decoration: const InputDecoration(labelText: 'Catatan'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: isSubmitting ? null : _submit,
                    icon: isSubmitting
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save_outlined),
                    label: Text(
                      widget.isEdit ? 'Simpan jadwal' : 'Tambah jadwal',
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Gagal memuat siswa aktif: $error'),
            ),
          ),
        ),
      ),
    );
  }

  String get _fallbackPath => widget.scheduleId == null
      ? '/schedules'
      : '/schedules/${widget.scheduleId}';

  void _loadSchedule(ScheduleDetail detail) {
    if (_didLoadSchedule) return;
    _didLoadSchedule = true;
    final schedule = detail.schedule;
    _studentId = schedule.studentId;
    _subjectController.text = detail.subject.name;
    _date = schedule.date;
    _startTime = TimeOfDay.fromDateTime(schedule.startTime);
    _endTime = TimeOfDay.fromDateTime(schedule.endTime);
    _scheduleType = schedule.scheduleType == ScheduleType.weekly
        ? ScheduleType.weekly
        : ScheduleType.once;
    _reminderEnabled = schedule.reminderEnabled;
    _noteController.text = schedule.note ?? '';
  }

  void _selectStudent(int? value, List<Student> students) {
    setState(() {
      _studentId = value;
      Student? student;
      for (final item in students) {
        if (item.id == value) {
          student = item;
          break;
        }
      }
      if (_subjectController.text.trim().isEmpty) {
        _subjectController.text = student?.defaultSubject ?? '';
      }
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _date = DateTime(picked.year, picked.month, picked.day));
    }
  }

  Future<void> _pickTime({required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _startTime = picked;
      } else {
        _endTime = picked;
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final start = _combine(_date, _startTime);
    final end = _combine(_date, _endTime);
    if (!end.isAfter(start)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Jam selesai harus lebih besar dari jam mulai'),
        ),
      );
      return;
    }

    final studentId = _studentId;
    if (studentId == null) return;

    try {
      final subjectId = await ref
          .read(subjectRepositoryProvider)
          .ensureSubjectForStudent(
            studentId: studentId,
            name: _subjectController.text,
          );
      final data = ScheduleFormData(
        studentId: studentId,
        subjectId: subjectId,
        date: _date,
        startTime: start,
        endTime: end,
        scheduleType: _scheduleType,
        reminderEnabled: _reminderEnabled,
        note: _noteController.text,
        repeatCount: int.tryParse(_repeatCountController.text.trim()) ?? 1,
      );

      if (widget.scheduleId == null) {
        final id = await ref
            .read(scheduleFormNotifierProvider.notifier)
            .addSchedule(data);
        if (!mounted) return;
        _showSubmitResult(onSuccess: () => context.go('/schedules/$id'));
        return;
      }

      await ref
          .read(scheduleFormNotifierProvider.notifier)
          .updateSchedule(widget.scheduleId!, data);
      if (!mounted) return;
      _showSubmitResult(
        onSuccess: () => context.go('/schedules/${widget.scheduleId}'),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan jadwal: $error')));
    }
  }

  void _showSubmitResult({required VoidCallback onSuccess}) {
    final state = ref.read(scheduleFormNotifierProvider);
    if (state.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan jadwal: ${state.error}')),
      );
      return;
    }
    onSuccess();
  }

  DateTime _combine(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  FormFieldValidator<String> _required(String message) {
    return (value) => value == null || value.trim().isEmpty ? message : null;
  }

  String? _validateRepeatCount(String? value) {
    if (_scheduleType != ScheduleType.weekly) return null;
    final count = int.tryParse(value?.trim() ?? '');
    if (count == null || count <= 0) {
      return 'Jumlah pengulangan harus lebih dari 0';
    }
    return null;
  }
}
