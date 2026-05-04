import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/feedback/app_toast.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../../academic/providers/academic_period_provider.dart';
import '../../students/providers/student_provider.dart';
import '../data/schedule_repository.dart';
import '../providers/schedule_provider.dart';
import '../providers/subject_provider.dart';

class ScheduleFormScreen extends ConsumerStatefulWidget {
  const ScheduleFormScreen({
    super.key,
    this.scheduleId,
    this.initialDate,
    this.initialStartTime,
    this.initialEndTime,
  });

  final int? scheduleId;
  final DateTime? initialDate;
  final TimeOfDay? initialStartTime;
  final TimeOfDay? initialEndTime;

  bool get isEdit => scheduleId != null;

  @override
  ConsumerState<ScheduleFormScreen> createState() => _ScheduleFormScreenState();
}

class _ScheduleFormScreenState extends ConsumerState<ScheduleFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _repeatCountController = TextEditingController(text: '4');
  final _reminderOffsetController = TextEditingController(text: '60');
  final _noteController = TextEditingController();

  int? _studentId;
  int? _academicPeriodId;
  late DateTime _date;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  String _scheduleType = ScheduleType.once;
  bool _reminderEnabled = false;
  bool _didLoadSchedule = false;

  @override
  void initState() {
    super.initState();
    _date = widget.initialDate ?? DateTime.now();
    _startTime =
        widget.initialStartTime ?? const TimeOfDay(hour: 15, minute: 0);
    _endTime = widget.initialEndTime ?? const TimeOfDay(hour: 16, minute: 0);
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _repeatCountController.dispose();
    _reminderOffsetController.dispose();
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
    final academicPeriodsState = ref.watch(academicPeriodsProvider);
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
              return _EmptyStudentsState(
                onAddStudent: () => context.go('/students/new'),
                onOpenStudents: () => context.go('/students'),
              );
            }

            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                children: [
                  _FormIntroCard(isEdit: widget.isEdit),
                  const SizedBox(height: 16),
                  _FormSection(
                    title: 'Informasi Murid',
                    icon: Icons.school_outlined,
                    children: [
                      DropdownButtonFormField<int>(
                        value:
                            students.any((student) => student.id == _studentId)
                            ? _studentId
                            : null,
                        decoration: const InputDecoration(
                          labelText: 'Siswa aktif *',
                          helperText: 'Pilih murid yang akan mengikuti les.',
                          prefixIcon: Icon(Icons.person_outline),
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
                          helperText:
                              'Pilih subject tersimpan atau ketik baru.',
                          prefixIcon: Icon(Icons.menu_book_outlined),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: _required('Mata pelajaran wajib diisi'),
                      ),
                      if (subjectsState != null)
                        subjectsState.when(
                          data: (subjects) => subjects.isEmpty
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: DropdownButtonFormField<int>(
                                    decoration: const InputDecoration(
                                      labelText: 'Subject tersimpan',
                                      helperText:
                                          'Opsional, isi otomatis dari riwayat murid.',
                                      prefixIcon: Icon(Icons.bookmark_outline),
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
                                            _subjectController.text =
                                                subject.name;
                                          },
                                  ),
                                ),
                          loading: () => const Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: LinearProgressIndicator(),
                          ),
                          error: (error, stackTrace) => Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text('Gagal memuat subject: $error'),
                          ),
                        ),
                      const SizedBox(height: 12),
                      academicPeriodsState.when(
                        data: (periods) {
                          if (periods.isEmpty) {
                            return const InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Periode akademik',
                                helperText:
                                    'Belum ada periode akademik aktif yang bisa dipilih.',
                                prefixIcon: Icon(Icons.school_outlined),
                              ),
                              child: Text('Tidak ada data periode akademik'),
                            );
                          }

                          final selectedValue =
                              periods.any(
                                (period) => period.id == _academicPeriodId,
                              )
                              ? _academicPeriodId
                              : null;
                          return DropdownButtonFormField<int>(
                            value: selectedValue,
                            decoration: const InputDecoration(
                              labelText: 'Periode akademik',
                              helperText:
                                  'Mengikuti periode aktif murid, tetapi tetap bisa disesuaikan.',
                              prefixIcon: Icon(Icons.school_outlined),
                            ),
                            items: periods
                                .map(
                                  (period) => DropdownMenuItem(
                                    value: period.id,
                                    child: Text(period.name),
                                  ),
                                )
                                .toList(),
                            onChanged: isSubmitting
                                ? null
                                : (value) =>
                                      setState(() => _academicPeriodId = value),
                            validator: (value) {
                              final selectedStudent = students.where(
                                (student) => student.id == _studentId,
                              );
                              if (selectedStudent.isEmpty) return null;
                              if (selectedStudent
                                          .first
                                          .defaultAcademicPeriodId !=
                                      null &&
                                  value == null) {
                                return 'Periode akademik wajib dipilih';
                              }
                              return null;
                            },
                          );
                        },
                        loading: () => const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: LinearProgressIndicator(),
                        ),
                        error: (error, stackTrace) =>
                            Text('Gagal memuat periode akademik: $error'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _FormSection(
                    title: 'Waktu Les',
                    icon: Icons.schedule_outlined,
                    children: [
                      _PickerField(
                        icon: Icons.calendar_today_outlined,
                        label: 'Tanggal *',
                        value: dateFormat.format(_date),
                        onTap: isSubmitting ? null : _pickDate,
                      ),
                      const SizedBox(height: 12),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isNarrow = constraints.maxWidth < 420;
                          final fields = [
                            _PickerField(
                              icon: Icons.access_time_outlined,
                              label: 'Jam mulai *',
                              value: _startTime.format(context),
                              onTap: isSubmitting
                                  ? null
                                  : () => _pickTime(isStart: true),
                            ),
                            _PickerField(
                              icon: Icons.timer_outlined,
                              label: 'Jam selesai *',
                              value: _endTime.format(context),
                              onTap: isSubmitting
                                  ? null
                                  : () => _pickTime(isStart: false),
                            ),
                          ];
                          if (isNarrow) {
                            return Column(
                              children: [
                                fields.first,
                                const SizedBox(height: 12),
                                fields.last,
                              ],
                            );
                          }
                          return Row(
                            children: [
                              Expanded(child: fields.first),
                              const SizedBox(width: 12),
                              Expanded(child: fields.last),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _scheduleType,
                        decoration: const InputDecoration(
                          labelText: 'Tipe jadwal *',
                          helperText: 'Pilih sekali atau berulang mingguan.',
                          prefixIcon: Icon(Icons.event_repeat_outlined),
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
                                () =>
                                    _scheduleType = value ?? ScheduleType.once,
                              ),
                      ),
                      if (!widget.isEdit &&
                          _scheduleType == ScheduleType.weekly) ...[
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _repeatCountController,
                          decoration: const InputDecoration(
                            labelText: 'Jumlah pengulangan *',
                            helperText: 'Berapa kali jadwal mingguan dibuat.',
                            prefixIcon: Icon(Icons.repeat_outlined),
                          ),
                          keyboardType: TextInputType.number,
                          validator: _validateRepeatCount,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  _FormSection(
                    title: 'Catatan & Reminder',
                    icon: Icons.notifications_active_outlined,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                              .withValues(alpha: .55),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                        ),
                        child: SwitchListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          secondary: const Icon(Icons.alarm_outlined),
                          title: const Text('Reminder'),
                          subtitle: const Text(
                            'Siapkan kontrak reminder lokal dan log offline-first.',
                          ),
                          value: _reminderEnabled,
                          onChanged: isSubmitting
                              ? null
                              : (value) =>
                                    setState(() => _reminderEnabled = value),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _reminderOffsetController,
                        decoration: const InputDecoration(
                          labelText: 'Offset reminder (menit)',
                          helperText:
                              'Default 60 menit sebelum les. Isi 0 untuk tepat saat mulai.',
                          prefixIcon: Icon(Icons.more_time_outlined),
                        ),
                        keyboardType: TextInputType.number,
                        validator: _validateReminderOffset,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _noteController,
                        decoration: const InputDecoration(
                          labelText: 'Catatan',
                          helperText:
                              'Opsional, misalnya materi atau instruksi khusus.',
                          prefixIcon: Icon(Icons.notes_outlined),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        textStyle: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
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
    _academicPeriodId = schedule.academicPeriodId;
    _subjectController.text = detail.subject.name;
    _date = schedule.date;
    _startTime = TimeOfDay.fromDateTime(schedule.startTime);
    _endTime = TimeOfDay.fromDateTime(schedule.endTime);
    _scheduleType = schedule.scheduleType == ScheduleType.weekly
        ? ScheduleType.weekly
        : ScheduleType.once;
    _reminderEnabled = schedule.reminderEnabled;
    _reminderOffsetController.text = schedule.reminderOffsetMinutes.toString();
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
      if (student?.defaultAcademicPeriodId != null) {
        _academicPeriodId = student!.defaultAcademicPeriodId;
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
      AppToast.warning(
        context,
        'Jam selesai harus lebih besar dari jam mulai',
        title: 'Validasi Jadwal',
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
        academicPeriodId: _academicPeriodId,
        reminderOffsetMinutes:
            int.tryParse(_reminderOffsetController.text.trim()) ?? 60,
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
      AppToast.error(context, 'Gagal menyimpan jadwal', details: '$error');
    }
  }

  void _showSubmitResult({required VoidCallback onSuccess}) {
    final state = ref.read(scheduleFormNotifierProvider);
    if (state.hasError) {
      AppToast.error(
        context,
        'Gagal menyimpan jadwal',
        details: '${state.error}',
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

  String? _validateReminderOffset(String? value) {
    final parsed = int.tryParse(value?.trim() ?? '');
    if (parsed == null || parsed < 0) {
      return 'Offset reminder harus 0 atau lebih';
    }
    return null;
  }
}

class _FormIntroCard extends StatelessWidget {
  const _FormIntroCard({required this.isEdit});

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.primaryContainer.withValues(alpha: .72),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                Icons.event_available_outlined,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Atur Jadwal Les',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isEdit
                        ? 'Perbarui murid, waktu, dan catatan jadwal dengan jelas.'
                        : 'Lengkapi murid, mata pelajaran, waktu les, dan reminder.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer.withValues(
                        alpha: .78,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection({
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
                      color: colorScheme.onSurface,
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

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: .55),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Row(
            children: [
              Icon(icon, color: colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyStudentsState extends StatelessWidget {
  const _EmptyStudentsState({
    required this.onAddStudent,
    required this.onOpenStudents,
  });

  final VoidCallback onAddStudent;
  final VoidCallback onOpenStudents;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_add_alt_1_outlined,
                    size: 36,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Belum ada siswa aktif',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tambahkan siswa terlebih dahulu agar jadwal les bisa dibuat.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: onAddStudent,
                    icon: const Icon(Icons.add),
                    label: const Text('Tambah siswa'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: onOpenStudents,
                    icon: const Icon(Icons.people_outline),
                    label: const Text('Lihat daftar siswa'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
