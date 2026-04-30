import 'package:flutter_test/flutter_test.dart';
import 'package:sentosa_catat_app/core/constants/app_constants.dart';
import 'package:sentosa_catat_app/features/reports/data/report_models.dart';
import 'package:sentosa_catat_app/features/reports/providers/report_provider.dart';

import '../../../helpers/provider_test_harness.dart';
import '../../../helpers/seed_data.dart';
import '../../../helpers/test_app_database.dart';

void main() {
  test('setToday setThisWeek setThisMonth setCustomRange sinkron', () {
    final database = TestAppDatabase();
    final container = createProviderContainer(database: database);
    final notifier = container.read(reportFilterProvider.notifier);

    notifier.setToday();
    final today = container.read(reportFilterProvider);
    expect(today.filterType, ReportFilterType.today);
    expect(today.endDate.difference(today.startDate), const Duration(days: 1));

    notifier.setThisWeek();
    final week = container.read(reportFilterProvider);
    expect(week.filterType, ReportFilterType.week);
    expect(week.endDate.difference(week.startDate), const Duration(days: 7));

    notifier.setThisMonth();
    final month = container.read(reportFilterProvider);
    expect(month.filterType, ReportFilterType.month);
    expect(month.startDate.day, 1);

    notifier.setCustomRange(
      DateTime(2026, 4, 10, 14, 30),
      DateTime(2026, 4, 15, 8, 15),
    );
    final custom = container.read(reportFilterProvider);
    expect(custom.filterType, ReportFilterType.custom);
    expect(custom.startDate, DateTime(2026, 4, 10));
    expect(custom.endDate, DateTime(2026, 4, 16));
  });

  test('reportFilterLabelProvider sinkron dengan filter', () {
    final database = TestAppDatabase();
    final container = createProviderContainer(database: database);
    final notifier = container.read(reportFilterProvider.notifier);

    notifier.setToday();
    expect(container.read(reportFilterLabelProvider), startsWith('Hari ini'));

    notifier.setThisWeek();
    expect(container.read(reportFilterLabelProvider), startsWith('Minggu ini'));

    notifier.setThisMonth();
    expect(container.read(reportFilterLabelProvider), startsWith('Bulan ini'));

    notifier.setCustomRange(DateTime(2026, 4, 1), DateTime(2026, 4, 2));
    expect(container.read(reportFilterLabelProvider), startsWith('Custom'));
  });

  test('income unpaid student provider return data dari repo', () async {
    final database = TestAppDatabase();
    final container = createProviderContainer(database: database);
    final student = await seedStudent(database, name: 'Dewi');
    final subject = await seedSubject(
      database,
      studentId: student.id,
      name: 'Biologi',
    );
    final session = await seedSession(
      database,
      studentId: student.id,
      subjectId: subject.id,
      sessionDate: dateOnly(2026, 4, 3),
      attendanceStatus: AttendanceStatus.present,
      feeAmount: 200000,
    );
    final invoice = await seedInvoice(
      database,
      studentId: student.id,
      sessionId: session.id,
      amount: 200000,
      paidAmount: 50000,
      status: InvoiceStatus.partial,
      createdAt: DateTime(2026, 4, 3, 8),
    );
    await seedPayment(
      database,
      invoiceId: invoice.id,
      amount: 50000,
      paidAt: DateTime(2026, 4, 4, 9),
    );

    container
        .read(reportFilterProvider.notifier)
        .setCustomRange(DateTime(2026, 4, 1), DateTime(2026, 4, 30));

    final income = await container.read(incomeReportProvider.future);
    final unpaid = await container.read(unpaidReportProvider.future);
    final studentReport = await container.read(studentReportProvider.future);

    expect(income.totalIncome, 50000);
    expect(unpaid.totalOutstanding, 150000);
    expect(studentReport.totalSessions, 1);
    expect(studentReport.rows.single.studentName, 'Dewi');
  });
}
