import 'package:drift/drift.dart';

import '../../constants/app_constants.dart';

class ReminderRules extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get reminderType =>
      text().withDefault(const Constant(ReminderType.scheduleSession))();
  IntColumn get offsetMinutes => integer().nullable()();
  IntColumn get daysBeforeDue => integer().nullable()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  TextColumn get channel =>
      text().withDefault(const Constant(ReminderChannel.localNotification))();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
