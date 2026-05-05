enum ReportFilterType { today, week, month, academicPeriod, custom }

class ReportFilter {
  const ReportFilter({
    required this.startDate,
    required this.endDate,
    required this.filterType,
    this.studentId,
    this.subjectId,
    this.academicPeriodId,
    this.academicPeriodName,
    this.includeAttendanceRecap = true,
  });

  factory ReportFilter.currentMonth() {
    final now = DateTime.now();
    return ReportFilter(
      startDate: DateTime(now.year, now.month),
      endDate: DateTime(now.year, now.month + 1),
      filterType: ReportFilterType.month,
    );
  }

  factory ReportFilter.today() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    return ReportFilter(
      startDate: start,
      endDate: start.add(const Duration(days: 1)),
      filterType: ReportFilterType.today,
    );
  }

  factory ReportFilter.thisWeek() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final start = today.subtract(Duration(days: today.weekday - 1));
    return ReportFilter(
      startDate: start,
      endDate: start.add(const Duration(days: 7)),
      filterType: ReportFilterType.week,
    );
  }

  ReportFilter copyWith({
    DateTime? startDate,
    DateTime? endDate,
    ReportFilterType? filterType,
    int? studentId,
    int? subjectId,
    int? academicPeriodId,
    String? academicPeriodName,
    bool? includeAttendanceRecap,
    bool clearStudent = false,
    bool clearSubject = false,
    bool clearAcademicPeriod = false,
  }) {
    return ReportFilter(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      filterType: filterType ?? this.filterType,
      studentId: clearStudent ? null : studentId ?? this.studentId,
      subjectId: clearSubject ? null : subjectId ?? this.subjectId,
      academicPeriodId: clearAcademicPeriod
          ? null
          : academicPeriodId ?? this.academicPeriodId,
      academicPeriodName: clearAcademicPeriod
          ? null
          : academicPeriodName ?? this.academicPeriodName,
      includeAttendanceRecap:
          includeAttendanceRecap ?? this.includeAttendanceRecap,
    );
  }

  final DateTime startDate;
  final DateTime endDate;
  final int? studentId;
  final int? subjectId;
  final int? academicPeriodId;
  final String? academicPeriodName;
  final bool includeAttendanceRecap;
  final ReportFilterType filterType;
}

class AttendanceReport {
  const AttendanceReport({required this.rows});

  final List<AttendanceReportRow> rows;

  int get totalPresent => rows.fold(0, (total, row) => total + row.present);
  int get totalPermission =>
      rows.fold(0, (total, row) => total + row.permission);
  int get totalAbsent => rows.fold(0, (total, row) => total + row.absent);
  int get totalCancelled =>
      rows.fold(0, (total, row) => total + row.cancelled);
  int get totalRescheduled =>
      rows.fold(0, (total, row) => total + row.rescheduled);
  int get totalSessions => rows.fold(0, (total, row) => total + row.total);
}

class AttendanceReportRow {
  const AttendanceReportRow({
    required this.studentId,
    required this.studentName,
    required this.present,
    required this.permission,
    required this.absent,
    required this.cancelled,
    required this.rescheduled,
    this.whatsapp,
  });

  final int studentId;
  final String studentName;
  final String? whatsapp;
  final int present;
  final int permission;
  final int absent;
  final int cancelled;
  final int rescheduled;

  int get total => present + permission + absent + cancelled + rescheduled;
}

class IncomeReport {
  const IncomeReport({
    required this.totalIncome,
    required this.totalPayments,
    required this.rows,
  });

  final int totalIncome;
  final int totalPayments;
  final List<IncomeReportRow> rows;
}

class IncomeReportRow {
  const IncomeReportRow({
    required this.paymentId,
    required this.invoiceId,
    required this.studentName,
    required this.amount,
    required this.paidAt,
    required this.method,
    required this.invoiceStatus,
    this.periodLabel,
  });

  final int paymentId;
  final int invoiceId;
  final String studentName;
  final int amount;
  final DateTime paidAt;
  final String method;
  final String invoiceStatus;
  final String? periodLabel;
}

class UnpaidReport {
  const UnpaidReport({
    required this.totalOutstanding,
    required this.invoiceCount,
    required this.rows,
  });

  final int totalOutstanding;
  final int invoiceCount;
  final List<UnpaidReportRow> rows;
}

class UnpaidReportRow {
  const UnpaidReportRow({
    required this.invoiceId,
    required this.studentName,
    required this.amount,
    required this.paidAmount,
    required this.remaining,
    required this.status,
    this.whatsapp,
    this.dueDate,
    this.periodLabel,
  });

  final int invoiceId;
  final String studentName;
  final String? whatsapp;
  final int amount;
  final int paidAmount;
  final int remaining;
  final String status;
  final DateTime? dueDate;
  final String? periodLabel;
}

class StudentReport {
  const StudentReport({required this.rows});

  final List<StudentReportRow> rows;

  int get totalSessions =>
      rows.fold(0, (total, row) => total + row.totalSessions);
  int get totalInvoiceAmount =>
      rows.fold(0, (total, row) => total + row.totalInvoiceAmount);
  int get totalPaidAmount =>
      rows.fold(0, (total, row) => total + row.totalPaidAmount);
  int get outstandingAmount =>
      rows.fold(0, (total, row) => total + row.outstandingAmount);
}

class StudentReportRow {
  const StudentReportRow({
    required this.studentId,
    required this.studentName,
    required this.totalSessions,
    required this.totalInvoiceAmount,
    required this.totalPaidAmount,
    required this.outstandingAmount,
    required this.assessmentCount,
    this.whatsapp,
    this.latestProgressNote,
  });

  final int studentId;
  final String studentName;
  final String? whatsapp;
  final int totalSessions;
  final int totalInvoiceAmount;
  final int totalPaidAmount;
  final int outstandingAmount;
  final int assessmentCount;
  final String? latestProgressNote;
}

class ExportReportData {
  const ExportReportData({
    required this.title,
    required this.generatedAt,
    required this.filterLabel,
    required this.columns,
    required this.rows,
  });

  final String title;
  final DateTime generatedAt;
  final String filterLabel;
  final List<String> columns;
  final List<List<String>> rows;
}
