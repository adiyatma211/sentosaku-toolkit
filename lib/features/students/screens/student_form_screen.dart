import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/navigation/app_back_scope.dart';
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
            appBar: AppBar(title: const Text('Edit siswa')),
            body: Center(child: Text('Gagal memuat siswa: $error')),
          ),
        ),
      );
    }

    return _buildForm(context, submitState.isLoading);
  }

  Widget _buildForm(BuildContext context, bool isSubmitting) {
    return AppBackScope(
      fallbackPath: _fallbackPath,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isEdit ? 'Edit siswa' : 'Tambah siswa'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama siswa *'),
                textInputAction: TextInputAction.next,
                validator: _required('Nama siswa wajib diisi'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _parentNameController,
                decoration: const InputDecoration(
                  labelText: 'Nama orang tua/wali',
                ),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _whatsappController,
                decoration: const InputDecoration(labelText: 'WhatsApp'),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: _validateWhatsapp,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Alamat'),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _schoolController,
                decoration: const InputDecoration(labelText: 'Sekolah'),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _gradeController,
                decoration: const InputDecoration(labelText: 'Kelas'),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _defaultSubjectController,
                decoration: const InputDecoration(
                  labelText: 'Mata pelajaran utama *',
                ),
                textInputAction: TextInputAction.next,
                validator: _required('Mata pelajaran utama wajib diisi'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _rateType,
                decoration: const InputDecoration(labelText: 'Tipe tarif *'),
                items: const [
                  DropdownMenuItem(
                    value: RateType.perSession,
                    child: Text('Per sesi'),
                  ),
                  DropdownMenuItem(
                    value: RateType.monthly,
                    child: Text('Bulanan'),
                  ),
                  DropdownMenuItem(
                    value: RateType.package,
                    child: Text('Paket'),
                  ),
                ],
                onChanged: isSubmitting
                    ? null
                    : (value) => setState(
                        () => _rateType = value ?? RateType.perSession,
                      ),
                validator: (value) =>
                    value == null ? 'Tipe tarif wajib dipilih' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _rateAmountController,
                decoration: const InputDecoration(labelText: 'Nominal tarif *'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: _validateRateAmount,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(
                    value: StudentStatus.active,
                    child: Text('Aktif'),
                  ),
                  DropdownMenuItem(
                    value: StudentStatus.pending,
                    child: Text('Pending'),
                  ),
                  DropdownMenuItem(
                    value: StudentStatus.inactive,
                    child: Text('Nonaktif'),
                  ),
                ],
                onChanged: isSubmitting
                    ? null
                    : (value) => setState(
                        () => _status = value ?? StudentStatus.active,
                      ),
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
                  widget.isEdit ? 'Simpan perubahan' : 'Tambah siswa',
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan siswa: ${state.error}')),
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
}
