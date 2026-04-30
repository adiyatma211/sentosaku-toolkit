import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentosa_catat_app/core/constants/app_constants.dart';
import 'package:sentosa_catat_app/features/payments/data/payment_repository.dart';
import 'package:sentosa_catat_app/features/payments/providers/payment_provider.dart';

import '../../../helpers/provider_test_harness.dart';
import '../../../helpers/seed_data.dart';
import '../../../helpers/test_app_database.dart';

void main() {
  test('invoiceListFilterProvider default unpaid', () async {
    final database = TestAppDatabase();
    final container = createProviderContainer(database: database);
    final student = await seedStudent(database);
    await seedInvoice(database, studentId: student.id, amount: 200000);
    await seedInvoice(
      database,
      studentId: student.id,
      amount: 150000,
      paidAmount: 150000,
      status: InvoiceStatus.paid,
    );

    expect(container.read(invoiceListFilterProvider), InvoiceListFilter.unpaid);

    final unpaidInvoices = await container
        .read(paymentRepositoryProvider)
        .watchUnpaidInvoices()
        .first;
    expect(unpaidInvoices, hasLength(1));
    expect(unpaidInvoices.single.invoice.status, InvoiceStatus.unpaid);

    container
        .read(invoiceListFilterProvider.notifier)
        .setFilter(InvoiceListFilter.all);
    container.invalidate(invoicesProvider);

    final allInvoices = await container
        .read(paymentRepositoryProvider)
        .watchInvoices()
        .first;
    expect(allInvoices, hasLength(2));
  });

  test('paymentFormNotifierProvider success dan error state', () async {
    final database = TestAppDatabase();
    final container = createProviderContainer(database: database);
    final student = await seedStudent(database);
    final invoice = await seedInvoice(
      database,
      studentId: student.id,
      amount: 200000,
    );

    final paymentId = await container
        .read(paymentFormNotifierProvider.notifier)
        .insertPayment(
          PaymentFormData(
            invoiceId: invoice.id,
            amount: 50000,
            method: PaymentMethod.cash,
            paidAt: DateTime(2026, 4, 5),
          ),
        );

    expect(paymentId, greaterThan(0));
    expect(container.read(paymentFormNotifierProvider), isA<AsyncData<void>>());

    await expectLater(
      container
          .read(paymentFormNotifierProvider.notifier)
          .insertPayment(
            PaymentFormData(
              invoiceId: invoice.id,
              amount: 500000,
              method: PaymentMethod.cash,
              paidAt: DateTime(2026, 4, 6),
            ),
          ),
      throwsA(isA<ArgumentError>()),
    );
    expect(
      container.read(paymentFormNotifierProvider),
      isA<AsyncError<void>>(),
    );
  });

  test(
    'invoiceDetailProvider dan paymentHistoryProvider membaca data',
    () async {
      final database = TestAppDatabase();
      final container = createProviderContainer(database: database);
      final student = await seedStudent(database, name: 'Citra');
      final invoice = await seedInvoice(
        database,
        studentId: student.id,
        amount: 250000,
        paidAmount: 50000,
        status: InvoiceStatus.partial,
      );
      await seedPayment(
        database,
        invoiceId: invoice.id,
        amount: 30000,
        paidAt: DateTime(2026, 4, 8, 9),
      );
      await seedPayment(
        database,
        invoiceId: invoice.id,
        amount: 20000,
        paidAt: DateTime(2026, 4, 7, 9),
      );

      final repository = container.read(paymentRepositoryProvider);
      final detail = await repository.watchInvoiceDetail(invoice.id).first;
      final history = await repository.watchPaymentHistory(invoice.id).first;
      final studentHistory = await repository
          .watchStudentPaymentHistory(student.id)
          .first;

      expect(detail, isNotNull);
      expect(detail!.student.name, 'Citra');
      expect(detail.remainingAmount, 200000);
      expect(history.map((payment) => payment.amount), [30000, 20000]);
      expect(studentHistory, hasLength(2));
    },
  );
}
