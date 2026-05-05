import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/feedback/app_toast.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../providers/academic_period_provider.dart';
import '../widgets/academic_period_chip.dart';

class AcademicPeriodListScreen extends ConsumerWidget {
  const AcademicPeriodListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final periodsState = ref.watch(academicPeriodsProvider);
    return AppBackScope(
      fallbackPath: '/dashboard',
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/dashboard'),
          ),
          title: const Text('Periode akademik'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.go('/academic-periods/new'),
          icon: const Icon(Icons.add),
          label: const Text('Tambah'),
        ),
        body: periodsState.when(
          data: (periods) {
            if (periods.isEmpty) {
              return const Center(child: Text('Belum ada periode akademik.'));
            }
            final dateFormat = DateFormat('d MMM yyyy');
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              itemBuilder: (context, index) {
                final period = periods[index];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(period.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        AcademicPeriodChip(period: period),
                        const SizedBox(height: 8),
                        Text(
                          '${dateFormat.format(period.startDate)} - ${dateFormat.format(period.endDate)}',
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'edit') {
                          context.go('/academic-periods/${period.id}/edit');
                          return;
                        }
                        if (value == 'activate') {
                          try {
                            await ref
                                .read(
                                  academicPeriodFormNotifierProvider.notifier,
                                )
                                .setActive(period.id);
                          } catch (error) {
                            if (!context.mounted) return;
                            AppToast.error(
                              context,
                              'Gagal mengaktifkan periode',
                              details: '$error',
                            );
                          }
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        if (!period.isActive)
                          const PopupMenuItem(
                            value: 'activate',
                            child: Text('Set aktif'),
                          ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: periods.length,
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) =>
              Center(child: Text('Gagal memuat periode: $error')),
        ),
      ),
    );
  }
}
