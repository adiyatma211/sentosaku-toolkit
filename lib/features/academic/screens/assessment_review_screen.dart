import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/feedback/app_toast.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../../students/providers/student_provider.dart';
import '../data/assessment_repository.dart';
import '../providers/academic_period_provider.dart';
import '../providers/assessment_provider.dart';
import '../widgets/assessment_summary_card.dart';

class AssessmentReviewScreen extends ConsumerStatefulWidget {
  const AssessmentReviewScreen({
    super.key,
    required this.studentId,
    this.initialAcademicPeriodId,
  });

  final int studentId;
  final int? initialAcademicPeriodId;

  @override
  ConsumerState<AssessmentReviewScreen> createState() =>
      _AssessmentReviewScreenState();
}

class _AssessmentReviewScreenState
    extends ConsumerState<AssessmentReviewScreen> {
  final _labelController = TextEditingController();
  final _summaryController = TextEditingController();
  final _pemahamanController = TextEditingController();
  final _keaktifanController = TextEditingController();
  final _tugasController = TextEditingController();
  final _konsistensiController = TextEditingController();
  final _targetController = TextEditingController();
  final _sikapController = TextEditingController();
  int? _periodId;

  @override
  void initState() {
    super.initState();
    _periodId = widget.initialAcademicPeriodId;
  }

  @override
  void dispose() {
    _labelController.dispose();
    _summaryController.dispose();
    _pemahamanController.dispose();
    _keaktifanController.dispose();
    _tugasController.dispose();
    _konsistensiController.dispose();
    _targetController.dispose();
    _sikapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentDetailProvider(widget.studentId));
    final assignmentsState = ref.watch(
      studentPeriodAssignmentsProvider(widget.studentId),
    );
    final key = _periodId == null
        ? null
        : StudentPeriodKey(
            studentId: widget.studentId,
            academicPeriodId: _periodId!,
          );
    final summaryState = key == null
        ? null
        : ref.watch(assessmentSummaryProvider(key));
    final itemsState = key == null
        ? null
        : ref.watch(assessmentReviewItemsProvider(key));
    final submitState = ref.watch(assessmentReviewNotifierProvider);

    return AppBackScope(
      fallbackPath: '/students/${widget.studentId}',
      child: Scaffold(
        appBar: AppBar(title: const Text('Assessment review')),
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
                const SizedBox(height: 12),
                assignmentsState.when(
                  data: (items) {
                    if (_periodId == null && items.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted && _periodId == null) {
                          setState(
                            () => _periodId = items.first.academicPeriod.id,
                          );
                        }
                      });
                    }
                    return DropdownButtonFormField<int>(
                      value:
                          items.any(
                            (item) => item.academicPeriod.id == _periodId,
                          )
                          ? _periodId
                          : null,
                      decoration: const InputDecoration(
                        labelText: 'Periode akademik',
                      ),
                      items: items
                          .map(
                            (item) => DropdownMenuItem(
                              value: item.academicPeriod.id,
                              child: Text(item.academicPeriod.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() => _periodId = value),
                    );
                  },
                  loading: () => const LinearProgressIndicator(),
                  error: (error, stackTrace) =>
                      Text('Gagal memuat periode: $error'),
                ),
                const SizedBox(height: 16),
                if (summaryState != null)
                  summaryState.when(
                    data: (summary) => AssessmentSummaryCard(summary: summary),
                    loading: () => const LinearProgressIndicator(),
                    error: (error, stackTrace) => Text('$error'),
                  ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _labelController,
                  decoration: const InputDecoration(
                    labelText: 'Label review cycle *',
                    hintText: 'Contoh: Review Bulanan Mei',
                  ),
                ),
                const SizedBox(height: 12),
                _field(_pemahamanController, 'Pemahaman materi'),
                const SizedBox(height: 12),
                _field(_keaktifanController, 'Keaktifan tanya jawab'),
                const SizedBox(height: 12),
                _field(_tugasController, 'Ketepatan dan kerapian tugas'),
                const SizedBox(height: 12),
                _field(
                  _konsistensiController,
                  'Konsistensi kehadiran dan fokus',
                ),
                const SizedBox(height: 12),
                _field(_targetController, 'Target materi / drilling'),
                const SizedBox(height: 12),
                _field(_sikapController, 'Sikap belajar dan respon'),
                const SizedBox(height: 12),
                _field(_summaryController, 'Ringkasan review', maxLines: 5),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: submitState.isLoading ? null : _submit,
                  icon: const Icon(Icons.fact_check_outlined),
                  label: const Text('Simpan review cycle'),
                ),
                const SizedBox(height: 24),
                if (itemsState != null)
                  itemsState.when(
                    data: (items) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Riwayat assessment',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 12),
                        for (final item in items)
                          if (item.assessment != null)
                            Card(
                              child: ListTile(
                                title: Text(
                                  item.assessment!.reviewCycleLabel ??
                                      'Assessment sesi',
                                ),
                                subtitle: Text(
                                  item.assessment!.summaryNote ?? '-',
                                ),
                              ),
                            ),
                      ],
                    ),
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stackTrace) => Text('$error'),
                  ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('$error')),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    int maxLines = 3,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      minLines: maxLines == 3 ? 2 : maxLines,
      maxLines: maxLines,
    );
  }

  Future<void> _submit() async {
    if (_periodId == null) {
      AppToast.warning(context, 'Periode akademik wajib dipilih');
      return;
    }
    try {
      await ref
          .read(assessmentReviewNotifierProvider.notifier)
          .saveReviewCycle(
            AssessmentReviewFormData(
              studentId: widget.studentId,
              academicPeriodId: _periodId!,
              reviewCycleLabel: _labelController.text,
              pemahamanMateri: _pemahamanController.text,
              keaktifanTanyaJawab: _keaktifanController.text,
              ketepatanKerapianTugas: _tugasController.text,
              konsistensiKehadiranFokus: _konsistensiController.text,
              targetMateriDrilling: _targetController.text,
              sikapBelajarRespon: _sikapController.text,
              summaryNote: _summaryController.text,
            ),
          );
      if (!mounted) return;
      AppToast.success(context, 'Review cycle tersimpan');
    } catch (error) {
      if (!mounted) return;
      AppToast.error(
        context,
        'Gagal menyimpan review cycle',
        details: '$error',
      );
    }
  }
}
