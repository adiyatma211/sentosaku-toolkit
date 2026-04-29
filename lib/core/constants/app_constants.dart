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
