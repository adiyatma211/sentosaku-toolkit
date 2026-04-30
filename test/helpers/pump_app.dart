import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:showcaseview/showcaseview.dart';

var _didInitializeTestLocale = false;

Future<void> pumpApp(
  WidgetTester tester,
  Widget child, {
  List<Object> overrides = const [],
  String initialLocation = '/',
}) async {
  if (!_didInitializeTestLocale) {
    await initializeDateFormatting('id_ID');
    Intl.defaultLocale = 'id_ID';
    _didInitializeTestLocale = true;
  }

  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = const Size(1440, 2400);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final router = GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(path: '/', builder: (context, state) => child),
      GoRoute(
        path: '/sessions/:id',
        builder: (context, state) =>
            _RouteStub('session-${state.pathParameters['id']}'),
      ),
      GoRoute(
        path: '/payments/:id',
        builder: (context, state) =>
            _RouteStub('payment-${state.pathParameters['id']}'),
      ),
      GoRoute(
        path: '/students/:id',
        builder: (context, state) =>
            _RouteStub('student-${state.pathParameters['id']}'),
      ),
      GoRoute(
        path: '/students/new',
        builder: (context, state) => const _RouteStub('student-new'),
      ),
      GoRoute(
        path: '/schedules/:id',
        builder: (context, state) =>
            _RouteStub('schedule-${state.pathParameters['id']}'),
      ),
      GoRoute(
        path: '/reports/income',
        builder: (context, state) => const _RouteStub('report-income'),
      ),
      GoRoute(
        path: '/reports/unpaid',
        builder: (context, state) => const _RouteStub('report-unpaid'),
      ),
      GoRoute(
        path: '/reports/students',
        builder: (context, state) => const _RouteStub('report-students'),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const _RouteStub('dashboard'),
      ),
    ],
  );
  addTearDown(router.dispose);
  final container = ProviderContainer(overrides: overrides.cast());
  final showcaseView = ShowcaseView.register(skipIfTargetNotPresent: true);
  addTearDown(() async {
    await tester.pumpWidget(const SizedBox.shrink());
    showcaseView.unregister();
    container.dispose();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1));
  });

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(
        locale: const Locale('id', 'ID'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('id', 'ID'), Locale('en', 'US')],
        theme: ThemeData(useMaterial3: true),
        routerConfig: router,
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
}

class _RouteStub extends StatelessWidget {
  const _RouteStub(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(label)));
  }
}
