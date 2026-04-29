import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../students/data/student_repository.dart';

class DashboardSummary {
  const DashboardSummary({
    required this.activeStudents,
    required this.todaySchedules,
    required this.completedSessionsThisMonth,
    required this.monthlyRevenue,
    required this.unpaidInvoices,
  });

  final int activeStudents;
  final int todaySchedules;
  final int completedSessionsThisMonth;
  final int monthlyRevenue;
  final int unpaidInvoices;
}

class DashboardRepository {
  const DashboardRepository(this._database, this._studentRepository);

  final AppDatabase _database;
  final StudentRepository _studentRepository;

  Future<DashboardSummary> getSummary({
    int? activeStudentCount,
    int? todayScheduleCount,
  }) async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final tomorrowStart = todayStart.add(const Duration(days: 1));
    final monthStart = DateTime(now.year, now.month);
    final nextMonthStart = DateTime(now.year, now.month + 1);

    final activeStudents =
        activeStudentCount ?? await _studentRepository.countActiveStudents();
    final todaySchedules =
        todayScheduleCount ??
        await _countTodaySchedules(todayStart, tomorrowStart);
    final monthlyRevenue = await _sumMonthlyRevenue(monthStart, nextMonthStart);
    final completedSessionsThisMonth = await _countCompletedSessions(
      monthStart,
      nextMonthStart,
    );
    final unpaidInvoices = await _countUnpaidInvoices();

    return DashboardSummary(
      activeStudents: activeStudents,
      todaySchedules: todaySchedules,
      completedSessionsThisMonth: completedSessionsThisMonth,
      monthlyRevenue: monthlyRevenue,
      unpaidInvoices: unpaidInvoices,
    );
  }

  Future<int> _countTodaySchedules(DateTime start, DateTime end) async {
    final count = _database.schedules.id.count();
    final query = _database.selectOnly(_database.schedules)
      ..addColumns([count])
      ..where(_database.schedules.date.isBiggerOrEqualValue(start))
      ..where(_database.schedules.date.isSmallerThanValue(end))
      ..where(_database.schedules.deletedAt.isNull());

    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  Future<int> _sumMonthlyRevenue(DateTime start, DateTime end) async {
    final total = _database.payments.amount.sum();
    final query = _database.selectOnly(_database.payments)
      ..addColumns([total])
      ..where(_database.payments.paidAt.isBiggerOrEqualValue(start))
      ..where(_database.payments.paidAt.isSmallerThanValue(end))
      ..where(_database.payments.deletedAt.isNull());

    final row = await query.getSingle();
    return row.read(total) ?? 0;
  }

  Future<int> _countCompletedSessions(DateTime start, DateTime end) async {
    final count = _database.sessions.id.count();
    final query = _database.selectOnly(_database.sessions)
      ..addColumns([count])
      ..where(_database.sessions.sessionDate.isBiggerOrEqualValue(start))
      ..where(_database.sessions.sessionDate.isSmallerThanValue(end))
      ..where(
        _database.sessions.attendanceStatus.equals(AttendanceStatus.present),
      )
      ..where(_database.sessions.deletedAt.isNull());

    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  Future<int> _countUnpaidInvoices() async {
    final count = _database.invoices.id.count();
    final query = _database.selectOnly(_database.invoices)
      ..addColumns([count])
      ..where(
        _database.invoices.status.isIn([
          InvoiceStatus.unpaid,
          InvoiceStatus.partial,
        ]),
      )
      ..where(
        _database.invoices.amount.isBiggerThan(_database.invoices.paidAmount),
      )
      ..where(_database.invoices.deletedAt.isNull());

    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }
}
