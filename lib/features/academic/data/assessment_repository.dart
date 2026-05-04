import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/logging/app_logger.dart';

class AssessmentReviewFormData {
  const AssessmentReviewFormData({
    required this.studentId,
    required this.academicPeriodId,
    required this.reviewCycleLabel,
    this.pemahamanMateri,
    this.keaktifanTanyaJawab,
    this.ketepatanKerapianTugas,
    this.konsistensiKehadiranFokus,
    this.targetMateriDrilling,
    this.sikapBelajarRespon,
    this.summaryNote,
  });

  final int studentId;
  final int academicPeriodId;
  final String reviewCycleLabel;
  final String? pemahamanMateri;
  final String? keaktifanTanyaJawab;
  final String? ketepatanKerapianTugas;
  final String? konsistensiKehadiranFokus;
  final String? targetMateriDrilling;
  final String? sikapBelajarRespon;
  final String? summaryNote;
}

class AssessmentReviewItem {
  const AssessmentReviewItem({this.assessment, this.session});

  final Assessment? assessment;
  final Session? session;
}

class AssessmentAspectDigest {
  const AssessmentAspectDigest({required this.fieldKey, required this.entries});

  final String fieldKey;
  final List<String> entries;

  int get count => entries.length;
  String? get latestEntry => entries.isEmpty ? null : entries.first;
}

class AssessmentPeriodSummary {
  const AssessmentPeriodSummary({
    required this.studentId,
    required this.academicPeriodId,
    required this.sessionAssessmentCount,
    required this.reviewCycleCount,
    required this.aspectDigests,
    required this.materialCoverage,
    required this.progressNotes,
    required this.obstacleNotes,
    required this.latestReviewCycle,
  });

  final int studentId;
  final int academicPeriodId;
  final int sessionAssessmentCount;
  final int reviewCycleCount;
  final List<AssessmentAspectDigest> aspectDigests;
  final List<String> materialCoverage;
  final List<String> progressNotes;
  final List<String> obstacleNotes;
  final Assessment? latestReviewCycle;

  int get sourceAssessmentCount => sessionAssessmentCount + reviewCycleCount;
}

class AssessmentRepository {
  const AssessmentRepository(this._database, this._logger);

  final AppDatabase _database;
  final AppLogger _logger;

  Stream<List<AssessmentReviewItem>> watchStudentAssessmentsForPeriod(
    int studentId,
    int academicPeriodId,
  ) {
    final query =
        (_database.select(_database.assessments).join([
            leftOuterJoin(
              _database.sessions,
              _database.sessions.id.equalsExp(_database.assessments.sessionId),
            ),
          ])
          ..where(_database.assessments.studentId.equals(studentId))
          ..where(
            _database.assessments.academicPeriodId.equals(academicPeriodId),
          )
          ..where(_database.assessments.deletedAt.isNull())
          ..orderBy([
            OrderingTerm.desc(_database.assessments.createdAt),
            OrderingTerm.desc(_database.sessions.sessionDate),
          ]));
    return query.watch().map(
      (rows) => rows
          .map(
            (row) => AssessmentReviewItem(
              assessment: row.readTable(_database.assessments),
              session: row.readTableOrNull(_database.sessions),
            ),
          )
          .toList(growable: false),
    );
  }

  Future<AssessmentPeriodSummary> getAssessmentSummary(
    int studentId,
    int academicPeriodId,
  ) async {
    final items = await watchStudentAssessmentsForPeriod(
      studentId,
      academicPeriodId,
    ).first;

    final sessionAssessments = <Assessment>[];
    final reviewCycles = <Assessment>[];
    final materialCoverage = <String>[];
    final progressNotes = <String>[];
    final obstacleNotes = <String>[];

    final digestBuckets = <String, List<String>>{
      'pemahamanMateri': <String>[],
      'keaktifanTanyaJawab': <String>[],
      'ketepatanKerapianTugas': <String>[],
      'konsistensiKehadiranFokus': <String>[],
      'targetMateriDrilling': <String>[],
      'sikapBelajarRespon': <String>[],
    };

    for (final item in items) {
      final assessment = item.assessment;
      if (assessment == null) continue;
      if (assessment.assessmentType == AssessmentType.reviewCycle) {
        reviewCycles.add(assessment);
      } else {
        sessionAssessments.add(assessment);
      }
      _pushValue(digestBuckets['pemahamanMateri']!, assessment.pemahamanMateri);
      _pushValue(
        digestBuckets['keaktifanTanyaJawab']!,
        assessment.keaktifanTanyaJawab,
      );
      _pushValue(
        digestBuckets['ketepatanKerapianTugas']!,
        assessment.ketepatanKerapianTugas,
      );
      _pushValue(
        digestBuckets['konsistensiKehadiranFokus']!,
        assessment.konsistensiKehadiranFokus,
      );
      _pushValue(
        digestBuckets['targetMateriDrilling']!,
        assessment.targetMateriDrilling,
      );
      _pushValue(
        digestBuckets['sikapBelajarRespon']!,
        assessment.sikapBelajarRespon,
      );
      _pushValue(obstacleNotes, assessment.summaryNote);
      _pushValue(materialCoverage, item.session?.material);
      _pushValue(progressNotes, item.session?.progressNote);
    }

    final aspectDigests = digestBuckets.entries
        .map(
          (entry) => AssessmentAspectDigest(
            fieldKey: entry.key,
            entries: List.unmodifiable(entry.value),
          ),
        )
        .toList(growable: false);

    return AssessmentPeriodSummary(
      studentId: studentId,
      academicPeriodId: academicPeriodId,
      sessionAssessmentCount: sessionAssessments.length,
      reviewCycleCount: reviewCycles.length,
      aspectDigests: aspectDigests,
      materialCoverage: List.unmodifiable(materialCoverage),
      progressNotes: List.unmodifiable(progressNotes),
      obstacleNotes: List.unmodifiable(obstacleNotes),
      latestReviewCycle: reviewCycles.isEmpty ? null : reviewCycles.first,
    );
  }

