import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/app_back_scope.dart';
import '../providers/session_provider.dart';
import '../widgets/session_card.dart';
import '../widgets/session_empty_state.dart';

class SessionListScreen extends ConsumerWidget {
  const SessionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsState = ref.watch(sessionsProvider);

    return AppBackScope(
      fallbackPath: '/dashboard',
      child: Scaffold(
        appBar: AppBar(title: const Text('Riwayat sesi')),
        body: sessionsState.when(
          data: (sessions) {
            if (sessions.isEmpty) {
              return const SessionEmptyState();
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: sessions.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final detail = sessions[index];
                return SessionCard(
                  detail: detail,
                  onTap: () => context.go('/sessions/${detail.session.id}'),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Gagal memuat sesi: $error'),
            ),
          ),
        ),
      ),
    );
  }
}
