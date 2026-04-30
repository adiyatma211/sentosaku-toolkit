import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentosa_catat_app/core/database/database_provider.dart';
import 'package:sentosa_catat_app/core/logging/app_logger.dart';
import 'package:sentosa_catat_app/core/logging/logger_provider.dart';

import 'test_app_database.dart';

ProviderContainer createProviderContainer({
  required TestAppDatabase database,
  List<Object> overrides = const [],
}) {
  final container = ProviderContainer(
    overrides: [
      databaseProvider.overrideWithValue(database),
      appLoggerProvider.overrideWithValue(AppLogger()),
      ...overrides,
    ].cast(),
  );
  addTearDown(container.dispose);
  addTearDown(database.close);
  return container;
}

Future<T> readAsyncValue<T>(ProviderContainer container, dynamic provider) {
  final completer = Completer<T>();
  late final ProviderSubscription<AsyncValue<T>> subscription;

  void resolve(AsyncValue<T> value) {
    value.when(
      data: (data) {
        if (!completer.isCompleted) {
          completer.complete(data);
        }
        subscription.close();
      },
      error: (error, stackTrace) {
        if (!completer.isCompleted) {
          completer.completeError(error, stackTrace);
        }
        subscription.close();
      },
      loading: () {},
    );
  }

  subscription = container.listen<AsyncValue<T>>(
    provider,
    (_, next) => resolve(next),
    fireImmediately: true,
  );

  return completer.future;
}
