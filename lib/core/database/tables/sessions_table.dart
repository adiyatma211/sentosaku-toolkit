import 'package:drift/drift.dart';

import '../../constants/app_constants.dart';
import 'academic_periods_table.dart';
import 'schedules_table.dart';
import 'students_table.dart';
import 'subjects_table.dart';

class Sessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get scheduleId => integer().nullable().references(Schedules, #id)();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get subjectId => integer().references(Subjects, #id)();
  IntColumn get academicPeriodId =>
      integer().nullable().references(AcademicPeriods, #id)();
  DateTimeColumn get sessionDate =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get startTime => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get endTime => dateTime().withDefault(currentDateAndTime)();
  TextColumn get attendanceStatus =>
      text().withDefault(const Constant(AttendanceStatus.present))();
  TextColumn get material => text().nullable()();
  TextColumn get homework => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get progressNote => text().nullable()();
  IntColumn get feeAmount => integer().withDefault(const Constant(0))();
  BoolColumn get isAttendanceSource =>
      boolean().withDefault(const Constant(true))();
  IntColumn get invoiceId => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
