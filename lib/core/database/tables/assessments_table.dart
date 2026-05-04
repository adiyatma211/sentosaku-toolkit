import 'package:drift/drift.dart';

import '../../constants/app_constants.dart';
import 'academic_periods_table.dart';
import 'sessions_table.dart';
import 'students_table.dart';

class Assessments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer().nullable().references(Sessions, #id)();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get academicPeriodId =>
      integer().nullable().references(AcademicPeriods, #id)();
  TextColumn get assessmentType =>
      text().withDefault(const Constant(AssessmentType.session))();
  TextColumn get reviewCycleLabel => text().nullable()();
  TextColumn get pemahamanMateri => text().nullable()();
  TextColumn get keaktifanTanyaJawab => text().nullable()();
  TextColumn get ketepatanKerapianTugas => text().nullable()();
  TextColumn get konsistensiKehadiranFokus => text().nullable()();
  TextColumn get targetMateriDrilling => text().nullable()();
  TextColumn get sikapBelajarRespon => text().nullable()();
  TextColumn get summaryNote => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
