import 'package:drift/drift.dart';

import 'package:sentosa_catat_app/core/constants/app_constants.dart';
import 'package:sentosa_catat_app/core/database/app_database.dart';

DateTime dateOnly(int year, int month, int day) => DateTime(year, month, day);

DateTime timeOn(DateTime date, int hour, [int minute = 0]) {
  return DateTime(date.year, date.month, date.day, hour, minute);
}

Future<Student> seedStudent(
  AppDatabase database, {
  String name = 'Budi',
  String rateType = RateType.perSession,
  int rateAmount = 150000,
  String? whatsapp = '08123456789',
}) async {
  final now = DateTime(2026, 1, 1, 8);
  final id = await database
      .into(database.students)
      .insert(
        StudentsCompanion.insert(
          name: name,
          whatsapp: Value(whatsapp),
          rateType: Value(rateType),
          rateAmount: Value(rateAmount),
          status: const Value(StudentStatus.active),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
  return (database.select(
    database.students,
  )..where((t) => t.id.equals(id))).getSingle();
}

Future<Subject> seedSubject(
  AppDatabase database, {
  int? studentId,
  String name = 'Matematika',
  int defaultRateAmount = 150000,
}) async {
  final now = DateTime(2026, 1, 1, 8);
  final id = await database
      .into(database.subjects)
      .insert(
        SubjectsCompanion.insert(
          studentId: Value(studentId),
          name: name,
          defaultRateAmount: Value(defaultRateAmount),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
  return (database.select(
    database.subjects,
  )..where((t) => t.id.equals(id))).getSingle();
}

Future<Schedule> seedSchedule(
  AppDatabase database, {
  required int studentId,
  required int subjectId,
  required DateTime date,
  DateTime? startTime,
  DateTime? endTime,
  String status = ScheduleStatus.scheduled,
  String scheduleType = ScheduleType.once,
  String? recurrenceGroupId,
  bool reminderEnabled = false,
  String? note,
}) async {
  final now = DateTime(2026, 1, 1, 8);
  final start = startTime ?? timeOn(date, 9);
  final end = endTime ?? timeOn(date, 10);
  final id = await database
      .into(database.schedules)
      .insert(
        SchedulesCompanion.insert(
          studentId: studentId,
          subjectId: subjectId,
          date: date,
          startTime: start,
          endTime: end,
          scheduleType: Value(scheduleType),
          status: Value(status),
          recurrenceGroupId: Value(recurrenceGroupId),
          reminderEnabled: Value(reminderEnabled),
          note: Value(note),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
  return (database.select(
    database.schedules,
  )..where((t) => t.id.equals(id))).getSingle();
}

Future<Session> seedSession(
  AppDatabase database, {
  int? scheduleId,
  required int studentId,
  required int subjectId,
  required DateTime sessionDate,
  DateTime? startTime,
  DateTime? endTime,
  String attendanceStatus = AttendanceStatus.present,
  int feeAmount = 150000,
  int? invoiceId,
}) async {
  final now = DateTime(2026, 1, 1, 8);
  final start = startTime ?? timeOn(sessionDate, 9);
  final end = endTime ?? timeOn(sessionDate, 10);
  final id = await database
      .into(database.sessions)
      .insert(
        SessionsCompanion.insert(
          scheduleId: Value(scheduleId),
          studentId: studentId,
          subjectId: subjectId,
          sessionDate: Value(sessionDate),
          startTime: Value(start),
          endTime: Value(end),
          attendanceStatus: Value(attendanceStatus),
          feeAmount: Value(feeAmount),
          invoiceId: Value(invoiceId),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
  return (database.select(
    database.sessions,
  )..where((t) => t.id.equals(id))).getSingle();
}

Future<Invoice> seedInvoice(
  AppDatabase database, {
  required int studentId,
  int? sessionId,
  String periodLabel = 'April 2026',
  int amount = 150000,
  int paidAmount = 0,
  String status = InvoiceStatus.unpaid,
  DateTime? dueDate,
  DateTime? createdAt,
}) async {
  final now = createdAt ?? DateTime(2026, 4, 1, 8);
  final id = await database
      .into(database.invoices)
      .insert(
        InvoicesCompanion.insert(
          studentId: studentId,
          sessionId: Value(sessionId),
          periodLabel: Value(periodLabel),
          amount: Value(amount),
          paidAmount: Value(paidAmount),
          status: Value(status),
          dueDate: Value(dueDate),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
  return (database.select(
    database.invoices,
  )..where((t) => t.id.equals(id))).getSingle();
}

Future<Payment> seedPayment(
  AppDatabase database, {
  required int invoiceId,
  int amount = 50000,
  String method = PaymentMethod.cash,
  required DateTime paidAt,
  String? note,
}) async {
  final now = paidAt;
  final id = await database
      .into(database.payments)
      .insert(
        PaymentsCompanion.insert(
          invoiceId: invoiceId,
          amount: Value(amount),
          method: Value(method),
          paidAt: paidAt,
          note: Value(note),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
  return (database.select(
    database.payments,
  )..where((t) => t.id.equals(id))).getSingle();
}
