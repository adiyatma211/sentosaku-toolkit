import 'package:drift/native.dart';

import 'package:sentosa_catat_app/core/database/app_database.dart';

class TestAppDatabase extends AppDatabase {
  TestAppDatabase() : super(NativeDatabase.memory());
}
