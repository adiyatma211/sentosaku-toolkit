import 'package:drift/drift.dart';

import '../../constants/app_constants.dart';
import 'invoices_table.dart';

class Payments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get invoiceId => integer().references(Invoices, #id)();
  IntColumn get amount => integer().withDefault(const Constant(0))();
  TextColumn get method =>
      text().withDefault(const Constant(PaymentMethod.cash))();
  DateTimeColumn get paidAt => dateTime()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
