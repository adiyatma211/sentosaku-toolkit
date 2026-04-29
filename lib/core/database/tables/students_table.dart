import 'package:drift/drift.dart';

import '../../constants/app_constants.dart';

class Students extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get parentName => text().nullable()();
  TextColumn get whatsapp => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get school => text().nullable()();
  TextColumn get grade => text().nullable()();
  TextColumn get defaultSubject => text().nullable()();
  TextColumn get rateType =>
      text().withDefault(const Constant(RateType.perSession))();
  IntColumn get rateAmount => integer().withDefault(const Constant(0))();
  TextColumn get status =>
      text().withDefault(const Constant(StudentStatus.active))();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
