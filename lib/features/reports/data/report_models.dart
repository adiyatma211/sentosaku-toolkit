enum ReportFilterType { today, week, month, custom }

class ReportFilter {
  const ReportFilter({
    required this.startDate,
    required this.endDate,
    required this.filterType,
    this.studentId,
    this.subjectId,
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
    bool clearStudent = false,
    bool clearSubject = false,
  }) {
    return ReportFilter(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      filterType: filterType ?? this.filterType,
      studentId: clearStudent ? null : studentId ?? this.studentId,
      subjectId: clearSubject ? null : subjectId ?? this.subjectId,
    );
  }

  final DateTime startDate;
  final DateTime endDate;
  final int? studentId;
  final int? subjectId;
  final ReportFilterType filterType;
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
    this.whatsapp,
  });

  final int studentId;
  final String studentName;
  final String? whatsapp;
  final int totalSessions;
  final int totalInvoiceAmount;
  final int totalPaidAmount;
  final int outstandingAmount;
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
