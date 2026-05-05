import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
        borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: .7)),
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
              _FormIntroCard(isEdit: widget.isEdit),
              const SizedBox(height: 16),
              _FormSection(
                title: 'Data Murid',
                icon: Icons.school_outlined,
                description:
                    'Informasi utama yang dipakai di profil dan jadwal.',
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: _fieldDecoration(
                      label: 'Nama siswa *',
                      icon: Icons.person_outline,
                    ),
                    textInputAction: TextInputAction.next,
                    validator: _required('Nama siswa wajib diisi'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _schoolController,
                    decoration: _fieldDecoration(
                      label: 'Sekolah',
                      icon: Icons.apartment_outlined,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _gradeController,
                    decoration: _fieldDecoration(
                      label: 'Kelas',
                      icon: Icons.badge_outlined,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
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
                      initialValue: selectedAcademicPeriodId,
                      decoration: _fieldDecoration(
                        label: 'Periode akademik default',
                        icon: Icons.calendar_month_outlined,
                        helperText:
                            'Opsional. Jadwal Sprint 03 akan membaca default ini bila tersedia.',
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
                title: 'Kontak & Lokasi',
                icon: Icons.contact_phone_outlined,
                description:
                    'Memudahkan follow up orang tua dan kebutuhan kunjungan.',
                children: [
                  TextFormField(
                    controller: _parentNameController,
                    decoration: _fieldDecoration(
                      label: 'Nama orang tua/wali',
                      icon: Icons.family_restroom_outlined,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _whatsappController,
                    decoration: _fieldDecoration(
                      label: 'WhatsApp',
                      icon: Icons.chat_outlined,
                      helperText: 'Isi angka saja, mis. 081234567890.',
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
                      helperText:
                          'Opsional. Berguna untuk les privat atau penjemputan.',
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
                    textInputAction: TextInputAction.next,
                    validator: _validateRateAmount,
                  ),
                  const SizedBox(height: 12),
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
    _rateAmountController.text = student.rateAmount.toString();
    _noteController.text = student.note ?? '';
    _rateType = student.rateType;
    _status = student.status;
    _defaultAcademicPeriodId = student.defaultAcademicPeriodId;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final amount = int.parse(_rateAmountController.text.trim());
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
    final amount = int.tryParse(value?.trim() ?? '');
    if (amount == null || amount <= 0) {
      return 'Nominal tarif harus lebih dari 0';
    }
    return null;
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
                Icons.person_add_alt_1_outlined,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profil Siswa',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isEdit
                        ? 'Perbarui data murid, kontak, tarif, dan status dengan rapi.'
                        : 'Lengkapi profil murid agar jadwal dan pembayaran lebih mudah dicatat.',
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
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: .5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: .14),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: colorScheme.primary),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: colorScheme.onPrimaryContainer,
                              ),
                        ),
                        if (description != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            description!,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: colorScheme.onPrimaryContainer
                                      .withValues(alpha: .78),
                                ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }
}
