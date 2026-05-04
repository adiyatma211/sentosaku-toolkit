import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/logging/logger_provider.dart';
import '../../../core/reminders/invoice_reminder_service.dart';
import '../data/session_repository.dart';

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  return SessionRepository(
    ref.watch(databaseProvider),
    ref.watch(appLoggerProvider),
    invoiceReminderService: InvoiceReminderService(
      ref.watch(databaseProvider),
      ref.watch(appLoggerProvider),
    ),
  );
});

final sessionsProvider = StreamProvider<List<SessionListItem>>((ref) {
  return ref.watch(sessionRepositoryProvider).watchSessions();
});

final studentSessionsProvider =
    StreamProvider.family<List<SessionListItem>, int>((ref, studentId) {
      return ref
          .watch(sessionRepositoryProvider)
          .watchStudentSessions(studentId);
    });

final sessionDetailProvider = StreamProvider.family<SessionDetail?, int>((
  ref,
  sessionId,
) {
  return ref.watch(sessionRepositoryProvider).watchSessionById(sessionId);
});

final studentAttendanceRecapProvider =
    StreamProvider.family<
      List<StudentAttendanceRecapItem>,
      StudentAttendanceRecapFilter
    >((ref, filter) {
      return ref
          .watch(sessionRepositoryProvider)
          .watchStudentAttendanceRecap(filter);
    });

final sessionFormNotifierProvider =
    AsyncNotifierProvider.autoDispose<SessionFormNotifier, void>(
      SessionFormNotifier.new,
    );

class SessionFormNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<int> createSessionFromSchedule(SessionFormData data) async {
    state = const AsyncLoading();
    try {
      final id = await ref
          .read(sessionRepositoryProvider)
          .createSessionFromSchedule(data);
      state = const AsyncData(null);
      return id;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
