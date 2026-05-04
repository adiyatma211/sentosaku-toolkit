import 'package:drift/drift.dart';

import '../../constants/app_constants.dart';
import 'reminder_rules_table.dart';

class ReminderLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get reminderRuleId =>
      integer().nullable().references(ReminderRules, #id)();
  TextColumn get reminderType =>
      text().withDefault(const Constant(ReminderType.scheduleSession))();
  TextColumn get referenceTable => text()();
  IntColumn get referenceId => integer()();
  DateTimeColumn get scheduledAt => dateTime()();
  DateTimeColumn get triggeredAt => dateTime().nullable()();
  TextColumn get status =>
      text().withDefault(const Constant(ReminderStatus.scheduled))();
  TextColumn get payloadJson => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
