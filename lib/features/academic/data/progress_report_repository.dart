import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/logging/app_logger.dart';
import '../../sessions/data/session_repository.dart';
import 'assessment_repository.dart';

class ProgressReportSnapshot {
  const ProgressReportSnapshot({
    required this.report,
    required this.attendanceSummary,
    required this.assessmentSummary,
  });

  final ProgressReport report;
  final Map<String, dynamic> attendanceSummary;
  final Map<String, dynamic> assessmentSummary;
}

class ProgressReportRepository {
  const ProgressReportRepository(
    this._database,
    this._logger,
    this._assessmentRepository,
  );

  final AppDatabase _database;
  final AppLogger _logger;
  final AssessmentRepository _assessmentRepository;

  Stream<List<ProgressReport>> watchStudentReports(int studentId) {
    final query = _database.select(_database.progressReports)
      ..where((row) => row.studentId.equals(studentId))
      ..where((row) => row.deletedAt.isNull())
      ..orderBy([(row) => OrderingTerm.desc(row.generatedAt)]);
    return query.watch();
  }

  Stream<ProgressReport?> watchStudentPeriodReport(
    int studentId,
    int periodId,
  ) {
    final query = _database.select(_database.progressReports)
      ..where((row) => row.studentId.equals(studentId))
      ..where((row) => row.academicPeriodId.equals(periodId))
      ..where((row) => row.deletedAt.isNull())
      ..orderBy([(row) => OrderingTerm.desc(row.generatedAt)]);
    return query.watchSingleOrNull();
  }

