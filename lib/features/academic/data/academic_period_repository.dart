import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/logging/app_logger.dart';

class AcademicPeriodFormData {
  const AcademicPeriodFormData({
    required this.name,
    required this.startDate,
    required this.endDate,
    this.periodType = AcademicPeriodType.semester,
    this.isActive = false,
    this.note,
  });

  final String name;
  final String periodType;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final String? note;
}

class StudentPeriodAssignmentFormData {
  const StudentPeriodAssignmentFormData({
    required this.studentId,
    required this.academicPeriodId,
    this.status = StudentPeriodStatus.active,
    this.enrolledAt,
    this.note,
  });

  final int studentId;
  final int academicPeriodId;
  final String status;
  final DateTime? enrolledAt;
  final String? note;
}

class StudentPeriodAssignmentDetail {
  const StudentPeriodAssignmentDetail({
    required this.studentPeriod,
    required this.academicPeriod,
  });

  final StudentPeriod studentPeriod;
  final AcademicPeriod academicPeriod;
}

class AcademicPeriodRepository {
  const AcademicPeriodRepository(this._database, this._logger);

  final AppDatabase _database;
  final AppLogger _logger;

  Stream<List<AcademicPeriod>> watchAcademicPeriods() {
    final query = _database.select(_database.academicPeriods)
      ..where((period) => period.deletedAt.isNull())
      ..orderBy([
        (period) => OrderingTerm.desc(period.isActive),
        (period) => OrderingTerm.desc(period.startDate),
        (period) => OrderingTerm.asc(period.name),
      ]);
    return query.watch();
  }

  Stream<AcademicPeriod?> watchAcademicPeriodById(int id) {
    final query = _database.select(_database.academicPeriods)
      ..where((period) => period.id.equals(id))
      ..where((period) => period.deletedAt.isNull());
    return query.watchSingleOrNull();
  }

  Stream<List<StudentPeriodAssignmentDetail>> watchStudentAssignments(
    int studentId,
  ) {
    final query =
        (_database.select(_database.studentPeriods).join([
            innerJoin(
              _database.academicPeriods,
              _database.academicPeriods.id.equalsExp(
                _database.studentPeriods.academicPeriodId,
              ),
            ),
          ])
          ..where(_database.studentPeriods.studentId.equals(studentId))
          ..where(_database.studentPeriods.deletedAt.isNull())
          ..where(_database.academicPeriods.deletedAt.isNull())
          ..orderBy([
            OrderingTerm.desc(_database.academicPeriods.isActive),
            OrderingTerm.desc(_database.academicPeriods.startDate),
            OrderingTerm.desc(_database.studentPeriods.enrolledAt),
          ]));
    return query.watch().map(
      (rows) => rows
          .map(
            (row) => StudentPeriodAssignmentDetail(
              studentPeriod: row.readTable(_database.studentPeriods),
              academicPeriod: row.readTable(_database.academicPeriods),
            ),
          )
          .toList(growable: false),
    );
  }

