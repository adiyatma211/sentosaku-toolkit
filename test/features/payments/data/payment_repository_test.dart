import 'package:flutter_test/flutter_test.dart';
import 'package:sentosa_catat_app/core/constants/app_constants.dart';
import 'package:sentosa_catat_app/core/logging/app_logger.dart';
import 'package:sentosa_catat_app/features/payments/data/payment_repository.dart';

import '../../../helpers/seed_data.dart';
import '../../../helpers/test_app_database.dart';

void main() {
  late TestAppDatabase database;
  late PaymentRepository repository;

  setUp(() {
    database = TestAppDatabase();
    repository = PaymentRepository(database, AppLogger());
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
}
