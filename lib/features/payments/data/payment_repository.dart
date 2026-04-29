import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/logging/app_logger.dart';

class InvoiceDetail {
  const InvoiceDetail({
    required this.invoice,
    required this.student,
    this.session,
  });

  final Invoice invoice;
  final Student student;
  final Session? session;

  int get remainingAmount => invoice.amount - invoice.paidAmount;
}

typedef InvoiceListItem = InvoiceDetail;

class PaymentFormData {
  const PaymentFormData({
    required this.invoiceId,
    required this.amount,
    required this.method,
    required this.paidAt,
    this.note,
  });

  final int invoiceId;
  final int amount;
  final String method;
  final DateTime paidAt;
  final String? note;
}

class PaymentRepository {
  const PaymentRepository(this._database, this._logger);

  final AppDatabase _database;
  final AppLogger _logger;

  Stream<List<InvoiceListItem>> watchUnpaidInvoices() {
    return watchInvoices(
      statusFilter: const [InvoiceStatus.unpaid, InvoiceStatus.partial],
    );
  }

  Stream<List<InvoiceListItem>> watchInvoices({List<String>? statusFilter}) {
    final query = _joinedInvoiceQuery()
      ..orderBy([
        OrderingTerm.desc(_database.invoices.createdAt),
        OrderingTerm.desc(_database.invoices.id),
      ]);
    if (statusFilter != null) {
      query.where(_database.invoices.status.isIn(statusFilter));
    }
    return query.watch().map(_mapRows);
  }

  Stream<InvoiceDetail?> watchInvoiceDetail(int invoiceId) {
    final query = _joinedInvoiceQuery()
      ..where(_database.invoices.id.equals(invoiceId));
    return query.watchSingleOrNull().map(_mapRowOrNull);
  }

  Stream<List<Payment>> watchPaymentHistory(int invoiceId) {
    final query = _database.select(_database.payments)
      ..where((payment) => payment.invoiceId.equals(invoiceId))
      ..where((payment) => payment.deletedAt.isNull())
      ..orderBy([
        (payment) => OrderingTerm.desc(payment.paidAt),
        (payment) => OrderingTerm.desc(payment.id),
      ]);
    return query.watch();
  }

  Stream<List<Payment>> watchStudentPaymentHistory(int studentId) {
    final query =
        (_database.select(_database.payments).join([
            innerJoin(
              _database.invoices,
              _database.invoices.id.equalsExp(_database.payments.invoiceId),
            ),
          ]))
          ..where(_database.invoices.studentId.equals(studentId))
          ..where(_database.invoices.deletedAt.isNull())
          ..where(_database.payments.deletedAt.isNull())
          ..orderBy([
            OrderingTerm.desc(_database.payments.paidAt),
            OrderingTerm.desc(_database.payments.id),
          ]);
    return query.watch().map(
      (rows) => rows
          .map((row) => row.readTable(_database.payments))
          .toList(growable: false),
    );
  }

  Future<int> insertPayment(PaymentFormData data) async {
    const action = 'payments.insertPayment';
    final logData = {
      'invoiceId': data.invoiceId,
      'amount': data.amount,
      'method': data.method,
      'paidAt': data.paidAt.toIso8601String(),
    };
    _logger.logTransactionStart(action, logData);
    try {
      _validate(data);

      final paymentId = await _database.transaction(() async {
        final invoice =
            await (_database.select(_database.invoices)
                  ..where((invoice) => invoice.id.equals(data.invoiceId))
                  ..where((invoice) => invoice.deletedAt.isNull()))
                .getSingleOrNull();
        if (invoice == null) {
          throw StateError('Invoice tidak ditemukan.');
        }
        if (invoice.status == InvoiceStatus.paid ||
            invoice.status == InvoiceStatus.cancelled) {
          throw StateError('Invoice sudah lunas atau dibatalkan.');
        }

        final remaining = invoice.amount - invoice.paidAmount;
        if (data.amount > remaining) {
          throw ArgumentError.value(
            data.amount,
            'amount',
            'Nominal melebihi sisa tagihan',
          );
        }

        final now = DateTime.now();
        final paymentId = await _database
            .into(_database.payments)
            .insert(
              PaymentsCompanion.insert(
                invoiceId: data.invoiceId,
                amount: Value(data.amount),
                method: Value(data.method),
                paidAt: data.paidAt,
                note: Value(_blankToNull(data.note)),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );

        final paidAmount = await _sumPaidAmount(data.invoiceId);
        final nextStatus = _invoiceStatusFor(invoice.amount, paidAmount);
        await (_database.update(
          _database.invoices,
        )..where((invoice) => invoice.id.equals(data.invoiceId))).write(
          InvoicesCompanion(
            paidAmount: Value(paidAmount),
            status: Value(nextStatus),
            updatedAt: Value(now),
          ),
        );

        return paymentId;
      });
      _logger.logTransactionSuccess(action, {
        ...logData,
        'paymentId': paymentId,
      });
      return paymentId;
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  JoinedSelectStatement<HasResultSet, dynamic> _joinedInvoiceQuery() {
    return (_database.select(_database.invoices).join([
        innerJoin(
          _database.students,
          _database.students.id.equalsExp(_database.invoices.studentId),
        ),
        leftOuterJoin(
          _database.sessions,
          _database.sessions.id.equalsExp(_database.invoices.sessionId),
        ),
      ]))
      ..where(_database.invoices.deletedAt.isNull())
      ..where(_database.students.deletedAt.isNull());
  }

  List<InvoiceListItem> _mapRows(List<TypedResult> rows) {
    return rows.map(_mapRow).toList(growable: false);
  }

  InvoiceDetail? _mapRowOrNull(TypedResult? row) {
    return row == null ? null : _mapRow(row);
  }

  InvoiceDetail _mapRow(TypedResult row) {
    return InvoiceDetail(
      invoice: row.readTable(_database.invoices),
      student: row.readTable(_database.students),
      session: row.readTableOrNull(_database.sessions),
    );
  }

  Future<int> _sumPaidAmount(int invoiceId) async {
    final total = _database.payments.amount.sum();
    final query = _database.selectOnly(_database.payments)
      ..addColumns([total])
      ..where(_database.payments.invoiceId.equals(invoiceId))
      ..where(_database.payments.deletedAt.isNull());
    final row = await query.getSingle();
    return row.read(total) ?? 0;
  }

  String _invoiceStatusFor(int amount, int paidAmount) {
    if (paidAmount <= 0) return InvoiceStatus.unpaid;
    if (paidAmount < amount) return InvoiceStatus.partial;
    return InvoiceStatus.paid;
  }

  void _validate(PaymentFormData data) {
    if (data.amount <= 0) {
      throw ArgumentError.value(
        data.amount,
        'amount',
        'Nominal pembayaran wajib lebih dari 0',
      );
    }
    const allowedMethods = {
      PaymentMethod.cash,
      PaymentMethod.transfer,
      PaymentMethod.ewallet,
      PaymentMethod.other,
    };
    if (!allowedMethods.contains(data.method)) {
      throw ArgumentError.value(
        data.method,
        'method',
        'Metode pembayaran tidak valid',
      );
    }
  }

  String? _blankToNull(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
