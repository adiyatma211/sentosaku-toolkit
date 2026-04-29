import 'package:drift/drift.dart';

import 'students_table.dart';

class Subjects extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().nullable().references(Students, #id)();
  TextColumn get name => text()();
  IntColumn get defaultRateAmount => integer().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
