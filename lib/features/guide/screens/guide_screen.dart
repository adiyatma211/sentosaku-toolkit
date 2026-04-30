import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/app_back_scope.dart';
import '../../../core/showcase/app_showcase.dart';

class GuideScreen extends ConsumerWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBackScope(
      fallbackPath: '/dashboard',
      child: Scaffold(
        appBar: AppBar(title: const Text('Panduan Pengguna')),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
          children: [
            _GuideHero(colorScheme: colorScheme),
            const SizedBox(height: 18),
            const _QuickFlowCard(),
            const SizedBox(height: 18),
            _InteractiveGuideCard(ref: ref),
            const SizedBox(height: 18),
            Text(
              'Panduan Per Modul',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            for (final section in _guideSections) ...[
              _ModuleGuideCard(section: section),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 8),
            const _TipsCard(),
          ],
        ),
      ),
    );
  }
}

class _InteractiveGuideCard extends StatelessWidget {
  const _InteractiveGuideCard({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.auto_stories_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Text(
                  'Panduan Interaktif',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Pilih modul untuk membuka halaman dan menampilkan sorotan langkah penggunaan langsung di layar.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _TourButton(
                  label: 'Dashboard Tour',
                  icon: Icons.dashboard_rounded,
                  path: '/dashboard',
                  tour: AppShowcaseTour.dashboard,
                  ref: ref,
                ),
                _TourButton(
                  label: 'Siswa Tour',
                  icon: Icons.groups_rounded,
                  path: '/students',
                  tour: AppShowcaseTour.students,
                  ref: ref,
                ),
                _TourButton(
                  label: 'Jadwal Tour',
                  icon: Icons.calendar_month_rounded,
                  path: '/schedules',
                  tour: AppShowcaseTour.schedules,
                  ref: ref,
                ),
                _TourButton(
                  label: 'Pembayaran Tour',
                  icon: Icons.payments_rounded,
                  path: '/payments',
                  tour: AppShowcaseTour.payments,
                  ref: ref,
                ),
                _TourButton(
                  label: 'Laporan Tour',
                  icon: Icons.analytics_rounded,
                  path: '/reports',
                  tour: AppShowcaseTour.reports,
                  ref: ref,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TourButton extends StatelessWidget {
  const _TourButton({
    required this.label,
    required this.icon,
    required this.path,
    required this.tour,
    required this.ref,
  });

  final String label;
  final IconData icon;
  final String path;
  final AppShowcaseTour tour;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: () {
        requestShowcaseTour(ref, tour);
        context.go(path);
      },
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}

class _GuideHero extends StatelessWidget {
  const _GuideHero({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colorScheme.primary, colorScheme.tertiary],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: .20),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -28,
            bottom: -36,
            child: Icon(
              Icons.menu_book_rounded,
              size: 142,
              color: Colors.white.withValues(alpha: .14),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .18),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Guide user baru',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Mulai Pakai Sentosaku TutorKit',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Ikuti urutan singkat ini untuk menyiapkan siswa, jadwal les, absen sesi, pembayaran, laporan, sampai backup data.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: .88),
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _HeroActionButton(
                    label: 'Tambah Siswa',
                    icon: Icons.person_add_alt_1_rounded,
                    onPressed: () => context.go('/students/new'),
                  ),
                  _HeroActionButton(
                    label: 'Buat Jadwal',
                    icon: Icons.calendar_month_rounded,
                    onPressed: () => context.go('/schedules/new'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroActionButton extends StatelessWidget {
  const _HeroActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: FilledButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class _QuickFlowCard extends StatelessWidget {
  const _QuickFlowCard();

  static const _steps = [
    'Tambah siswa beserta alamat lokasi les, subject utama, dan tarif.',
    'Buat jadwal les sesuai tanggal atau pola mingguan.',
    'Saat les selesai, klik FAB Absen atau buat sesi dari detail jadwal.',
    'Invoice otomatis dibuat jika siswa memakai tarif per sesi.',
    'Catat pembayaran dari menu Pembayaran, termasuk pembayaran sebagian.',
    'Lihat laporan pendapatan, outstanding, dan performa per siswa.',
    'Backup data secara rutin agar catatan aman.',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.route_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Text(
                  'Alur Cepat',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (var index = 0; index < _steps.length; index++)
              _NumberedStep(number: index + 1, text: _steps[index]),
          ],
        ),
      ),
    );
  }
}

class _NumberedStep extends StatelessWidget {
  const _NumberedStep({required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$number',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModuleGuideCard extends StatelessWidget {
  const _ModuleGuideCard({required this.section});

  final _GuideSection section;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer.withValues(alpha: .72),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(section.icon, color: colorScheme.primary),
        ),
        title: Text(
          section.title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
        subtitle: Text(section.summary),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          const SizedBox(height: 4),
          for (final item in section.points) _BulletItem(text: item),
          if (section.actions.isNotEmpty) ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final action in section.actions)
                    OutlinedButton.icon(
                      onPressed: () => context.go(action.path),
                      icon: Icon(action.icon, size: 18),
                      label: Text(action.label),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  const _BulletItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Icon(
              Icons.circle,
              size: 7,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _TipsCard extends StatelessWidget {
  const _TipsCard();

  static const _tips = [
    'Isi alamat siswa supaya lokasi les tampil jelas di jadwal dan detail siswa.',
    'Gunakan backup setelah input data penting atau sebelum pindah perangkat.',
    'Cek tagihan outstanding secara rutin agar pembayaran tidak terlewat.',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.tips_and_updates_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Text(
                  'Tips Penting',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final tip in _tips) _BulletItem(text: tip),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: () => context.go('/payments'),
                  icon: const Icon(Icons.receipt_long_rounded, size: 18),
                  label: const Text('Cek Tagihan'),
                ),
                FilledButton.tonalIcon(
                  onPressed: () => context.go('/backup'),
                  icon: const Icon(Icons.cloud_sync_rounded, size: 18),
                  label: const Text('Backup Data'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GuideSection {
  const _GuideSection({
    required this.title,
    required this.summary,
    required this.icon,
    required this.points,
    this.actions = const [],
  });

  final String title;
  final String summary;
  final IconData icon;
  final List<String> points;
  final List<_GuideAction> actions;
}

class _GuideAction {
  const _GuideAction({
    required this.label,
    required this.path,
    required this.icon,
  });

  final String label;
  final String path;
  final IconData icon;
}

const _guideSections = [
  _GuideSection(
    title: 'Dashboard',
    summary: 'Pantau kondisi les dari halaman utama.',
    icon: Icons.dashboard_rounded,
    points: [
      'Gunakan ringkasan untuk melihat siswa aktif, jadwal hari ini, sesi bulan ini, dan invoice belum dibayar.',
      'Lihat jadwal terdekat agar tahu murid, jam, subject, dan lokasi les berikutnya.',
      'Pakai FAB Absen saat les selesai untuk membuat sesi dari jadwal yang berjalan.',
      'Akses Cepat membuka modul utama seperti Siswa, Jadwal, Pembayaran, Laporan, Backup, dan Panduan.',
    ],
  ),
  _GuideSection(
    title: 'Siswa',
    summary: 'Simpan data murid sebelum membuat jadwal.',
    icon: Icons.groups_rounded,
    points: [
      'Tambah siswa baru, lalu lengkapi nama, kontak, alamat, subject utama, dan catatan penting.',
      'Alamat dipakai sebagai lokasi les, jadi isi sejelas mungkin untuk memudahkan kunjungan.',
      'Atur tarif siswa sesuai sistem pembayaran, terutama jika invoice dibuat per sesi.',
      'Edit data siswa jika ada perubahan alamat, subject, atau tarif.',
    ],
    actions: [
      _GuideAction(
        label: 'Tambah Siswa',
        path: '/students/new',
        icon: Icons.person_add_alt_1_rounded,
      ),
      _GuideAction(
        label: 'Daftar Siswa',
        path: '/students',
        icon: Icons.list_alt_rounded,
      ),
    ],
  ),
  _GuideSection(
    title: 'Jadwal',
    summary: 'Susun rencana les harian atau mingguan.',
    icon: Icons.calendar_month_rounded,
    points: [
      'Pilih tanggal, siswa, subject, jam mulai, dan jam selesai saat membuat jadwal.',
      'Gunakan jadwal mingguan jika pola les berulang setiap minggu.',
      'Buka detail jadwal untuk melihat informasi lengkap, membuat sesi, cancel, atau reschedule.',
      'Pastikan jadwal sudah benar sebelum les dimulai agar absen dan invoice tercatat rapi.',
    ],
    actions: [
      _GuideAction(
        label: 'Buat Jadwal',
        path: '/schedules/new',
        icon: Icons.add_rounded,
      ),
      _GuideAction(
        label: 'Lihat Jadwal',
        path: '/schedules',
        icon: Icons.event_note_rounded,
      ),
    ],
  ),
  _GuideSection(
    title: 'Sesi / Absen',
    summary: 'Catat hasil les setelah pertemuan selesai.',
    icon: Icons.fact_check_rounded,
    points: [
      'Isi kehadiran siswa, materi yang dibahas, PR, dan progress belajar.',
      'Buat sesi dari detail jadwal atau FAB Absen di dashboard saat les selesai.',
      'Setelah sesi tersimpan, jadwal akan menjadi catatan realisasi les.',
      'Jika siswa memakai tarif per sesi, invoice otomatis dibuat dari sesi tersebut.',
    ],
    actions: [
      _GuideAction(
        label: 'Daftar Sesi',
        path: '/sessions',
        icon: Icons.checklist_rounded,
      ),
    ],
  ),
  _GuideSection(
    title: 'Pembayaran',
    summary: 'Kelola invoice dan status pembayaran.',
    icon: Icons.payments_rounded,
    points: [
      'Buka daftar invoice untuk melihat tagihan paid, unpaid, dan outstanding.',
      'Catat pembayaran dari detail invoice saat orang tua atau siswa melakukan pembayaran.',
      'Partial payment bisa dipakai saat pembayaran baru sebagian.',
      'Periksa nominal dan tanggal pembayaran sebelum menyimpan agar laporan akurat.',
    ],
    actions: [
      _GuideAction(
        label: 'Buka Pembayaran',
        path: '/payments',
        icon: Icons.receipt_long_rounded,
      ),
    ],
  ),
  _GuideSection(
    title: 'Laporan',
    summary: 'Evaluasi pemasukan dan tagihan.',
    icon: Icons.bar_chart_rounded,
    points: [
      'Lihat pendapatan untuk memantau pemasukan dari sesi dan pembayaran.',
      'Gunakan laporan outstanding untuk mencari invoice yang belum lunas.',
      'Buka laporan per siswa untuk memahami aktivitas dan tagihan masing-masing murid.',
      'Gunakan export jika membutuhkan data untuk rekap atau administrasi di luar aplikasi.',
    ],
    actions: [
      _GuideAction(
        label: 'Lihat Laporan',
        path: '/reports',
        icon: Icons.analytics_rounded,
      ),
    ],
  ),
  _GuideSection(
    title: 'Backup / Restore',
    summary: 'Amankan data aplikasi secara rutin.',
    icon: Icons.cloud_sync_rounded,
    points: [
      'Lakukan backup rutin setelah menambah banyak data atau selesai mencatat pembayaran.',
      'Simpan file backup di lokasi aman agar bisa dipakai ketika pindah perangkat.',
      'Restore akan mengganti data aplikasi dengan isi file backup, jadi pastikan file yang dipilih benar.',
      'Jika ragu, buat backup baru terlebih dahulu sebelum melakukan restore.',
    ],
    actions: [
      _GuideAction(
        label: 'Backup Data',
        path: '/backup',
        icon: Icons.backup_rounded,
      ),
    ],
  ),
];
