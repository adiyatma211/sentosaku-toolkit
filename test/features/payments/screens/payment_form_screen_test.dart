import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentosa_catat_app/core/constants/app_constants.dart';
import 'package:sentosa_catat_app/core/database/database_provider.dart';
import 'package:sentosa_catat_app/features/payments/screens/payment_form_screen.dart';

import '../../../helpers/pump_app.dart';
import '../../../helpers/seed_data.dart';
import '../../../helpers/test_app_database.dart';

void main() {
  Finder fieldByLabel(String label) {
    return find.byWidgetPredicate(
      (widget) => widget is TextField && widget.decoration?.labelText == label,
    );
  }

  testWidgets('nominal default sama dengan sisa tagihan', (tester) async {
    final database = TestAppDatabase();
    addTearDown(database.close);
    final student = await seedStudent(database, name: 'Bima');
    final invoice = await seedInvoice(
      database,
      studentId: student.id,
      amount: 200000,
      paidAmount: 50000,
      status: InvoiceStatus.partial,
    );

    await pumpApp(
      tester,
      PaymentFormScreen(invoiceId: invoice.id),
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    await tester.pumpAndSettle();

    expect(find.text('Sisa tagihan: Rp150.000'), findsOneWidget);
    expect(find.text('150000'), findsOneWidget);
  });

  testWidgets('validasi nominal kosong nol dan melebihi sisa', (tester) async {
    final database = TestAppDatabase();
    addTearDown(database.close);
    final student = await seedStudent(database);
    final invoice = await seedInvoice(
      database,
      studentId: student.id,
      amount: 100000,
    );

    await pumpApp(
      tester,
      PaymentFormScreen(invoiceId: invoice.id),
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    await tester.pumpAndSettle();

    await tester.enterText(fieldByLabel('Nominal pembayaran'), '');
    await tester.tap(find.text('Simpan pembayaran'));
    await tester.pumpAndSettle();
    expect(find.text('Nominal wajib diisi'), findsOneWidget);

    await tester.enterText(fieldByLabel('Nominal pembayaran'), '0');
    await tester.tap(find.text('Simpan pembayaran'));
    await tester.pumpAndSettle();
    expect(find.text('Nominal wajib lebih dari 0'), findsOneWidget);

    await tester.enterText(fieldByLabel('Nominal pembayaran'), '120000');
    await tester.tap(find.text('Simpan pembayaran'));
    await tester.pumpAndSettle();
    expect(find.text('Nominal melebihi sisa tagihan'), findsOneWidget);
  });

  testWidgets('submit sukses dasar', (tester) async {
    final database = TestAppDatabase();
    addTearDown(database.close);
    final student = await seedStudent(database);
    final invoice = await seedInvoice(
      database,
      studentId: student.id,
      amount: 200000,
    );

    await pumpApp(
      tester,
      PaymentFormScreen(invoiceId: invoice.id),
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    await tester.pumpAndSettle();

    await tester.enterText(fieldByLabel('Nominal pembayaran'), '50000');
    await tester.tap(find.text('Simpan pembayaran'));
    await tester.pumpAndSettle();

    final payments = await database.select(database.payments).get();
    expect(payments, hasLength(1));
    expect(find.text('payment-${invoice.id}'), findsOneWidget);
  });
}
