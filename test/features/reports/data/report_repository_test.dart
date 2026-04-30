import 'package:flutter_test/flutter_test.dart';
import 'package:sentosa_catat_app/core/constants/app_constants.dart';
import 'package:sentosa_catat_app/features/reports/data/report_models.dart';
import 'package:sentosa_catat_app/features/reports/data/report_repository.dart';

import '../../../helpers/seed_data.dart';
import '../../../helpers/test_app_database.dart';

void main() {
  late TestAppDatabase database;
  late ReportRepository repository;

  setUp(() {
    database = TestAppDatabase();
    repository = ReportRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('income report menghitung total payments pada periode', () async {
    final student = await seedStudent(database, name: 'Alya');
    final subject = await seedSubject(database, studentId: student.id);
    final session = await seedSession(
      database,
      studentId: student.id,
      subjectId: subject.id,
      sessionDate: dateOnly(2026, 4, 10),
    );
    final invoice = await seedInvoice(
      database,
      studentId: student.id,
      sessionId: session.id,
      amount: 200000,
      paidAmount: 150000,
      status: InvoiceStatus.partial,
    );
    await seedPayment(
      database,
      invoiceId: invoice.id,
      amount: 50000,
      paidAt: DateTime(2026, 4, 10, 9),
    );
    await seedPayment(
      database,
      invoiceId: invoice.id,
      amount: 100000,
      paidAt: DateTime(2026, 4, 11, 9),
    );
    await seedPayment(
      database,
      invoiceId: invoice.id,
      amount: 90000,
      paidAt: DateTime(2026, 5, 1, 9),
    );

    final report = await repository.getIncomeReport(
      ReportFilter(
        startDate: DateTime(2026, 4, 1),
        endDate: DateTime(2026, 5, 1),
        filterType: ReportFilterType.custom,
      ),
    );

    expect(report.totalIncome, 150000);
    expect(report.totalPayments, 2);
    expect(report.rows.map((row) => row.amount), [100000, 50000]);
  });

  test('unpaid report hanya ambil unpaid/partial remaining > 0', () async {
    final student = await seedStudent(database, name: 'Bagas');
    final unpaidInvoice = await seedInvoice(
      database,
      studentId: student.id,
      amount: 200000,
      paidAmount: 0,
      status: InvoiceStatus.unpaid,
      dueDate: DateTime(2026, 4, 20),
    );
    final partialInvoice = await seedInvoice(
      database,
      studentId: student.id,
      amount: 300000,
      paidAmount: 125000,
      status: InvoiceStatus.partial,
      dueDate: DateTime(2026, 4, 25),
    );
    await seedInvoice(
      database,
      studentId: student.id,
      amount: 100000,
      paidAmount: 100000,
      status: InvoiceStatus.paid,
    );
    await seedInvoice(
      database,
      studentId: student.id,
      amount: 50000,
      paidAmount: 0,
      status: InvoiceStatus.cancelled,
    );

    final report = await repository.getUnpaidReport();

    expect(report.invoiceCount, 2);
    expect(report.totalOutstanding, 375000);
    expect(report.rows.map((row) => row.invoiceId), [
      unpaidInvoice.id,
      partialInvoice.id,
    ]);
    expect(report.rows.map((row) => row.remaining), [200000, 175000]);
  });

  test(
    'student report aggregate sessions/invoice/payment/outstanding',
    () async {
      final studentA = await seedStudent(database, name: 'Citra');
      final studentB = await seedStudent(database, name: 'Dimas');
      final subjectMath = await seedSubject(
        database,
        studentId: studentA.id,
        name: 'Math',
      );
      final subjectEnglish = await seedSubject(
        database,
        studentId: studentB.id,
        name: 'English',
      );

      final sessionA1 = await seedSession(
        database,
        studentId: studentA.id,
        subjectId: subjectMath.id,
        sessionDate: dateOnly(2026, 4, 3),
        feeAmount: 100000,
        attendanceStatus: AttendanceStatus.present,
      );
      await seedSession(
        database,
        studentId: studentA.id,
        subjectId: subjectMath.id,
        sessionDate: dateOnly(2026, 4, 4),
        feeAmount: 100000,
        attendanceStatus: AttendanceStatus.present,
      );
      await seedSession(
        database,
        studentId: studentB.id,
        subjectId: subjectEnglish.id,
        sessionDate: dateOnly(2026, 4, 5),
        feeAmount: 120000,
        attendanceStatus: AttendanceStatus.present,
      );

      final invoiceA1 = await seedInvoice(
        database,
        studentId: studentA.id,
        sessionId: sessionA1.id,
        amount: 100000,
        paidAmount: 40000,
        status: InvoiceStatus.partial,
        createdAt: DateTime(2026, 4, 3, 8),
      );
      await seedInvoice(
        database,
        studentId: studentA.id,
        amount: 100000,
        paidAmount: 0,
        status: InvoiceStatus.unpaid,
        createdAt: DateTime(2026, 4, 4, 8),
      );
      final invoiceB = await seedInvoice(
        database,
        studentId: studentB.id,
        amount: 120000,
        paidAmount: 120000,
        status: InvoiceStatus.paid,
        createdAt: DateTime(2026, 4, 5, 8),
      );

      await seedPayment(
        database,
        invoiceId: invoiceA1.id,
        amount: 40000,
        paidAt: DateTime(2026, 4, 6, 9),
      );
      await seedPayment(
        database,
        invoiceId: invoiceB.id,
        amount: 120000,
        paidAt: DateTime(2026, 4, 7, 9),
      );

      final report = await repository.getStudentReport(
        ReportFilter(
          startDate: DateTime(2026, 4, 1),
          endDate: DateTime(2026, 5, 1),
          filterType: ReportFilterType.custom,
        ),
      );

      expect(report.rows, hasLength(2));

      final citra = report.rows.firstWhere(
        (row) => row.studentId == studentA.id,
      );
      final dimas = report.rows.firstWhere(
        (row) => row.studentId == studentB.id,
      );

      expect(citra.totalSessions, 2);
      expect(citra.totalInvoiceAmount, 200000);
      expect(citra.totalPaidAmount, 40000);
      expect(citra.outstandingAmount, 160000);

      expect(dimas.totalSessions, 1);
      expect(dimas.totalInvoiceAmount, 120000);
      expect(dimas.totalPaidAmount, 120000);
      expect(dimas.outstandingAmount, 0);
    },
  );
}
