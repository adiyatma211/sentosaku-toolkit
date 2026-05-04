import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/feedback/app_toast.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../data/academic_period_repository.dart';
import '../providers/academic_period_provider.dart';

class AcademicPeriodFormScreen extends ConsumerStatefulWidget {
  const AcademicPeriodFormScreen({super.key, this.periodId});

  final int? periodId;

  bool get isEdit => periodId != null;

  @override
  ConsumerState<AcademicPeriodFormScreen> createState() =>
      _AcademicPeriodFormScreenState();
}

class _AcademicPeriodFormScreenState
    extends ConsumerState<AcademicPeriodFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 180));
  String _periodType = AcademicPeriodType.semester;
  bool _isActive = false;
  bool _loaded = false;

  @override
  void dispose() {
    _nameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submitState = ref.watch(academicPeriodFormNotifierProvider);
    final detailState = widget.periodId == null
        ? null
        : ref.watch(academicPeriodDetailProvider(widget.periodId!));

    if (detailState != null) {
      return detailState.when(
        data: (period) {
          if (period == null) {
            return const Scaffold(
              body: Center(child: Text('Periode tidak ditemukan.')),
            );
          }
          _load(period);
          return _buildScaffold(context, submitState.isLoading);
        },
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stackTrace) => Scaffold(
          appBar: AppBar(title: const Text('Periode akademik')),
          body: Center(child: Text('Gagal memuat periode: $error')),
        ),
      );
    }
    return _buildScaffold(context, submitState.isLoading);
  }

  Widget _buildScaffold(BuildContext context, bool isSubmitting) {
    final dateFormat = DateFormat('d MMM yyyy');
    return AppBackScope(
      fallbackPath: '/academic-periods',
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isEdit ? 'Edit periode akademik' : 'Tambah periode akademik',
          ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama periode *'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Nama wajib diisi'
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _periodType,
                decoration: const InputDecoration(labelText: 'Tipe periode'),
                items: const [
                  DropdownMenuItem(
                    value: AcademicPeriodType.semester,
                    child: Text('Semester'),
                  ),
                  DropdownMenuItem(
                    value: AcademicPeriodType.custom,
                    child: Text('Custom'),
                  ),
                ],
                onChanged: isSubmitting
                    ? null
                    : (value) => setState(
                        () =>
                            _periodType = value ?? AcademicPeriodType.semester,
                      ),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_month_outlined),
                title: const Text('Tanggal mulai'),
                subtitle: Text(dateFormat.format(_startDate)),
                onTap: isSubmitting ? null : () => _pickDate(isStart: true),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.event_available_outlined),
                title: const Text('Tanggal selesai'),
                subtitle: Text(dateFormat.format(_endDate)),
                onTap: isSubmitting ? null : () => _pickDate(isStart: false),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Tandai sebagai periode aktif'),
                value: _isActive,
                onChanged: isSubmitting
                    ? null
                    : (value) => setState(() => _isActive = value),
              ),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: 'Catatan'),
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: isSubmitting ? null : _submit,
                icon: const Icon(Icons.save_outlined),
                label: Text(
                  widget.isEdit ? 'Simpan perubahan' : 'Tambah periode',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _load(period) {
    if (_loaded) return;
    _loaded = true;
    _nameController.text = period.name;
    _noteController.text = period.note ?? '';
    _startDate = period.startDate;
    _endDate = period.endDate;
    _periodType = period.periodType;
    _isActive = period.isActive;
  }

  Future<void> _pickDate({required bool isStart}) async {
    final initialDate = isStart ? _startDate : _endDate;
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _startDate = picked;
      } else {
        _endDate = picked;
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final data = AcademicPeriodFormData(
      name: _nameController.text,
      periodType: _periodType,
      startDate: _startDate,
      endDate: _endDate,
      isActive: _isActive,
      note: _noteController.text,
    );
    try {
      if (widget.periodId == null) {
        await ref
            .read(academicPeriodFormNotifierProvider.notifier)
            .addPeriod(data);
      } else {
        await ref
            .read(academicPeriodFormNotifierProvider.notifier)
            .updatePeriod(widget.periodId!, data);
      }
      if (!mounted) return;
      context.go('/academic-periods');
    } catch (error) {
      if (!mounted) return;
      AppToast.error(context, 'Gagal menyimpan periode', details: '$error');
    }
  }
}
