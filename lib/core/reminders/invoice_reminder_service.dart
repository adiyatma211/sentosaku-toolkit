import 'dart:convert';

import 'package:drift/drift.dart';

import '../constants/app_constants.dart';
import '../database/app_database.dart';
import '../logging/app_logger.dart';

abstract final class InvoiceReminderStage {
  static const none = 'none';
  static const scheduled = 'scheduled';
  static const dueSoon = 'due_soon';
  static const overdue = 'overdue';
  static const resolved = 'resolved';
}

class InvoiceReminderService {
  InvoiceReminderService(this._database, this._logger);

  static const int dueSoonWindowDays = 3;

  final AppDatabase _database;
  final AppLogger _logger;

  Future<void> syncInvoiceReminderById(int invoiceId) async {
    final invoice =
        await (_database.select(_database.invoices)
              ..where((row) => row.id.equals(invoiceId))
              ..where((row) => row.deletedAt.isNull()))
            .getSingleOrNull();
    if (invoice == null) return;
    await syncInvoiceReminder(invoice);
  }

  Future<void> syncActiveInvoiceReminders() async {
    final invoices = await (_database.select(
      _database.invoices,
    )..where((row) => row.deletedAt.isNull())).get();
    for (final invoice in invoices) {
      await syncInvoiceReminder(invoice);
    }
  }

  Future<void> syncInvoiceReminder(Invoice invoice) async {
    final logData = {
      'invoiceId': invoice.id,
      'status': invoice.status,
      'dueDate': invoice.dueDate?.toIso8601String(),
    };
    try {
      if (!_isReminderEligible(invoice) || invoice.dueDate == null) {
        await closeInvoiceReminder(
          invoice.id,
          resolvedStatus: invoice.status,
          closeReason: invoice.dueDate == null
              ? 'due_date_missing'
              : 'invoice_resolved',
        );
        return;
      }

      final now = DateTime.now();
      final today = _dateOnly(now);
      final dueDate = _dateOnly(invoice.dueDate!);
      final reminderAt = dueDate.subtract(
        const Duration(days: dueSoonWindowDays),
      );
      final stage = _stageFor(
        today: today,
        dueDate: dueDate,
        reminderAt: reminderAt,
      );
      final reminderStatus = stage == InvoiceReminderStage.scheduled
          ? ReminderStatus.scheduled
          : ReminderStatus.triggered;
      final existing = await _latestReminderLog(invoice.id);
      final previousStage = _stageFromPayload(existing?.payloadJson);
      final shouldStampReminder =
          reminderStatus == ReminderStatus.triggered && previousStage != stage;
      final payload = jsonEncode({
        'invoiceId': invoice.id,
        'dueDate': dueDate.toIso8601String(),
        'reminderAt': reminderAt.toIso8601String(),
        'stage': stage,
        'status': invoice.status,
        'generatedAt': now.toIso8601String(),
      });

      await _database.transaction(() async {
        await _upsertReminderLog(
          existing: existing,
          invoiceId: invoice.id,
          scheduledAt: reminderAt,
          status: reminderStatus,
          payload: payload,
          now: now,
        );

        if (shouldStampReminder) {
          await (_database.update(
            _database.invoices,
          )..where((row) => row.id.equals(invoice.id))).write(
            InvoicesCompanion(
              lastRemindedAt: Value(now),
              updatedAt: Value(now),
            ),
          );
        }
      });

      _logger.logInfo('Invoice reminder synced', {
        ...logData,
        'stage': stage,
        'reminderStatus': reminderStatus,
      });
    } catch (error, stackTrace) {
      _logger.logError(
        'Invoice reminder sync failed',
        error,
        stackTrace,
        logData,
      );
      rethrow;
    }
  }

  Future<void> closeInvoiceReminder(
    int invoiceId, {
    String? resolvedStatus,
    String closeReason = 'invoice_closed',
  }) async {
    final now = DateTime.now();
    await (_database.update(_database.reminderLogs)
          ..where((log) => log.referenceTable.equals('invoices'))
          ..where((log) => log.referenceId.equals(invoiceId))
          ..where((log) => log.reminderType.equals(ReminderType.invoiceDue))
          ..where((log) => log.status.equals(ReminderStatus.cancelled).not()))
        .write(
          ReminderLogsCompanion(
            status: const Value(ReminderStatus.cancelled),
            payloadJson: Value(
              jsonEncode({
                'invoiceId': invoiceId,
                'resolvedStatus': resolvedStatus,
                'closeReason': closeReason,
                'closedAt': now.toIso8601String(),
              }),
            ),
            updatedAt: Value(now),
          ),
        );

    _logger.logInfo('Invoice reminder closed', {
      'invoiceId': invoiceId,
      if (resolvedStatus != null) 'resolvedStatus': resolvedStatus,
      'closeReason': closeReason,
    });
  }

  Future<void> _upsertReminderLog({
    required ReminderLog? existing,
    required int invoiceId,
    required DateTime scheduledAt,
    required String status,
    required String payload,
    required DateTime now,
  }) async {
    if (existing == null) {
      await _database
          .into(_database.reminderLogs)
          .insert(
            ReminderLogsCompanion.insert(
              reminderType: const Value(ReminderType.invoiceDue),
              referenceTable: 'invoices',
              referenceId: invoiceId,
              scheduledAt: scheduledAt,
              status: Value(status),
              payloadJson: Value(payload),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      return;
    }

    await (_database.update(
      _database.reminderLogs,
    )..where((row) => row.id.equals(existing.id))).write(
      ReminderLogsCompanion(
        scheduledAt: Value(scheduledAt),
        status: Value(status),
        payloadJson: Value(payload),
        updatedAt: Value(now),
      ),
    );
  }

  Future<ReminderLog?> _latestReminderLog(int invoiceId) {
    return (_database.select(_database.reminderLogs)
          ..where((log) => log.referenceTable.equals('invoices'))
          ..where((log) => log.referenceId.equals(invoiceId))
          ..where((log) => log.reminderType.equals(ReminderType.invoiceDue))
          ..orderBy([(log) => OrderingTerm.desc(log.id)]))
        .getSingleOrNull();
  }

  bool _isReminderEligible(Invoice invoice) {
    return invoice.status == InvoiceStatus.unpaid ||
        invoice.status == InvoiceStatus.partial;
  }

  String _stageFor({
    required DateTime today,
    required DateTime dueDate,
    required DateTime reminderAt,
  }) {
    if (dueDate.isBefore(today)) return InvoiceReminderStage.overdue;
    if (!today.isBefore(reminderAt)) return InvoiceReminderStage.dueSoon;
    return InvoiceReminderStage.scheduled;
  }

  String? _stageFromPayload(String? payloadJson) {
    if (payloadJson == null || payloadJson.trim().isEmpty) return null;
    try {
      final payload = jsonDecode(payloadJson);
      if (payload is Map<String, dynamic>) {
        final stage = payload['stage'];
        return stage is String ? stage : null;
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  DateTime _dateOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }
}
