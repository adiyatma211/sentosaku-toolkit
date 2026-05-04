import 'package:go_router/go_router.dart';

import 'app_shell.dart';
import '../features/academic/screens/academic_period_form_screen.dart';
import '../features/academic/screens/academic_period_list_screen.dart';
import '../features/academic/screens/assessment_review_screen.dart';
import '../features/academic/screens/progress_report_screen.dart';
import '../features/academic/screens/student_period_assignment_screen.dart';
import '../features/backup/screens/backup_restore_screen.dart';
import '../features/dashboard/screens/dashboard_screen.dart';
import '../features/guide/screens/guide_screen.dart';
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
    ShellRoute(
      builder: (context, state, child) =>
          AppShell(location: state.uri.path, child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          name: 'dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/students',
          name: 'students',
          builder: (context, state) => const StudentListScreen(),
        ),
        GoRoute(
          path: '/schedules',
          name: 'schedules',
          builder: (context, state) => const ScheduleListScreen(),
        ),
        GoRoute(
          path: '/payments',
          name: 'payments',
          builder: (context, state) => const InvoiceListScreen(),
        ),
        GoRoute(
          path: '/reports',
          name: 'reports',
          builder: (context, state) => const ReportScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/academic-periods',
      name: 'academic-periods',
      builder: (context, state) => const AcademicPeriodListScreen(),
    ),
    GoRoute(
      path: '/academic-periods/new',
      name: 'academic-period-new',
      builder: (context, state) => const AcademicPeriodFormScreen(),
    ),
    GoRoute(
      path: '/academic-periods/:id/edit',
      name: 'academic-period-edit',
      builder: (context, state) => AcademicPeriodFormScreen(
        periodId: int.parse(state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/students/new',
      name: 'student-new',
      builder: (context, state) => const StudentFormScreen(),
    ),
    GoRoute(
      path: '/students/:id',
      name: 'student-detail',
      builder: (context, state) => StudentDetailScreen(
        studentId: int.parse(state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/students/:id/edit',
      name: 'student-edit',
      builder: (context, state) =>
          StudentFormScreen(studentId: int.parse(state.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/students/:id/periods',
      name: 'student-periods',
      builder: (context, state) => StudentPeriodAssignmentScreen(
        studentId: int.parse(state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/students/:id/assessments/review',
      name: 'student-assessment-review',
      builder: (context, state) => AssessmentReviewScreen(
        studentId: int.parse(state.pathParameters['id']!),
        initialAcademicPeriodId: int.tryParse(
          state.uri.queryParameters['periodId'] ?? '',
        ),
      ),
    ),
    GoRoute(
      path: '/students/:id/progress-report',
      name: 'student-progress-report',
      builder: (context, state) => ProgressReportScreen(
        studentId: int.parse(state.pathParameters['id']!),
        initialAcademicPeriodId: int.tryParse(
          state.uri.queryParameters['periodId'] ?? '',
        ),
      ),
    ),
    GoRoute(
      path: '/schedules/new',
      name: 'schedule-new',
      builder: (context, state) => const ScheduleFormScreen(),
    ),
    GoRoute(
      path: '/schedules/:id',
      name: 'schedule-detail',
      builder: (context, state) => ScheduleDetailScreen(
        scheduleId: int.parse(state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/schedules/:id/edit',
      name: 'schedule-edit',
      builder: (context, state) => ScheduleFormScreen(
        scheduleId: int.parse(state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/schedules/:id/session/new',
      name: 'schedule-session-new',
      builder: (context, state) =>
          SessionFormScreen(scheduleId: int.parse(state.pathParameters['id']!)),
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
      path: '/payments/:id',
      name: 'payment-detail',
      builder: (context, state) => InvoiceDetailScreen(
        invoiceId: int.parse(state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/payments/:id/pay',
      name: 'payment-pay',
      builder: (context, state) =>
          PaymentFormScreen(invoiceId: int.parse(state.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/reports/income',
      name: 'reports-income',
      builder: (context, state) => const IncomeReportScreen(),
    ),
    GoRoute(
      path: '/reports/unpaid',
      name: 'reports-unpaid',
      builder: (context, state) => const UnpaidReportScreen(),
    ),
    GoRoute(
      path: '/reports/students',
      name: 'reports-students',
      builder: (context, state) => const StudentReportScreen(),
    ),
    GoRoute(
      path: '/backup',
      name: 'backup',
      builder: (context, state) => const BackupRestoreScreen(),
    ),
    GoRoute(
      path: '/guide',
      name: 'guide',
      builder: (context, state) => const GuideScreen(),
    ),
  ],
);
