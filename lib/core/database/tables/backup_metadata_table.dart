import 'package:drift/drift.dart';

class BackupMetadata extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fileName => text()();
  TextColumn get filePath => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
