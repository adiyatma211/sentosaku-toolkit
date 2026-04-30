import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sentosa_catat_app/app/app.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
    Intl.defaultLocale = 'id_ID';
  });

  testWidgets('App starts on splash then opens dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: App()));

    expect(find.text('Sentosaku TutorKit'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1900));
    await tester.pump();

    expect(find.text('Ringkasan'), findsOneWidget);
    expect(find.text('Akses Cepat'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
