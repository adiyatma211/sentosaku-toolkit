import 'package:drift/drift.dart';

import '../../constants/app_constants.dart';
import 'academic_periods_table.dart';
import 'students_table.dart';

class StudentPeriods extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get academicPeriodId =>
      integer().references(AcademicPeriods, #id)();
  DateTimeColumn get enrolledAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get status =>
      text().withDefault(const Constant(StudentPeriodStatus.active))();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