  Future<ProgressReportSnapshot> generateProgressReport(
    int studentId,
    int academicPeriodId, {
    String? teacherNote,
    String status = ProgressReportStatus.draft,
  }) async {
    const action = 'academic.generateProgressReport';
    final logData = {
      'studentId': studentId,
      'academicPeriodId': academicPeriodId,
    };
    _logger.logTransactionStart(action, logData);
    try {
      final period =
          await (_database.select(_database.academicPeriods)
                ..where((row) => row.id.equals(academicPeriodId))
                ..where((row) => row.deletedAt.isNull()))
              .getSingleOrNull();
      if (period == null) {
        throw StateError('Periode akademik tidak ditemukan.');
      }

      final attendanceSummary = await _buildAttendanceSummary(
        studentId,
        academicPeriodId,
        period,
      );
      final assessmentSummaryModel = await _assessmentRepository
          .getAssessmentSummary(studentId, academicPeriodId);
      if (assessmentSummaryModel.sourceAssessmentCount == 0 &&
          status == ProgressReportStatus.finalized) {
        throw StateError(
          'Progress report final memerlukan assessment sumber yang jelas.',
        );
      }

      final assessmentSummary = _buildAssessmentSummaryJson(
        assessmentSummaryModel,
      );
      final note = _blankToNull(teacherNote);
      final now = DateTime.now();
      final existing =
          await (_database.select(_database.progressReports)
                ..where((row) => row.studentId.equals(studentId))
                ..where((row) => row.academicPeriodId.equals(academicPeriodId))
                ..where((row) => row.deletedAt.isNull()))
              .getSingleOrNull();

      final reportId = await _database.transaction(() async {
        if (existing != null) {
          await (_database.update(
            _database.progressReports,
          )..where((row) => row.id.equals(existing.id))).write(
            ProgressReportsCompanion(
              generatedAt: Value(now),
              attendanceSummaryJson: Value(jsonEncode(attendanceSummary)),
              assessmentSummaryJson: Value(jsonEncode(assessmentSummary)),
              teacherNote: Value(note ?? existing.teacherNote),
              status: Value(status),
              updatedAt: Value(now),
            ),
          );
          return existing.id;
        }

        return _database
            .into(_database.progressReports)
            .insert(
              ProgressReportsCompanion.insert(
                studentId: studentId,
                academicPeriodId: academicPeriodId,
                reportType: const Value(ProgressReportType.periodic),
                generatedAt: Value(now),
                attendanceSummaryJson: Value(jsonEncode(attendanceSummary)),
                assessmentSummaryJson: Value(jsonEncode(assessmentSummary)),
                teacherNote: Value(note),
                status: Value(status),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
      });

      final report = await (_database.select(
        _database.progressReports,
      )..where((row) => row.id.equals(reportId))).getSingle();
      final snapshot = ProgressReportSnapshot(
        report: report,
        attendanceSummary: attendanceSummary,
        assessmentSummary: assessmentSummary,
      );
      _logger.logTransactionSuccess(action, {...logData, 'reportId': reportId});
      return snapshot;
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Future<void> updateTeacherNote(
    int reportId,
    String? teacherNote, {
    String? status,
  }) async {
    await (_database.update(_database.progressReports)
          ..where((row) => row.id.equals(reportId))
          ..where((row) => row.deletedAt.isNull()))
        .write(
          ProgressReportsCompanion(
            teacherNote: Value(_blankToNull(teacherNote)),
            status: status == null ? const Value.absent() : Value(status),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  Future<Map<String, dynamic>> _buildAttendanceSummary(
    int studentId,
    int academicPeriodId,
    AcademicPeriod period,
  ) async {
    final filter = StudentAttendanceRecapFilter(
      studentId: studentId,
      academicPeriodId: academicPeriodId,
      startDate: DateTime(
        period.startDate.year,
        period.startDate.month,
        period.startDate.day,
      ),
      endDate: DateTime(
        period.endDate.year,
        period.endDate.month,
        period.endDate.day,
      ).add(const Duration(days: 1)),
    );

    final items =
        await (_database.select(_database.sessions).join([
                innerJoin(
                  _database.students,
                  _database.students.id.equalsExp(_database.sessions.studentId),
                ),
              ])
              ..where(_database.sessions.studentId.equals(studentId))
              ..where(
                _database.sessions.academicPeriodId.equals(academicPeriodId),
              )
              ..where(
                _database.sessions.sessionDate.isBiggerOrEqualValue(
                  filter.startDate,
                ),
              )
              ..where(
                _database.sessions.sessionDate.isSmallerThanValue(
                  filter.endDate,
                ),
              )
              ..where(_database.sessions.isAttendanceSource.equals(true))
              ..where(_database.sessions.deletedAt.isNull()))
            .get();

    final recap = <String, int>{
      'presentCount': 0,
      'permissionCount': 0,
      'absentCount': 0,
      'cancelledCount': 0,
      'rescheduledCount': 0,
    };
    for (final row in items) {
      final session = row.readTable(_database.sessions);
      switch (session.attendanceStatus) {
        case AttendanceStatus.present:
          recap['presentCount'] = recap['presentCount']! + 1;
          break;
        case AttendanceStatus.permission:
          recap['permissionCount'] = recap['permissionCount']! + 1;
          break;
        case AttendanceStatus.absent:
          recap['absentCount'] = recap['absentCount']! + 1;
          break;
        case AttendanceStatus.cancelled:
          recap['cancelledCount'] = recap['cancelledCount']! + 1;
          break;
        case AttendanceStatus.rescheduled:
          recap['rescheduledCount'] = recap['rescheduledCount']! + 1;
          break;
      }
    }

    return {
      ...recap,
      'totalSessions': items.length,
      'periodRange': {
        'startDate': period.startDate.toIso8601String(),
        'endDate': period.endDate.toIso8601String(),
      },
    };
  }

  Map<String, dynamic> _buildAssessmentSummaryJson(
    AssessmentPeriodSummary summary,
  ) {
    return {
      'sessionAssessmentCount': summary.sessionAssessmentCount,
      'reviewCycleCount': summary.reviewCycleCount,
      'latestReviewCycleLabel': summary.latestReviewCycle?.reviewCycleLabel,
      'materialsCovered': summary.materialCoverage,
      'progressNotes': summary.progressNotes,
      'learningObstacles': summary.obstacleNotes,
      'nextTargets': summary.aspectDigests
          .firstWhere((digest) => digest.fieldKey == 'targetMateriDrilling')
          .entries,
      'aspects': {
        for (final digest in summary.aspectDigests)
          digest.fieldKey: {
            'count': digest.count,
            'latest': digest.latestEntry,
            'entries': digest.entries,
          },
      },
    };
  }

  String? _blankToNull(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
