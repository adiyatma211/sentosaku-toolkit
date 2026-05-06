import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/feedback/app_toast.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../../schedules/data/schedule_repository.dart';
import '../../schedules/providers/schedule_provider.dart';
import '../data/session_repository.dart';
import '../providers/session_provider.dart';

class SessionFormScreen extends ConsumerStatefulWidget {
  const SessionFormScreen({super.key, required this.scheduleId});

  final int scheduleId;

  @override
  ConsumerState<SessionFormScreen> createState() => _SessionFormScreenState();
}

class _SessionFormScreenState extends ConsumerState<SessionFormScreen> {
  final _currencyFormatter = NumberFormat.decimalPattern('id_ID');
  final _formKey = GlobalKey<FormState>();
  final _materialController = TextEditingController();
  final _homeworkController = TextEditingController();
  final _progressNoteController = TextEditingController();
  final _feeAmountController = TextEditingController();
  final _pemahamanMateriController = TextEditingController();
  final _keaktifanTanyaJawabController = TextEditingController();
  final _ketepatanKerapianTugasController = TextEditingController();
  final _konsistensiKehadiranFokusController = TextEditingController();
  final _targetMateriDrillingController = TextEditingController();
  final _sikapBelajarResponController = TextEditingController();
  final _assessmentSummaryController = TextEditingController();

  String _attendanceStatus = AttendanceStatus.present;
  bool _initialized = false;

  @override
  void dispose() {
    _materialController.dispose();
    _homeworkController.dispose();
    _progressNoteController.dispose();
    _feeAmountController.dispose();
    _pemahamanMateriController.dispose();
    _keaktifanTanyaJawabController.dispose();
    _ketepatanKerapianTugasController.dispose();
    _konsistensiKehadiranFokusController.dispose();
    _targetMateriDrillingController.dispose();
    _sikapBelajarResponController.dispose();
    _assessmentSummaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleState = ref.watch(scheduleDetailProvider(widget.scheduleId));
    final submitState = ref.watch(sessionFormNotifierProvider);

    return AppBackScope(
      fallbackPath: '/schedules/${widget.scheduleId}',
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => _handleBackNavigation(context),
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('Buat sesi'),
        ),
        body: scheduleState.when(
          data: (detail) {
            if (detail == null) {
              return const Center(child: Text('Jadwal tidak ditemukan.'));
            }
            _initialize(detail);

            return _SessionFormContent(
              formKey: _formKey,
              detail: detail,
              attendanceStatus: _attendanceStatus,
              materialController: _materialController,
              homeworkController: _homeworkController,
              progressNoteController: _progressNoteController,
              feeAmountController: _feeAmountController,
              pemahamanMateriController: _pemahamanMateriController,
              keaktifanTanyaJawabController: _keaktifanTanyaJawabController,
              ketepatanKerapianTugasController:
                  _ketepatanKerapianTugasController,
              konsistensiKehadiranFokusController:
                  _konsistensiKehadiranFokusController,
              targetMateriDrillingController: _targetMateriDrillingController,
              sikapBelajarResponController: _sikapBelajarResponController,
              assessmentSummaryController: _assessmentSummaryController,
              isSubmitting: submitState.isLoading,
              onAttendanceChanged: (value) {
                if (value == null) return;
                setState(() => _attendanceStatus = value);
              },
              onSubmit: () => _submit(detail),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Gagal memuat jadwal: $error'),
            ),
          ),
        ),
      ),
    );
  }

  void _initialize(ScheduleDetail detail) {
    if (_initialized) return;
    _feeAmountController.text = _formatAmount(detail.student.rateAmount);
    _initialized = true;
  }

  Future<void> _submit(ScheduleDetail detail) async {
    if (!_formKey.currentState!.validate()) return;

    final feeAmount = int.parse(_digitsOnly(_feeAmountController.text));
    try {
      final sessionId = await ref
          .read(sessionFormNotifierProvider.notifier)
          .createSessionFromSchedule(
            SessionFormData(
              scheduleId: detail.schedule.id,
              attendanceStatus: _attendanceStatus,
              material: _materialController.text,
              homework: _homeworkController.text,
              progressNote: _progressNoteController.text,
              feeAmount: feeAmount,
              assessment: SessionAssessmentFormData(
                pemahamanMateri: _pemahamanMateriController.text,
                keaktifanTanyaJawab: _keaktifanTanyaJawabController.text,
                ketepatanKerapianTugas: _ketepatanKerapianTugasController.text,
                konsistensiKehadiranFokus:
                    _konsistensiKehadiranFokusController.text,
                targetMateriDrilling: _targetMateriDrillingController.text,
                sikapBelajarRespon: _sikapBelajarResponController.text,
                summaryNote: _assessmentSummaryController.text,
              ),
            ),
          );
      if (!mounted) return;
      context.go('/sessions/$sessionId');
    } catch (error) {
      if (!mounted) return;
      AppToast.error(context, 'Gagal menyimpan sesi', details: '$error');
    }
  }

  void _handleBackNavigation(BuildContext context) {
    final router = GoRouter.of(context);
    if (router.canPop()) {
      router.pop();
      return;
    }
    context.go('/schedules/${widget.scheduleId}');
  }

  String _digitsOnly(String? value) {
    return (value ?? '').replaceAll(RegExp(r'[^0-9]'), '');
  }

  String _formatAmount(int value) {
    return _currencyFormatter.format(value);
  }
}

