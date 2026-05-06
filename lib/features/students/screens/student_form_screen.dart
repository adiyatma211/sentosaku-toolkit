import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/feedback/app_toast.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../../academic/providers/academic_period_provider.dart';
import '../data/student_repository.dart';
import '../providers/student_provider.dart';

class StudentFormScreen extends ConsumerStatefulWidget {
  const StudentFormScreen({super.key, this.studentId});

  final int? studentId;

  bool get isEdit => studentId != null;

  @override
  ConsumerState<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends ConsumerState<StudentFormScreen> {
  final _currencyFormatter = NumberFormat.decimalPattern('id_ID');
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _parentNameController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _addressController = TextEditingController();
  final _schoolController = TextEditingController();
  final _gradeController = TextEditingController();
  final _defaultSubjectController = TextEditingController();
  final _rateAmountController = TextEditingController();
  final _noteController = TextEditingController();

  String _rateType = RateType.perSession;
  String _status = StudentStatus.active;
  int? _defaultAcademicPeriodId;
  bool _didLoadStudent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _parentNameController.dispose();
    _whatsappController.dispose();
    _addressController.dispose();
    _schoolController.dispose();
    _gradeController.dispose();
    _defaultSubjectController.dispose();
    _rateAmountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submitState = ref.watch(studentFormNotifierProvider);
    final academicPeriodsState = ref.watch(academicPeriodsProvider);
    final detailState = widget.studentId == null
        ? null
        : ref.watch(studentDetailProvider(widget.studentId!));

    if (detailState != null) {
      return detailState.when(
        data: (student) {
          if (student == null) {
            return AppBackScope(
              fallbackPath: _fallbackPath,
              child: const Scaffold(
                body: Center(child: Text('Siswa tidak ditemukan.')),
              ),
            );
          }
          _loadStudent(student);
          return _buildForm(
            context,
            submitState.isLoading,
            academicPeriodsState,
          );
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
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => _handleBackNavigation(context),
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text('Edit siswa'),
            ),
            body: Center(child: Text('Gagal memuat siswa: $error')),
          ),
        ),
      );
    }

    return _buildForm(context, submitState.isLoading, academicPeriodsState);
  }

  InputDecoration _fieldDecoration({
    required String label,
    required IconData icon,
    String? helperText,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderRadius = BorderRadius.circular(16);

    return InputDecoration(
      labelText: label,
      helperText: helperText,
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: .3),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: colorScheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: colorScheme.outline.withValues(alpha: .7),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: colorScheme.primary, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: colorScheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: colorScheme.error, width: 1.6),
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    bool isSubmitting,
    AsyncValue<List<AcademicPeriod>> academicPeriodsState,
  ) {
    final academicPeriods =
        academicPeriodsState.asData?.value ?? const <AcademicPeriod>[];
    final academicPeriodItems = _academicPeriodItems(academicPeriods);
    final selectedAcademicPeriodId = _selectedAcademicPeriodId(
      academicPeriodItems,
    );

    return AppBackScope(
      fallbackPath: _fallbackPath,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => _handleBackNavigation(context),
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(widget.isEdit ? 'Edit siswa' : 'Tambah siswa'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            children: [
              _FormSection(
                title: 'Informasi Pribadi',
                icon: Icons.badge_outlined,
                description: 'Data inti murid untuk profil dan jadwal les.',
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: _fieldDecoration(
                      label: 'Nama lengkap *',
                      icon: Icons.person_outline,
                    ),
                    textInputAction: TextInputAction.next,
                    validator: _required('Nama siswa wajib diisi'),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: _gradeController,
                          decoration: _fieldDecoration(
                            label: 'Kelas',
                            icon: Icons.school_outlined,
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          controller: _schoolController,
                          decoration: _fieldDecoration(
                            label: 'Sekolah',
                            icon: Icons.apartment_outlined,
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _FormSection(
                title: 'Akademik',
                icon: Icons.menu_book_outlined,
                description:
                    'Atur mapel utama dan periode default bila sudah tersedia.',
                children: [
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _defaultSubjectController,
                    decoration: _fieldDecoration(
                      label: 'Mata pelajaran utama *',
                      icon: Icons.menu_book_outlined,
                      helperText:
                          'Contoh: Matematika, Bahasa Inggris, atau Fisika.',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: _required('Mata pelajaran utama wajib diisi'),
                  ),
                  if (academicPeriodsState.isLoading) ...[
                    const SizedBox(height: 12),
                    const LinearProgressIndicator(minHeight: 2),
                  ] else if (academicPeriodItems.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    DropdownButtonFormField<int?>(
                      value: selectedAcademicPeriodId,
                      decoration: _fieldDecoration(
                        label: 'Periode akademik default',
                        icon: Icons.calendar_month_outlined,
                      ),
                      items: academicPeriodItems,
                      onChanged: isSubmitting
                          ? null
                          : (value) => setState(
                              () => _defaultAcademicPeriodId = value,
                            ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),
              _FormSection(
                title: 'Kontak Wali',
                icon: Icons.contact_phone_outlined,
                description:
                    'Kontak utama untuk komunikasi dan kebutuhan les privat.',
                children: [
                  TextFormField(
                    controller: _parentNameController,
                    decoration: _fieldDecoration(
                      label: 'Nama wali',
                      icon: Icons.family_restroom_outlined,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _whatsappController,
                    decoration: _fieldDecoration(
                      label: 'No. WhatsApp',
                      icon: Icons.chat_outlined,
                      helperText: 'Gunakan kode negara jika diperlukan.',
                    ),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: _validateWhatsapp,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _addressController,
                    decoration: _fieldDecoration(
                      label: 'Alamat',
                      icon: Icons.location_on_outlined,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _FormSection(
                title: 'Tarif & Status',
                icon: Icons.payments_outlined,
                description:
                    'Pilihan ini tetap memakai nilai data yang sama seperti sebelumnya.',
                children: [
                  Text(
                    'Tipe tarif *',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _SelectionTile(
                        label: 'Per sesi',
                        icon: Icons.event_available_outlined,
                        selected: _rateType == RateType.perSession,
                        onTap: isSubmitting
                            ? null
                            : () => setState(
                                () => _rateType = RateType.perSession,
                              ),
                      ),
                      _SelectionTile(
                        label: 'Bulanan',
                        icon: Icons.calendar_view_month_outlined,
                        selected: _rateType == RateType.monthly,
                        onTap: isSubmitting
                            ? null
                            : () =>
                                  setState(() => _rateType = RateType.monthly),
                      ),
                      _SelectionTile(
                        label: 'Paket',
                        icon: Icons.inventory_2_outlined,
                        selected: _rateType == RateType.package,
                        onTap: isSubmitting
                            ? null
                            : () =>
                                  setState(() => _rateType = RateType.package),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pilih pola penagihan yang dipakai untuk siswa ini.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _rateAmountController,
                    decoration: _fieldDecoration(
                      label: 'Nominal tarif *',
                      icon: Icons.attach_money_outlined,
                      helperText:
                          'Masukkan angka penuh sesuai tipe tarif yang dipilih.',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        final digits = _digitsOnly(newValue.text);
                        if (digits.isEmpty) {
                          return const TextEditingValue();
                        }

                        final formatted = _currencyFormatter.format(
                          int.parse(digits),
                        );
                        return TextEditingValue(
                          text: formatted,
                          selection: TextSelection.collapsed(
                            offset: formatted.length,
                          ),
                        );
                      }),
                    ],
                    textInputAction: TextInputAction.next,
                    validator: _validateRateAmount,
                  ),
                  const SizedBox(height: 12),
                  const SizedBox(height: 16),
                  Text(
                    'Status',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _SelectionTile(
                        label: 'Aktif',
                        icon: Icons.check_circle_outline,
                        selected: _status == StudentStatus.active,
                        onTap: isSubmitting
                            ? null
                            : () => setState(
                                () => _status = StudentStatus.active,
                              ),
                      ),
                      _SelectionTile(
                        label: 'Pending',
                        icon: Icons.schedule_outlined,
                        selected: _status == StudentStatus.pending,
                        onTap: isSubmitting
                            ? null
                            : () => setState(
                                () => _status = StudentStatus.pending,
                              ),
                      ),
                      _SelectionTile(
                        label: 'Nonaktif',
                        icon: Icons.pause_circle_outline,
                        selected: _status == StudentStatus.inactive,
                        onTap: isSubmitting
                            ? null
                            : () => setState(
                                () => _status = StudentStatus.inactive,
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Status membantu membedakan siswa aktif, calon, atau jeda belajar.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _FormSection(
                title: 'Catatan',
                icon: Icons.notes_outlined,
                description:
                    'Tambahkan konteks singkat yang berguna untuk tim pengajar.',
                children: [
                  TextFormField(
                    controller: _noteController,
                    decoration: _fieldDecoration(
                      label: 'Catatan',
                      icon: Icons.sticky_note_2_outlined,
                      helperText:
                          'Contoh: preferensi belajar, target, atau info penting lainnya.',
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
                    widget.isEdit ? 'Simpan perubahan' : 'Tambah siswa',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _fallbackPath =>
      widget.studentId == null ? '/students' : '/students/${widget.studentId}';

  void _handleBackNavigation(BuildContext context) {
    final router = GoRouter.of(context);
    if (router.canPop()) {
      router.pop();
      return;
    }
    context.go(_fallbackPath);
  }

  void _loadStudent(Student student) {
    if (_didLoadStudent) return;
    _didLoadStudent = true;
    _nameController.text = student.name;
    _parentNameController.text = student.parentName ?? '';
    _whatsappController.text = student.whatsapp ?? '';
    _addressController.text = student.address ?? '';
    _schoolController.text = student.school ?? '';
    _gradeController.text = student.grade ?? '';
    _defaultSubjectController.text = student.defaultSubject ?? '';
    _rateAmountController.text = _formatAmount(student.rateAmount.toString());
    _noteController.text = student.note ?? '';
    _rateType = student.rateType;
    _status = student.status;
    _defaultAcademicPeriodId = student.defaultAcademicPeriodId;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final amount = int.parse(_digitsOnly(_rateAmountController.text));
    final data = StudentFormData(
      name: _nameController.text,
      parentName: _parentNameController.text,
      whatsapp: _whatsappController.text,
      address: _addressController.text,
      school: _schoolController.text,
      grade: _gradeController.text,
      defaultSubject: _defaultSubjectController.text,
      defaultAcademicPeriodId: _defaultAcademicPeriodId,
      rateType: _rateType,
      rateAmount: amount,
      status: _status,
      note: _noteController.text,
    );

    if (widget.studentId == null) {
      final int newId;
      try {
        newId = await ref
            .read(studentFormNotifierProvider.notifier)
            .addStudent(data);
      } catch (_) {
        if (!mounted) return;
        _showSubmitResult(onSuccess: () {});
        return;
      }
      if (!mounted) return;
      _showSubmitResult(onSuccess: () => context.go('/students/$newId'));
      return;
    }

    await ref
        .read(studentFormNotifierProvider.notifier)
        .updateStudent(widget.studentId!, data);
    if (!mounted) return;
    _showSubmitResult(
      onSuccess: () => context.go('/students/${widget.studentId}'),
    );
  }

  void _showSubmitResult({required VoidCallback onSuccess}) {
    final state = ref.read(studentFormNotifierProvider);
    if (state.hasError) {
      AppToast.error(
        context,
        'Gagal menyimpan siswa',
        details: '${state.error}',
      );
      return;
    }
    onSuccess();
  }

  FormFieldValidator<String> _required(String message) {
    return (value) => value == null || value.trim().isEmpty ? message : null;
  }

  String? _validateWhatsapp(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return null;
    final digitsOnly = RegExp(r'^\d{8,15}$');
    return digitsOnly.hasMatch(trimmed)
        ? null
        : 'WhatsApp harus angka 8-15 digit jika diisi';
  }

  String? _validateRateAmount(String? value) {
    final amount = int.tryParse(_digitsOnly(value));
    if (amount == null || amount <= 0) {
      return 'Nominal tarif harus lebih dari 0';
    }
    return null;
  }

  String _digitsOnly(String? value) {
    return (value ?? '').replaceAll(RegExp(r'[^0-9]'), '');
  }

  String _formatAmount(String value) {
    final digits = _digitsOnly(value);
    if (digits.isEmpty) return '';
    return _currencyFormatter.format(int.parse(digits));
  }

  List<DropdownMenuItem<int?>> _academicPeriodItems(
    List<AcademicPeriod> periods,
  ) {
    final items = <DropdownMenuItem<int?>>[
      const DropdownMenuItem<int?>(value: null, child: Text('Belum diatur')),
      ...periods.map(
        (period) => DropdownMenuItem<int?>(
          value: period.id,
          child: Text(_academicPeriodLabel(period)),
        ),
      ),
    ];

    if (_defaultAcademicPeriodId != null &&
        periods.every((period) => period.id != _defaultAcademicPeriodId)) {
      items.add(
        DropdownMenuItem<int?>(
          value: _defaultAcademicPeriodId,
          child: const Text('Periode tersimpan tidak tersedia'),
        ),
      );
    }

    return items;
  }

  int? _selectedAcademicPeriodId(List<DropdownMenuItem<int?>> items) {
    return items.any((item) => item.value == _defaultAcademicPeriodId)
        ? _defaultAcademicPeriodId
        : null;
  }

  String _academicPeriodLabel(AcademicPeriod period) {
    final suffix = period.isActive ? ' (aktif)' : '';
    return '${period.name}$suffix';
  }
}

class _SelectionTile extends StatelessWidget {
  const _SelectionTile({
    required this.label,
    required this.icon,
    required this.selected,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: selected
          ? colorScheme.primaryContainer.withValues(alpha: .9)
          : colorScheme.surfaceContainerHighest.withValues(alpha: .42),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: selected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: selected
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection({
    required this.title,
    required this.icon,
    this.description,
    required this.children,
  });

  final String title;
  final IconData icon;
  final String? description;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: .5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: colorScheme.primary),
                const SizedBox(width: 8),
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
            if (description != null) ...[
              const SizedBox(height: 6),
              Text(
                description!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 14),
            Divider(color: colorScheme.outlineVariant.withValues(alpha: .6)),
            const SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }
}
