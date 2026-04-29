import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/logging/app_logger.dart';

class StudentFormData {
  const StudentFormData({
    required this.name,
    required this.defaultSubject,
    required this.rateType,
    required this.rateAmount,
    required this.status,
    this.parentName,
    this.whatsapp,
    this.address,
    this.school,
    this.grade,
    this.note,
  });

  final String name;
  final String? parentName;
  final String? whatsapp;
  final String? address;
  final String? school;
  final String? grade;
  final String defaultSubject;
  final String rateType;
  final int rateAmount;
  final String status;
  final String? note;
}

class StudentRepository {
  const StudentRepository(this._database, this._logger);

  final AppDatabase _database;
  final AppLogger _logger;

  Stream<List<Student>> watchStudents() {
    final query = _database.select(_database.students)
      ..where((student) => student.deletedAt.isNull())
      ..orderBy([(student) => OrderingTerm.asc(student.name)]);
    return query.watch();
  }

  Stream<List<Student>> watchActiveStudents() {
    final query = _database.select(_database.students)
      ..where((student) => student.status.equals(StudentStatus.active))
      ..where((student) => student.deletedAt.isNull())
      ..orderBy([(student) => OrderingTerm.asc(student.name)]);
    return query.watch();
  }

  Stream<Student?> watchStudentById(int id) {
    final query = _database.select(_database.students)
      ..where((student) => student.id.equals(id))
      ..where((student) => student.deletedAt.isNull());
    return query.watchSingleOrNull();
  }

  Future<int> countActiveStudents() async {
    final count = _database.students.id.count();
    final query = _database.selectOnly(_database.students)
      ..addColumns([count])
      ..where(_database.students.status.equals(StudentStatus.active))
      ..where(_database.students.deletedAt.isNull());

    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  Future<int> insertStudent(StudentFormData data) async {
    const action = 'students.insertStudent';
    final logData = _studentLogData(data);
    _logger.logTransactionStart(action, logData);
    final now = DateTime.now();
    try {
      final id = await _database
          .into(_database.students)
          .insert(
            StudentsCompanion.insert(
              name: data.name.trim(),
              parentName: Value(_blankToNull(data.parentName)),
              whatsapp: Value(_blankToNull(data.whatsapp)),
              address: Value(_blankToNull(data.address)),
              school: Value(_blankToNull(data.school)),
              grade: Value(_blankToNull(data.grade)),
              defaultSubject: Value(data.defaultSubject.trim()),
              rateType: Value(data.rateType),
              rateAmount: Value(data.rateAmount),
              status: Value(data.status),
              note: Value(_blankToNull(data.note)),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      _logger.logTransactionSuccess(action, {...logData, 'studentId': id});
      return id;
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Future<void> updateStudent(int id, StudentFormData data) async {
    const action = 'students.updateStudent';
    final logData = {'studentId': id, ..._studentLogData(data)};
    _logger.logTransactionStart(action, logData);
    try {
      await (_database.update(_database.students)
            ..where((student) => student.id.equals(id))
            ..where((student) => student.deletedAt.isNull()))
          .write(
            StudentsCompanion(
              name: Value(data.name.trim()),
              parentName: Value(_blankToNull(data.parentName)),
              whatsapp: Value(_blankToNull(data.whatsapp)),
              address: Value(_blankToNull(data.address)),
              school: Value(_blankToNull(data.school)),
              grade: Value(_blankToNull(data.grade)),
              defaultSubject: Value(data.defaultSubject.trim()),
              rateType: Value(data.rateType),
              rateAmount: Value(data.rateAmount),
              status: Value(data.status),
              note: Value(_blankToNull(data.note)),
              updatedAt: Value(DateTime.now()),
            ),
          );
      _logger.logTransactionSuccess(action, logData);
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Future<void> deactivateStudent(int id) async {
    const action = 'students.deactivateStudent';
    final logData = {'studentId': id, 'status': StudentStatus.inactive};
    _logger.logTransactionStart(action, logData);
    try {
      await (_database.update(_database.students)
            ..where((student) => student.id.equals(id))
            ..where((student) => student.deletedAt.isNull()))
          .write(
            StudentsCompanion(
              status: const Value(StudentStatus.inactive),
              updatedAt: Value(DateTime.now()),
            ),
          );
      _logger.logTransactionSuccess(action, logData);
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Future<void> softDeleteStudent(int id) async {
    const action = 'students.softDeleteStudent';
    final logData = {'studentId': id};
    _logger.logTransactionStart(action, logData);
    final now = DateTime.now();
    try {
      await (_database.update(_database.students)
            ..where((student) => student.id.equals(id))
            ..where((student) => student.deletedAt.isNull()))
          .write(
            StudentsCompanion(deletedAt: Value(now), updatedAt: Value(now)),
          );
      _logger.logTransactionSuccess(action, logData);
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Map<String, Object?> _studentLogData(StudentFormData data) {
    return {
      'name': data.name.trim(),
      'defaultSubject': data.defaultSubject.trim(),
      'rateType': data.rateType,
      'rateAmount': data.rateAmount,
      'status': data.status,
    };
  }

  String? _blankToNull(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