  Future<int> saveReviewCycle(AssessmentReviewFormData data) async {
    const action = 'academic.saveReviewCycle';
    final label = data.reviewCycleLabel.trim();
    final logData = {
      'studentId': data.studentId,
      'academicPeriodId': data.academicPeriodId,
      'reviewCycleLabel': label,
    };
    _logger.logTransactionStart(action, logData);
    try {
      if (label.isEmpty) {
        throw ArgumentError('Label review cycle wajib diisi');
      }
      final summary = await getAssessmentSummary(
        data.studentId,
        data.academicPeriodId,
      );
      if (summary.sessionAssessmentCount == 0) {
        throw StateError(
          'Review cycle memerlukan assessment sesi sebagai sumber.',
        );
      }

      final existing =
          await (_database.select(_database.assessments)
                ..where((row) => row.studentId.equals(data.studentId))
                ..where(
                  (row) => row.academicPeriodId.equals(data.academicPeriodId),
                )
                ..where(
                  (row) =>
                      row.assessmentType.equals(AssessmentType.reviewCycle),
                )
                ..where((row) => row.reviewCycleLabel.equals(label))
                ..where((row) => row.deletedAt.isNull()))
              .getSingleOrNull();

      final now = DateTime.now();
      if (existing != null) {
        await (_database.update(
          _database.assessments,
        )..where((row) => row.id.equals(existing.id))).write(
          AssessmentsCompanion(
            pemahamanMateri: Value(_blankToNull(data.pemahamanMateri)),
            keaktifanTanyaJawab: Value(_blankToNull(data.keaktifanTanyaJawab)),
            ketepatanKerapianTugas: Value(
              _blankToNull(data.ketepatanKerapianTugas),
            ),
            konsistensiKehadiranFokus: Value(
              _blankToNull(data.konsistensiKehadiranFokus),
            ),
            targetMateriDrilling: Value(
              _blankToNull(data.targetMateriDrilling),
            ),
            sikapBelajarRespon: Value(_blankToNull(data.sikapBelajarRespon)),
            summaryNote: Value(_blankToNull(data.summaryNote)),
            updatedAt: Value(now),
          ),
        );
        _logger.logTransactionSuccess(action, {
          ...logData,
          'assessmentId': existing.id,
        });
        return existing.id;
      }

      final id = await _database
          .into(_database.assessments)
          .insert(
            AssessmentsCompanion.insert(
              studentId: data.studentId,
              academicPeriodId: Value(data.academicPeriodId),
              assessmentType: const Value(AssessmentType.reviewCycle),
              reviewCycleLabel: Value(label),
              pemahamanMateri: Value(_blankToNull(data.pemahamanMateri)),
              keaktifanTanyaJawab: Value(
                _blankToNull(data.keaktifanTanyaJawab),
              ),
              ketepatanKerapianTugas: Value(
                _blankToNull(data.ketepatanKerapianTugas),
              ),
              konsistensiKehadiranFokus: Value(
                _blankToNull(data.konsistensiKehadiranFokus),
              ),
              targetMateriDrilling: Value(
                _blankToNull(data.targetMateriDrilling),
              ),
              sikapBelajarRespon: Value(_blankToNull(data.sikapBelajarRespon)),
              summaryNote: Value(_blankToNull(data.summaryNote)),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      _logger.logTransactionSuccess(action, {...logData, 'assessmentId': id});
      return id;
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  void _pushValue(List<String> values, String? value) {
    final trimmed = _blankToNull(value);
    if (trimmed == null || values.contains(trimmed)) {
      return;
    }
    values.add(trimmed);
  }

  String? _blankToNull(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
