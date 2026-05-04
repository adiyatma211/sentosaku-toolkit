import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentosa_catat_app/core/database/app_database.dart';
import 'package:sentosa_catat_app/core/constants/app_constants.dart';
import 'package:sentosa_catat_app/core/logging/app_logger.dart';
import 'package:sentosa_catat_app/core/reminders/invoice_reminder_service.dart';
import 'package:sentosa_catat_app/features/payments/data/payment_repository.dart';

import '../../../helpers/seed_data.dart';
import '../../../helpers/test_app_database.dart';

void main() {
  late TestAppDatabase database;
  late PaymentRepository repository;
  late InvoiceReminderService reminderService;

  setUp(() {
    database = TestAppDatabase();
    reminderService = InvoiceReminderService(database, AppLogger());
    repository = PaymentRepository(
      database,
      AppLogger(),
      invoiceReminderService: reminderService,
    );
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'insert payment valid mengubah paidAmount dan status partial lalu paid',
    () async {
      final student = await seedStudent(database);
      final invoice = await seedInvoice(
        database,
        studentId: student.id,
        amount: 200000,
      );

      await repository.insertPayment(
        PaymentFormData(
          invoiceId: invoice.id,
          amount: 50000,
          method: PaymentMethod.cash,
          paidAt: DateTime(2026, 4, 5, 9),
        ),
      );

      var updatedInvoice = await (database.select(
        database.invoices,
      )..where((t) => t.id.equals(invoice.id))).getSingle();
      expect(updatedInvoice.paidAmount, 50000);
      expect(updatedInvoice.status, InvoiceStatus.partial);

      await repository.insertPayment(
        PaymentFormData(
          invoiceId: invoice.id,
          amount: 150000,
          method: PaymentMethod.transfer,
          paidAt: DateTime(2026, 4, 6, 9),
        ),
      );

      updatedInvoice = await (database.select(
        database.invoices,
      )..where((t) => t.id.equals(invoice.id))).getSingle();
      final payments = await (database.select(
        database.payments,
      )..where((t) => t.invoiceId.equals(invoice.id))).get();

      expect(updatedInvoice.paidAmount, 200000);
      expect(updatedInvoice.status, InvoiceStatus.paid);
      expect(payments, hasLength(2));
    },
  );

  test('reject overpayment', () async {
    final student = await seedStudent(database);
    final invoice = await seedInvoice(
      database,
      studentId: student.id,
      amount: 100000,
      paidAmount: 25000,
      status: InvoiceStatus.partial,
    );

    await expectLater(
      () => repository.insertPayment(
        PaymentFormData(
          invoiceId: invoice.id,
          amount: 80000,
          method: PaymentMethod.cash,
          paidAt: DateTime(2026, 4, 7, 9),
        ),
      ),
      throwsA(isA<ArgumentError>()),
    );
  });

  test('reject invoice paid atau cancelled', () async {
    final student = await seedStudent(database);
    final paidInvoice = await seedInvoice(
      database,
      studentId: student.id,
      amount: 100000,
      paidAmount: 100000,
      status: InvoiceStatus.paid,
    );
    final cancelledInvoice = await seedInvoice(
      database,
      studentId: student.id,
      amount: 100000,
      status: InvoiceStatus.cancelled,
    );

    await expectLater(
      () => repository.insertPayment(
        PaymentFormData(
          invoiceId: paidInvoice.id,
          amount: 10000,
          method: PaymentMethod.cash,
          paidAt: DateTime(2026, 4, 8, 9),
        ),
      ),
      throwsA(isA<StateError>()),
    );

    await expectLater(
      () => repository.insertPayment(
        PaymentFormData(
          invoiceId: cancelledInvoice.id,
          amount: 10000,
          method: PaymentMethod.cash,
          paidAt: DateTime(2026, 4, 8, 10),
        ),
      ),
      throwsA(isA<StateError>()),
    );
  });

  test('watch due soon dan overdue invoices sesuai due date', () async {
    final student = await seedStudent(database);
    final today = DateTime.now();
    final dueSoonInvoice = await seedInvoice(
      database,
      studentId: student.id,
      amount: 100000,
      dueDate: DateTime(today.year, today.month, today.day + 2),
    );
    await seedInvoice(
      database,
      studentId: student.id,
      amount: 120000,
      dueDate: DateTime(today.year, today.month, today.day + 10),
    );
    final overdueInvoice = await seedInvoice(
      database,
      studentId: student.id,
      amount: 90000,
      dueDate: DateTime(today.year, today.month, today.day - 1),
    );

    final dueSoon = await repository.watchDueSoonInvoices().first;
    final overdue = await repository.watchOverdueInvoices().first;

    expect(dueSoon.map((row) => row.invoice.id), contains(dueSoonInvoice.id));
    expect(
      dueSoon.map((row) => row.invoice.id),
      isNot(contains(overdueInvoice.id)),
    );
    expect(overdue.map((row) => row.invoice.id), contains(overdueInvoice.id));
    expect(
      overdue.map((row) => row.invoice.id),
      isNot(contains(dueSoonInvoice.id)),
    );
  });

  test('insert payment menutup reminder invoice saat invoice lunas', () async {
    final student = await seedStudent(database);
    final invoice = await seedInvoice(
      database,
      studentId: student.id,
      amount: 100000,
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
    );
    await database
        .into(database.reminderLogs)
        .insert(
          ReminderLogsCompanion.insert(
            reminderType: const Value(ReminderType.invoiceDue),
            referenceTable: 'invoices',
            referenceId: invoice.id,
            scheduledAt: DateTime.now().subtract(const Duration(days: 2)),
            status: const Value(ReminderStatus.triggered),
            payloadJson: const Value('{"stage":"overdue"}'),
          ),
        );

    await repository.insertPayment(
      PaymentFormData(
        invoiceId: invoice.id,
        amount: 100000,
        method: PaymentMethod.cash,
        paidAt: DateTime(2026, 4, 9, 9),
      ),
    );

    final updatedInvoice = await (database.select(
      database.invoices,
    )..where((row) => row.id.equals(invoice.id))).getSingle();
    final reminderLog = await (database.select(
      database.reminderLogs,
    )..where((row) => row.referenceId.equals(invoice.id))).getSingle();

    expect(updatedInvoice.status, InvoiceStatus.paid);
    expect(reminderLog.status, ReminderStatus.cancelled);
  });
}
