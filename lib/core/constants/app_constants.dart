abstract final class StudentStatus {
  static const pending = 'pending';
  static const active = 'active';
  static const inactive = 'inactive';
}

abstract final class ScheduleStatus {
  static const scheduled = 'scheduled';
  static const done = 'done';
  static const cancelled = 'cancelled';
  static const rescheduled = 'rescheduled';
  static const noShow = 'no_show';
}

abstract final class ScheduleType {
  static const once = 'once';
  static const weekly = 'weekly';
  static const custom = 'custom';
}

abstract final class AttendanceStatus {
  static const present = 'present';
  static const permission = 'permission';
  static const absent = 'absent';
  static const cancelled = 'cancelled';
  static const rescheduled = 'rescheduled';
}

abstract final class InvoiceStatus {
  static const unpaid = 'unpaid';
  static const partial = 'partial';
  static const paid = 'paid';
  static const cancelled = 'cancelled';
}

abstract final class RateType {
  static const perSession = 'per_session';
  static const monthly = 'monthly';
  static const package = 'package';
}

abstract final class PaymentMethod {
  static const cash = 'cash';
  static const transfer = 'transfer';
  static const ewallet = 'ewallet';
  static const other = 'other';
}

abstract final class AcademicPeriodType {
  static const semester = 'semester';
  static const custom = 'custom';
}

abstract final class StudentPeriodStatus {
  static const active = 'active';
  static const completed = 'completed';
  static const inactive = 'inactive';
}

abstract final class AssessmentType {
  static const session = 'session';
  static const reviewCycle = 'review_cycle';
}

abstract final class ProgressReportType {
  static const periodic = 'periodic';
  static const manual = 'manual';
}

abstract final class ProgressReportStatus {
  static const draft = 'draft';
  static const finalized = 'finalized';
  static const exported = 'exported';
}

abstract final class ReminderType {
  static const scheduleSession = 'schedule_session';
  static const invoiceDue = 'invoice_due';
}

abstract final class ReminderChannel {
  static const localNotification = 'local_notification';
}

abstract final class ReminderStatus {
  static const scheduled = 'scheduled';
  static const triggered = 'triggered';
  static const cancelled = 'cancelled';
  static const failed = 'failed';
}
