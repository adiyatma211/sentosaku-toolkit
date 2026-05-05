import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:sentosa_catat_app/features/reports/data/report_models.dart';
import 'package:sentosa_catat_app/features/reports/providers/report_provider.dart';
import 'package:sentosa_catat_app/features/reports/screens/report_screen.dart';

import '../../../helpers/pump_app.dart';

void main() {
  testWidgets('render summary dan menu dasar', (tester) async {
    await pumpApp(
      tester,
      const ReportScreen(),
      overrides: [
        incomeReportProvider.overrideWith(
          (ref) async => const IncomeReport(
            totalIncome: 250000,
            totalPayments: 2,
            rows: [],
          ),
        ),
        unpaidReportProvider.overrideWith(
          (ref) async => const UnpaidReport(
            totalOutstanding: 100000,
            invoiceCount: 1,
            rows: [],
          ),
        ),
        studentReportProvider.overrideWith(
          (ref) async => const StudentReport(
            rows: [
              StudentReportRow(
                studentId: 1,
                studentName: 'Alya',
                totalSessions: 3,
                totalInvoiceAmount: 250000,
                totalPaidAmount: 150000,
                outstandingAmount: 100000,
                assessmentCount: 0,
              ),
            ],
          ),
        ),
        reportFilterLabelProvider.overrideWith((ref) => 'April 2026'),
      ],
    );
    await tester.pumpAndSettle();

    expect(find.text('Ringkasan'), findsOneWidget);
    expect(find.text('Jenis laporan'), findsOneWidget);
    expect(find.text('Pendapatan'), findsWidgets);
    expect(find.text('Tagihan Belum Dibayar'), findsOneWidget);
    expect(find.text('Per Siswa'), findsOneWidget);
    expect(find.text('April 2026'), findsOneWidget);
  });

  testWidgets('refresh invalidate provider dan tampil loading error data', (
    tester,
  ) async {
    var incomeCalls = 0;
    var unpaidCalls = 0;
    var studentCalls = 0;
    var exportCalls = 0;
    final incomeCompleter = Completer<IncomeReport>();

    await pumpApp(
      tester,
      const ReportScreen(),
      overrides: [
        incomeReportProvider.overrideWith((ref) {
          incomeCalls++;
          if (incomeCalls == 1) {
            return incomeCompleter.future;
          }
          return Future.value(
            const IncomeReport(totalIncome: 50000, totalPayments: 1, rows: []),
          );
        }),
        unpaidReportProvider.overrideWith((ref) {
          unpaidCalls++;
          return Future.value(
            const UnpaidReport(
              totalOutstanding: 50000,
              invoiceCount: 1,
              rows: [],
            ),
          );
        }),
        studentReportProvider.overrideWith((ref) {
          studentCalls++;
          return Future.value(
            const StudentReport(
              rows: [
                StudentReportRow(
                  studentId: 7,
                  studentName: 'Bima',
                  totalSessions: 1,
                  totalInvoiceAmount: 50000,
                  totalPaidAmount: 0,
                  outstandingAmount: 50000,
                  assessmentCount: 0,
                ),
              ],
            ),
          );
        }),
        exportReportDataProvider.overrideWith((ref) {
          exportCalls++;
          return Future.value(
            ExportReportData(
              title: 'Laporan',
              generatedAt: DateTime(2026, 4, 1),
              filterLabel: 'April 2026',
              columns: const ['A'],
              rows: const [],
            ),
          );
        }),
        reportFilterLabelProvider.overrideWith((ref) => 'April 2026'),
      ],
    );
    await tester.pump();

    expect(find.text('...'), findsWidgets);

    incomeCompleter.complete(
      const IncomeReport(totalIncome: 100000, totalPayments: 1, rows: []),
    );
    await tester.pumpAndSettle();

    expect(incomeCalls, 1);
    expect(unpaidCalls, 1);
    expect(studentCalls, 1);
    expect(exportCalls, 0);
  });
}
