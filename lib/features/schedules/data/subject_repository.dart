import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/logging/app_logger.dart';

class SubjectRepository {
  const SubjectRepository(this._database, this._logger);

  final AppDatabase _database;
  final AppLogger _logger;

  Stream<List<Subject>> watchActiveSubjects() {
    final query = _database.select(_database.subjects)
      ..where((subject) => subject.isActive.equals(true))
      ..orderBy([(subject) => OrderingTerm.asc(subject.name)]);
    return query.watch();
  }

  Stream<List<Subject>> watchSubjectsByStudent(int studentId) {
    final query = _database.select(_database.subjects)
      ..where(
        (subject) =>
            subject.isActive.equals(true) &
            (subject.studentId.isNull() | subject.studentId.equals(studentId)),
      )
      ..orderBy([
        (subject) => OrderingTerm(expression: subject.studentId.isNull()),
        (subject) => OrderingTerm.asc(subject.name),
      ]);
    return query.watch();
  }

  Future<int> ensureSubjectForStudent({
    required int studentId,
    required String name,
    int? defaultRateAmount,
  }) async {
    const action = 'subjects.ensureSubjectForStudent';
    final trimmedName = name.trim();
    final logData = {
      'studentId': studentId,
      'name': trimmedName,
      'defaultRateAmount': defaultRateAmount ?? 0,
    };
    _logger.logTransactionStart(action, logData);
    try {
      if (trimmedName.isEmpty) {
        throw ArgumentError.value(name, 'name', 'Subject wajib diisi');
      }

      final existing =
          await (_database.select(_database.subjects)
                ..where((subject) => subject.isActive.equals(true))
                ..where(
                  (subject) =>
                      subject.name.lower().equals(trimmedName.toLowerCase()) &
                      (subject.studentId.isNull() |
                          subject.studentId.equals(studentId)),
                )
                ..limit(1))
              .getSingleOrNull();

      if (existing != null) {
        _logger.logTransactionSuccess(action, {
          ...logData,
          'subjectId': existing.id,
          'created': false,
        });
        return existing.id;
      }

      final now = DateTime.now();
      final id = await _database
          .into(_database.subjects)
          .insert(
            SubjectsCompanion.insert(
              studentId: Value(studentId),
              name: trimmedName,
              defaultRateAmount: Value(defaultRateAmount ?? 0),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      _logger.logTransactionSuccess(action, {
        ...logData,
        'subjectId': id,
        'created': true,
      });
      return id;
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }
}
