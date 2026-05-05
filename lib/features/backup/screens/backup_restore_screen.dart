import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/feedback/app_toast.dart';
import '../../../core/navigation/app_back_scope.dart';
import '../providers/backup_provider.dart';
import '../widgets/backup_history_tile.dart';
import '../widgets/backup_status_card.dart';

class BackupRestoreScreen extends ConsumerStatefulWidget {
  const BackupRestoreScreen({super.key});

  @override
  ConsumerState<BackupRestoreScreen> createState() =>
      _BackupRestoreScreenState();
}

class _BackupRestoreScreenState extends ConsumerState<BackupRestoreScreen> {
  final _restorePathController = TextEditingController();

  @override
  void dispose() {
    _restorePathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backupStatusState = ref.watch(backupStatusProvider);
    final historyState = ref.watch(backupHistoryProvider);
    final backupState = ref.watch(backupNotifierProvider);
    final restoreState = ref.watch(restoreNotifierProvider);
    final isBusy = backupState.isLoading || restoreState.isLoading;

    return AppBackScope(
      fallbackPath: '/dashboard',
      child: Scaffold(
        appBar: AppBar(title: const Text('Backup & Restore')),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(lastBackupProvider);
            ref.invalidate(backupStatusProvider);
            ref.invalidate(backupHistoryProvider);
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              backupStatusState.when(
                data: (status) => BackupStatusCard(status: status),
                loading: () => const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: LinearProgressIndicator(),
                  ),
                ),
                error: (error, stackTrace) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Gagal memuat status backup: $error'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: isBusy ? null : _createBackup,
                icon: backupState.isLoading
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.backup),
                label: const Text('Backup Data'),
              ),
              const SizedBox(height: 24),
              Text('Restore', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              TextField(
                controller: _restorePathController,
                decoration: InputDecoration(
                  labelText: 'Path file .db/.sqlite',
                  helperText: 'Pilih file backup atau isi path manual.',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    tooltip: 'Pilih file',
                    onPressed: isBusy ? null : _pickRestoreFile,
                    icon: const Icon(Icons.folder_open),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FilledButton.tonalIcon(
                onPressed: isBusy ? null : _confirmRestore,
                icon: restoreState.isLoading
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.restore),
                label: const Text('Restore Database'),
              ),
              const SizedBox(height: 24),
              Text(
                'Riwayat Backup',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              historyState.when(
                data: (items) => items.isEmpty
                    ? const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('Belum ada riwayat backup.'),
                        ),
                      )
                    : Column(
                        children: items
                            .map((backup) => BackupHistoryTile(backup: backup))
                            .toList(growable: false),
                      ),
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, stackTrace) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Gagal memuat riwayat backup: $error'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createBackup() async {
    try {
      final backup = await ref
          .read(backupNotifierProvider.notifier)
          .createBackup();
      if (!mounted) return;
      AppToast.success(
        context,
        'Backup berhasil disimpan',
        details: backup.filePath,
      );
    } catch (error) {
      if (!mounted) return;
      AppToast.error(context, 'Backup gagal', details: '$error');
    }
  }

  Future<void> _pickRestoreFile() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['db', 'sqlite'],
    );
    final path = result?.files.single.path;
    if (path == null) return;
    _restorePathController.text = path;
  }

  Future<void> _confirmRestore() async {
    final path = _restorePathController.text.trim();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restore database?'),
        content: const Text(
          'Data lokal saat ini akan diganti dengan file backup yang dipilih. File akan divalidasi, database aktif ditutup sementara, dan safety backup dibuat sebelum data diganti.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Restore'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await ref.read(restoreNotifierProvider.notifier).restore(path);
      if (!mounted) return;
      AppToast.success(
        context,
        'Restore berhasil',
        details: 'Data akan dimuat ulang otomatis.',
      );
    } catch (error) {
      if (!mounted) return;
      AppToast.error(context, 'Restore gagal', details: '$error');
    }
  }
}