  Future<int> insertAcademicPeriod(AcademicPeriodFormData data) async {
    _validatePeriod(data);
    const action = 'academic.insertAcademicPeriod';
    final logData = {'name': data.name.trim(), 'isActive': data.isActive};
    _logger.logTransactionStart(action, logData);
    try {
      return await _database.transaction(() async {
        if (data.isActive) {
          await _clearActiveAcademicPeriods();
        }
        final now = DateTime.now();
        final id = await _database
            .into(_database.academicPeriods)
            .insert(
              AcademicPeriodsCompanion.insert(
                name: data.name.trim(),
                periodType: Value(data.periodType),
                startDate: _dateOnly(data.startDate),
                endDate: _dateOnly(data.endDate),
                isActive: Value(data.isActive),
                note: Value(_blankToNull(data.note)),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
        _logger.logTransactionSuccess(action, {...logData, 'periodId': id});
        return id;
      });
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Future<void> updateAcademicPeriod(int id, AcademicPeriodFormData data) async {
    _validatePeriod(data);
    const action = 'academic.updateAcademicPeriod';
    final logData = {'periodId': id, 'name': data.name.trim()};
    _logger.logTransactionStart(action, logData);
    try {
      await _database.transaction(() async {
        if (data.isActive) {
          await _clearActiveAcademicPeriods(exceptId: id);
        }
        await (_database.update(_database.academicPeriods)
              ..where((period) => period.id.equals(id))
              ..where((period) => period.deletedAt.isNull()))
            .write(
              AcademicPeriodsCompanion(
                name: Value(data.name.trim()),
                periodType: Value(data.periodType),
                startDate: Value(_dateOnly(data.startDate)),
                endDate: Value(_dateOnly(data.endDate)),
                isActive: Value(data.isActive),
                note: Value(_blankToNull(data.note)),
                updatedAt: Value(DateTime.now()),
              ),
            );
      });
      _logger.logTransactionSuccess(action, logData);
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Future<void> setAcademicPeriodActive(int id) async {
    const action = 'academic.setAcademicPeriodActive';
    final logData = {'periodId': id};
    _logger.logTransactionStart(action, logData);
    try {
      await _database.transaction(() async {
        await _clearActiveAcademicPeriods(exceptId: id);
        await (_database.update(_database.academicPeriods)
              ..where((period) => period.id.equals(id))
              ..where((period) => period.deletedAt.isNull()))
            .write(
              AcademicPeriodsCompanion(
                isActive: const Value(true),
                updatedAt: Value(DateTime.now()),
              ),
            );
      });
      _logger.logTransactionSuccess(action, logData);
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Future<void> softDeleteAcademicPeriod(int id) async {
    const action = 'academic.softDeleteAcademicPeriod';
    final logData = {'periodId': id};
    _logger.logTransactionStart(action, logData);
    final now = DateTime.now();
    try {
      await (_database.update(_database.academicPeriods)
            ..where((period) => period.id.equals(id))
            ..where((period) => period.deletedAt.isNull()))
          .write(
            AcademicPeriodsCompanion(
              isActive: const Value(false),
              deletedAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      _logger.logTransactionSuccess(action, logData);
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Future<int> assignStudentToPeriod(
    StudentPeriodAssignmentFormData data,
  ) async {
    const action = 'academic.assignStudentToPeriod';
    final logData = {
      'studentId': data.studentId,
      'academicPeriodId': data.academicPeriodId,
      'status': data.status,
    };
    _logger.logTransactionStart(action, logData);
    try {
      await _validateAssignment(data);
      final duplicate =
          await (_database.select(_database.studentPeriods)
                ..where((row) => row.studentId.equals(data.studentId))
                ..where(
                  (row) => row.academicPeriodId.equals(data.academicPeriodId),
                )
                ..where((row) => row.deletedAt.isNull()))
              .getSingleOrNull();
      if (duplicate != null) {
        throw StateError('Siswa sudah terhubung ke periode akademik ini.');
      }

      return await _database.transaction(() async {
        final now = DateTime.now();
        final id = await _database
            .into(_database.studentPeriods)
            .insert(
              StudentPeriodsCompanion.insert(
                studentId: data.studentId,
                academicPeriodId: data.academicPeriodId,
                enrolledAt: Value(data.enrolledAt ?? now),
                status: Value(data.status),
                note: Value(_blankToNull(data.note)),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
        if (data.status == StudentPeriodStatus.active) {
          await (_database.update(_database.students)
                ..where((student) => student.id.equals(data.studentId))
                ..where((student) => student.deletedAt.isNull()))
              .write(
                StudentsCompanion(
                  defaultAcademicPeriodId: Value(data.academicPeriodId),
                  updatedAt: Value(now),
                ),
              );
        }
        _logger.logTransactionSuccess(action, {...logData, 'assignmentId': id});
        return id;
      });
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Future<int?> getPreferredAcademicPeriodIdForStudent(
    int studentId, {
    DateTime? referenceDate,
  }) async {
    final date = referenceDate == null ? null : _dateOnly(referenceDate);
    final rows =
        await (_database.select(_database.studentPeriods).join([
                innerJoin(
                  _database.academicPeriods,
                  _database.academicPeriods.id.equalsExp(
                    _database.studentPeriods.academicPeriodId,
                  ),
                ),
              ])
              ..where(_database.studentPeriods.studentId.equals(studentId))
              ..where(_database.studentPeriods.deletedAt.isNull())
              ..where(
                _database.studentPeriods.status.equals(
                  StudentPeriodStatus.active,
                ),
              )
              ..where(_database.academicPeriods.deletedAt.isNull())
              ..orderBy([
                OrderingTerm.desc(_database.academicPeriods.isActive),
                OrderingTerm.desc(_database.academicPeriods.startDate),
                OrderingTerm.desc(_database.studentPeriods.enrolledAt),
              ]))
            .get();

    if (date != null) {
      for (final row in rows) {
        final period = row.readTable(_database.academicPeriods);
        if (!date.isBefore(_dateOnly(period.startDate)) &&
            !date.isAfter(_dateOnly(period.endDate))) {
          return period.id;
        }
      }
    }
    if (rows.isNotEmpty) {
      return rows.first.readTable(_database.academicPeriods).id;
    }

    final student =
        await (_database.select(_database.students)
              ..where((row) => row.id.equals(studentId))
              ..where((row) => row.deletedAt.isNull()))
            .getSingleOrNull();
    return student?.defaultAcademicPeriodId;
  }

  Future<void> _clearActiveAcademicPeriods({int? exceptId}) async {
    final query = _database.update(_database.academicPeriods)
      ..where((period) => period.deletedAt.isNull())
      ..where((period) => period.isActive.equals(true));
    if (exceptId != null) {
      query.where((period) => period.id.isNotValue(exceptId));
    }
    await query.write(
      AcademicPeriodsCompanion(
        isActive: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> _validateAssignment(StudentPeriodAssignmentFormData data) async {
    if (data.status != StudentPeriodStatus.active &&
        data.status != StudentPeriodStatus.completed &&
        data.status != StudentPeriodStatus.inactive) {
      throw ArgumentError.value(data.status, 'status');
    }
    final studentExists =
        await (_database.selectOnly(_database.students)
              ..addColumns([_database.students.id])
              ..where(_database.students.id.equals(data.studentId))
              ..where(_database.students.deletedAt.isNull()))
            .getSingleOrNull();
    if (studentExists == null) {
      throw StateError('Siswa tidak ditemukan.');
    }
    final periodExists =
        await (_database.selectOnly(_database.academicPeriods)
              ..addColumns([_database.academicPeriods.id])
              ..where(
                _database.academicPeriods.id.equals(data.academicPeriodId),
              )
              ..where(_database.academicPeriods.deletedAt.isNull()))
            .getSingleOrNull();
    if (periodExists == null) {
      throw StateError('Periode akademik tidak ditemukan.');
    }
  }

  void _validatePeriod(AcademicPeriodFormData data) {
    if (data.name.trim().isEmpty) {
      throw ArgumentError('Nama periode wajib diisi');
    }
    if (_dateOnly(data.endDate).isBefore(_dateOnly(data.startDate))) {
      throw ArgumentError(
        'Tanggal selesai tidak boleh lebih awal dari tanggal mulai',
      );
    }
    if (data.periodType != AcademicPeriodType.semester &&
        data.periodType != AcademicPeriodType.custom) {
      throw ArgumentError.value(data.periodType, 'periodType');
    }
  }

  DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  String? _blankToNull(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