class _SessionFormContent extends StatelessWidget {
  const _SessionFormContent({
    required this.formKey,
    required this.detail,
    required this.attendanceStatus,
    required this.materialController,
    required this.homeworkController,
    required this.progressNoteController,
    required this.feeAmountController,
    required this.pemahamanMateriController,
    required this.keaktifanTanyaJawabController,
    required this.ketepatanKerapianTugasController,
    required this.konsistensiKehadiranFokusController,
    required this.targetMateriDrillingController,
    required this.sikapBelajarResponController,
    required this.assessmentSummaryController,
    required this.isSubmitting,
    required this.onAttendanceChanged,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final ScheduleDetail detail;
  final String attendanceStatus;
  final TextEditingController materialController;
  final TextEditingController homeworkController;
  final TextEditingController progressNoteController;
  final TextEditingController feeAmountController;
  final TextEditingController pemahamanMateriController;
  final TextEditingController keaktifanTanyaJawabController;
  final TextEditingController ketepatanKerapianTugasController;
  final TextEditingController konsistensiKehadiranFokusController;
  final TextEditingController targetMateriDrillingController;
  final TextEditingController sikapBelajarResponController;
  final TextEditingController assessmentSummaryController;
  final bool isSubmitting;
  final ValueChanged<String?> onAttendanceChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMMM yyyy');
    final timeFormat = DateFormat.Hm();
    final schedule = detail.schedule;
    final canAutoInvoice =
        attendanceStatus == AttendanceStatus.present &&
        detail.student.rateType == RateType.perSession;

    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detail.student.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  _InfoRow(label: 'Mata pelajaran', value: detail.subject.name),
                  _InfoRow(
                    label: 'Tanggal',
                    value: dateFormat.format(schedule.date),
                  ),
                  _InfoRow(
                    label: 'Waktu',
                    value:
                        '${timeFormat.format(schedule.startTime)} - ${timeFormat.format(schedule.endTime)}',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: attendanceStatus,
            decoration: const InputDecoration(
              labelText: 'Status absensi',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: AttendanceStatus.present,
                child: Text('Hadir'),
              ),
              DropdownMenuItem(
                value: AttendanceStatus.permission,
                child: Text('Izin'),
              ),
              DropdownMenuItem(
                value: AttendanceStatus.absent,
                child: Text('Absen'),
              ),
              DropdownMenuItem(
                value: AttendanceStatus.cancelled,
                child: Text('Batal'),
              ),
              DropdownMenuItem(
                value: AttendanceStatus.rescheduled,
                child: Text('Reschedule'),
              ),
            ],
            onChanged: isSubmitting ? null : onAttendanceChanged,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: materialController,
            decoration: const InputDecoration(
              labelText: 'Materi',
              border: OutlineInputBorder(),
            ),
            minLines: 2,
            maxLines: 4,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: homeworkController,
            decoration: const InputDecoration(
              labelText: 'PR / tugas',
              border: OutlineInputBorder(),
            ),
            minLines: 2,
            maxLines: 4,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: progressNoteController,
            decoration: const InputDecoration(
              labelText: 'Catatan perkembangan',
              border: OutlineInputBorder(),
            ),
            minLines: 2,
            maxLines: 5,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: feeAmountController,
            decoration: const InputDecoration(
              labelText: 'Biaya sesi',
              prefixText: 'Rp ',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              TextInputFormatter.withFunction((oldValue, newValue) {
                final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
                if (digits.isEmpty) {
                  return const TextEditingValue();
                }

                final formatted = NumberFormat.decimalPattern(
                  'id_ID',
                ).format(int.parse(digits));
                return TextEditingValue(
                  text: formatted,
                  selection: TextSelection.collapsed(
                    offset: formatted.length,
                  ),
                );
              }),
            ],
            validator: (value) {
              final amount = int.tryParse(
                (value ?? '').replaceAll(RegExp(r'[^0-9]'), ''),
              );
              if (amount == null) return 'Biaya wajib diisi';
              if (amount < 0) return 'Biaya tidak valid';
              return null;
            },
          ),
          const SizedBox(height: 8),
          Text(
            canAutoInvoice
                ? 'Invoice belum dibayar akan dibuat otomatis jika biaya lebih dari 0.'
                : 'Invoice otomatis hanya dibuat untuk sesi hadir dengan tarif per sesi.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          Text(
            'Assessment terstruktur',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Isi aspek yang relevan untuk merekam evaluasi sesi dan progres belajar.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          _AssessmentField(
            controller: pemahamanMateriController,
            label: 'Pemahaman materi',
          ),
          const SizedBox(height: 12),
          _AssessmentField(
            controller: keaktifanTanyaJawabController,
            label: 'Keaktifan tanya jawab',
          ),
          const SizedBox(height: 12),
          _AssessmentField(
            controller: ketepatanKerapianTugasController,
            label: 'Ketepatan dan kerapian tugas',
          ),
          const SizedBox(height: 12),
          _AssessmentField(
            controller: konsistensiKehadiranFokusController,
            label: 'Konsistensi kehadiran dan fokus',
          ),
          const SizedBox(height: 12),
          _AssessmentField(
            controller: targetMateriDrillingController,
            label: 'Target materi / drilling berikutnya',
          ),
          const SizedBox(height: 12),
          _AssessmentField(
            controller: sikapBelajarResponController,
            label: 'Sikap belajar dan respon',
          ),
          const SizedBox(height: 12),
          _AssessmentField(
            controller: assessmentSummaryController,
            label: 'Ringkasan assessment',
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: isSubmitting ? null : onSubmit,
            icon: isSubmitting
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save_outlined),
            label: const Text('Simpan sesi'),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          Expanded(child: Text(value == null || value!.isEmpty ? '-' : value!)),
        ],
      ),
    );
  }
}

class _AssessmentField extends StatelessWidget {
  const _AssessmentField({
    required this.controller,
    required this.label,
    this.maxLines = 4,
  });

  final TextEditingController controller;
  final String label;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      minLines: 2,
      maxLines: maxLines,
    );
  }
}
