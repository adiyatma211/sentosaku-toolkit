import 'package:drift/drift.dart';

import '../../constants/app_constants.dart';
import 'sessions_table.dart';
import 'students_table.dart';

class Invoices extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get sessionId => integer().nullable().references(Sessions, #id)();
  TextColumn get periodLabel => text().withDefault(const Constant(''))();
  IntColumn get amount => integer().withDefault(const Constant(0))();
  IntColumn get paidAmount => integer().withDefault(const Constant(0))();
  TextColumn get status =>
      text().withDefault(const Constant(InvoiceStatus.unpaid))();
  DateTimeColumn get dueDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
