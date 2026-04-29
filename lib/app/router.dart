import 'package:go_router/go_router.dart';

import '../features/backup/screens/backup_restore_screen.dart';
import '../features/dashboard/screens/dashboard_screen.dart';
import '../features/payments/screens/invoice_detail_screen.dart';
import '../features/payments/screens/invoice_list_screen.dart';
import '../features/payments/screens/payment_form_screen.dart';
import '../features/reports/screens/income_report_screen.dart';
import '../features/reports/screens/report_screen.dart';
import '../features/reports/screens/student_report_screen.dart';
import '../features/reports/screens/unpaid_report_screen.dart';
import '../features/schedules/screens/schedule_detail_screen.dart';
import '../features/schedules/screens/schedule_form_screen.dart';
import '../features/schedules/screens/schedule_list_screen.dart';
import '../features/sessions/screens/session_detail_screen.dart';
import '../features/sessions/screens/session_form_screen.dart';
import '../features/sessions/screens/session_list_screen.dart';
import '../features/splash/screens/splash_screen.dart';
import '../features/students/screens/student_detail_screen.dart';
import '../features/students/screens/student_form_screen.dart';
import '../features/students/screens/student_list_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/', redirect: (context, state) => '/dashboard'),
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/students',
      name: 'students',
      builder: (context, state) => const StudentListScreen(),
      routes: [
        GoRoute(
          path: 'new',
          name: 'student-new',
          builder: (context, state) => const StudentFormScreen(),
        ),
        GoRoute(
          path: ':id',
          name: 'student-detail',
          builder: (context, state) => StudentDetailScreen(
            studentId: int.parse(state.pathParameters['id']!),
          ),
          routes: [
            GoRoute(
              path: 'edit',
              name: 'student-edit',
              builder: (context, state) => StudentFormScreen(
                studentId: int.parse(state.pathParameters['id']!),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/schedules',
      name: 'schedules',
      builder: (context, state) => const ScheduleListScreen(),
      routes: [
        GoRoute(
          path: 'new',
          name: 'schedule-new',
          builder: (context, state) => const ScheduleFormScreen(),
        ),
        GoRoute(
          path: ':id',
          name: 'schedule-detail',
          builder: (context, state) => ScheduleDetailScreen(
            scheduleId: int.parse(state.pathParameters['id']!),
          ),
          routes: [
            GoRoute(
              path: 'edit',
              name: 'schedule-edit',
              builder: (context, state) => ScheduleFormScreen(
                scheduleId: int.parse(state.pathParameters['id']!),
              ),
            ),
            GoRoute(
              path: 'session/new',
              name: 'schedule-session-new',
              builder: (context, state) => SessionFormScreen(
                scheduleId: int.parse(state.pathParameters['id']!),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/sessions',
      name: 'sessions',
      builder: (context, state) => const SessionListScreen(),
      routes: [
        GoRoute(
          path: ':id',
          name: 'session-detail',
          builder: (context, state) => SessionDetailScreen(
            sessionId: int.parse(state.pathParameters['id']!),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/payments',
      name: 'payments',
      builder: (context, state) => const InvoiceListScreen(),
      routes: [
        GoRoute(
          path: ':id',
          name: 'payment-detail',
          builder: (context, state) => InvoiceDetailScreen(
            invoiceId: int.parse(state.pathParameters['id']!),
          ),
          routes: [
            GoRoute(
              path: 'pay',
              name: 'payment-pay',
              builder: (context, state) => PaymentFormScreen(
                invoiceId: int.parse(state.pathParameters['id']!),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/reports',
      name: 'reports',
      builder: (context, state) => const ReportScreen(),
      routes: [
        GoRoute(
          path: 'income',
          name: 'reports-income',
          builder: (context, state) => const IncomeReportScreen(),
        ),
        GoRoute(
          path: 'unpaid',
          name: 'reports-unpaid',
          builder: (context, state) => const UnpaidReportScreen(),
        ),
        GoRoute(
          path: 'students',
          name: 'reports-students',
          builder: (context, state) => const StudentReportScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/backup',
      name: 'backup',
      builder: (context, state) => const BackupRestoreScreen(),
    ),
  ],
);
