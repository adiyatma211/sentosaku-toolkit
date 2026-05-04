import 'package:drift/drift.dart';

import '../../constants/app_constants.dart';
import 'academic_periods_table.dart';
import 'students_table.dart';
import 'subjects_table.dart';

class Schedules extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get subjectId => integer().references(Subjects, #id)();
  IntColumn get academicPeriodId =>
      integer().nullable().references(AcademicPeriods, #id)();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  TextColumn get scheduleType =>
      text().withDefault(const Constant(ScheduleType.once))();
  TextColumn get status =>
      text().withDefault(const Constant(ScheduleStatus.scheduled))();
  TextColumn get recurrenceGroupId => text().nullable()();
  BoolColumn get reminderEnabled =>
      boolean().withDefault(const Constant(false))();
  IntColumn get reminderOffsetMinutes =>
      integer().withDefault(const Constant(60))();
  TextColumn get note => text().nullable()();
  DateTimeColumn get lastRescheduledAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
