import 'package:drift/drift.dart';

import '../../constants/app_constants.dart';
import 'academic_periods_table.dart';
import 'students_table.dart';

class ProgressReports extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get academicPeriodId =>
      integer().references(AcademicPeriods, #id)();
  TextColumn get reportType =>
      text().withDefault(const Constant(ProgressReportType.periodic))();
  DateTimeColumn get generatedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get attendanceSummaryJson =>
      text().withDefault(const Constant('{}'))();
  TextColumn get assessmentSummaryJson =>
      text().withDefault(const Constant('{}'))();
  TextColumn get teacherNote => text().nullable()();
  TextColumn get status =>
      text().withDefault(const Constant(ProgressReportStatus.draft))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
