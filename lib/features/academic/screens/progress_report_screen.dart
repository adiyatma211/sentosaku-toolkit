import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/feedback/app_toast.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../../students/providers/student_provider.dart';
import '../providers/academic_period_provider.dart';
import '../providers/assessment_provider.dart';
import '../providers/progress_report_provider.dart';
import '../widgets/assessment_summary_card.dart';
import '../widgets/attendance_recap_card.dart';
import '../widgets/progress_report_status_chip.dart';

class ProgressReportScreen extends ConsumerStatefulWidget {
  const ProgressReportScreen({
    super.key,
    required this.studentId,
    this.initialAcademicPeriodId,
  });

  final int studentId;
  final int? initialAcademicPeriodId;

  @override
  ConsumerState<ProgressReportScreen> createState() =>
      _ProgressReportScreenState();
}

class _ProgressReportScreenState extends ConsumerState<ProgressReportScreen> {
  final _teacherNoteController = TextEditingController();
  int? _periodId;
  String _status = ProgressReportStatus.draft;
  int? _loadedReportId;

  @override
  void initState() {
    super.initState();
    _periodId = widget.initialAcademicPeriodId;
  }

  @override
  void dispose() {
    _teacherNoteController.dispose();
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
    final reportState = key == null
        ? null
        : ref.watch(studentPeriodProgressReportProvider(key));
    final summaryState = key == null
        ? null
        : ref.watch(assessmentSummaryProvider(key));
    final submitState = ref.watch(progressReportNotifierProvider);

    return AppBackScope(
      fallbackPath: '/students/${widget.studentId}',
      child: Scaffold(
        appBar: AppBar(title: const Text('Progress report')),
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
                  error: (error, stackTrace) => Text('$error'),
                ),
                const SizedBox(height: 16),
                if (summaryState != null)
                  summaryState.when(
                    data: (summary) => AssessmentSummaryCard(summary: summary),
                    loading: () => const LinearProgressIndicator(),
                    error: (error, stackTrace) => Text('$error'),
                  ),
                const SizedBox(height: 16),
                if (reportState != null)
                  reportState.when(
                    data: (report) {
                      if (report != null && _loadedReportId != report.id) {
                        _loadedReportId = report.id;
                        _teacherNoteController.text = report.teacherNote ?? '';
                        _status = report.status;
                      }
                      final snapshot = ref.watch(
                        progressReportSnapshotProvider(report),
                      );
                      if (report == null || snapshot == null) {
                        return const Card(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Belum ada snapshot progress report untuk periode ini.',
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ProgressReportStatusChip(
                              status: report.status,
                            ),
                          ),
                          const SizedBox(height: 12),
                          AttendanceRecapCard(
                            summary: snapshot.attendanceSummary,
                          ),
                          const SizedBox(height: 12),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Snapshot assessment',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${snapshot.assessmentSummary['materialsCovered'] ?? const []}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stackTrace) => Text('$error'),
                  ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _status,
                  decoration: const InputDecoration(
                    labelText: 'Status laporan',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: ProgressReportStatus.draft,
                      child: Text('Draft'),
                    ),
                    DropdownMenuItem(
                      value: ProgressReportStatus.finalized,
                      child: Text('Finalized'),
                    ),
                    DropdownMenuItem(
                      value: ProgressReportStatus.exported,
                      child: Text('Exported'),
                    ),
                  ],
                  onChanged: (value) => setState(
                    () => _status = value ?? ProgressReportStatus.draft,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _teacherNoteController,
                  decoration: const InputDecoration(
                    labelText: 'Catatan akhir guru',
                  ),
                  maxLines: 6,
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: submitState.isLoading ? null : _generate,
                  icon: const Icon(Icons.summarize_outlined),
                  label: const Text('Generate snapshot'),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: submitState.isLoading ? null : _saveNote,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Simpan catatan akhir'),
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

  Future<void> _generate() async {
    if (_periodId == null) {
      AppToast.warning(context, 'Periode akademik wajib dipilih');
      return;
    }
    try {
      await ref
          .read(progressReportNotifierProvider.notifier)
          .generate(
            widget.studentId,
            _periodId!,
            teacherNote: _teacherNoteController.text,
            status: _status,
          );
      if (!mounted) return;
      AppToast.success(context, 'Progress report berhasil digenerate');
    } catch (error) {
      if (!mounted) return;
      AppToast.error(
        context,
        'Gagal generate progress report',
        details: '$error',
      );
    }
  }

  Future<void> _saveNote() async {
    if (_periodId == null) {
      AppToast.warning(context, 'Periode akademik wajib dipilih');
      return;
    }
    final key = StudentPeriodKey(
      studentId: widget.studentId,
      academicPeriodId: _periodId!,
    );
    final report = await ref.read(
      studentPeriodProgressReportProvider(key).future,
    );
    if (!mounted) return;
    if (report == null) {
      AppToast.warning(context, 'Generate snapshot terlebih dahulu');
      return;
    }
    try {
      await ref
          .read(progressReportNotifierProvider.notifier)
          .updateTeacherNote(
            report.id,
            _teacherNoteController.text,
            status: _status,
          );
      if (!mounted) return;
      AppToast.success(context, 'Catatan akhir tersimpan');
    } catch (error) {
      if (!mounted) return;
      AppToast.error(context, 'Gagal menyimpan catatan', details: '$error');
    }
  }
}
