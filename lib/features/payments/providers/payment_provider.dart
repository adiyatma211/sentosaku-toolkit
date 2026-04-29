import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/logging/logger_provider.dart';
import '../data/payment_repository.dart';

enum InvoiceListFilter { unpaid, all }

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  return PaymentRepository(
    ref.watch(databaseProvider),
    ref.watch(appLoggerProvider),
  );
});

final invoiceListFilterProvider =
    NotifierProvider<InvoiceListFilterNotifier, InvoiceListFilter>(
      InvoiceListFilterNotifier.new,
    );

class InvoiceListFilterNotifier extends Notifier<InvoiceListFilter> {
  @override
  InvoiceListFilter build() => InvoiceListFilter.unpaid;

  void setFilter(InvoiceListFilter filter) {
    state = filter;
  }
}

final unpaidInvoicesProvider = StreamProvider<List<InvoiceListItem>>((ref) {
  return ref.watch(paymentRepositoryProvider).watchUnpaidInvoices();
});

final invoicesProvider = StreamProvider<List<InvoiceListItem>>((ref) {
  final filter = ref.watch(invoiceListFilterProvider);
  final repository = ref.watch(paymentRepositoryProvider);
  return switch (filter) {
    InvoiceListFilter.unpaid => repository.watchUnpaidInvoices(),
    InvoiceListFilter.all => repository.watchInvoices(),
  };
});

final invoiceDetailProvider = StreamProvider.family<InvoiceDetail?, int>((
  ref,
  invoiceId,
) {
  return ref.watch(paymentRepositoryProvider).watchInvoiceDetail(invoiceId);
});

final paymentHistoryProvider = StreamProvider.family<List<Payment>, int>((
  ref,
  invoiceId,
) {
  return ref.watch(paymentRepositoryProvider).watchPaymentHistory(invoiceId);
});

final studentPaymentHistoryProvider = StreamProvider.family<List<Payment>, int>(
  (ref, studentId) {
    return ref
        .watch(paymentRepositoryProvider)
        .watchStudentPaymentHistory(studentId);
  },
);

final paymentFormNotifierProvider =
    AsyncNotifierProvider.autoDispose<PaymentFormNotifier, void>(
      PaymentFormNotifier.new,
    );

class PaymentFormNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<int> insertPayment(PaymentFormData data) async {
    state = const AsyncLoading();
    try {
      final id = await ref.read(paymentRepositoryProvider).insertPayment(data);
      state = const AsyncData(null);
      return id;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
