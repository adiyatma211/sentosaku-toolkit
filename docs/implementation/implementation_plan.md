# Implementation Plan Aplikasi Guru Private Offline

## Tujuan

Dokumen ini menjadi dokumen induk implementasi MVP aplikasi guru private offline berbasis Flutter, Riverpod, Drift, dan SQLite. Fokusnya adalah memastikan development berjalan berurutan dari fondasi database sampai backup/export tanpa lompat modul.

## Dependency / Prasyarat

- Workflow aplikasi sudah mengacu ke `../work-flow/workflow_aplikasi_guru_private_offline.md`.
- Workflow arsitektur sudah mengacu ke `../work-flow/workflow_state_management_riverpod_drift.md`.
- MVP tidak memakai backend, login, cloud sync, payment gateway, atau portal orang tua.
- Semua data utama wajib offline di SQLite lokal.
- UI tidak boleh akses database langsung; akses data harus melalui `Provider -> Repository -> Drift`.

## Output Akhir

- Aplikasi Flutter offline-first dengan dashboard, siswa, periode akademik, jadwal, sesi, assessment, pembayaran, laporan, backup, restore, dan export MVP yang diperluas.
- Struktur feature-based yang konsisten.
- Database Drift stabil dengan relasi tabel utama termasuk periodisasi, assessment, progress report, dan reminder log.
- Provider Riverpod reactive untuk list/dashboard dan notifier untuk aksi form/transaksi.
- Semua proses penting menggunakan transaction agar data tidak setengah tersimpan.

## Urutan Eksekusi Sprint

| Sprint | Dokumen | Fokus | Boleh Mulai Jika |
|---|---|---|---|
| 01 | [Project Setup Database](implementation_01_project_setup_database.md) | Setup dependency, arsitektur folder, Drift schema awal, database provider, repository foundation, router, app shell, dashboard placeholder, dan baseline tabel periodisasi/assessment/reminder | Langsung mulai |
| 02 | [Students Module](implementation_02_students_module.md) | CRUD siswa, list, form, detail, soft delete/nonaktif | Sprint 01 selesai |
| 03 | [Schedules Module](implementation_03_schedules_module.md) | Subject, jadwal, recurring sederhana, filter tanggal, reminder sesi, aturan reschedule, status jadwal | Sprint 02 selesai |
| 04 | [Sessions Module](implementation_04_sessions_module.md) | Sesi dari jadwal, transaction, absensi, assessment terstruktur, sumber data rekap kehadiran, invoice per sesi jika perlu | Sprint 03 selesai |
| 05 | [Payments Module](implementation_05_payments_module.md) | Invoice, payment, pembayaran sebagian, due date, reminder invoice, update status invoice dalam transaction | Sprint 04 selesai |
| 06 | [Academic Period, Assessment, dan Progress](implementation_08_academic_period_assessment_progress.md) | Master periode akademik/semester, assignment ke siswa dan jadwal, review cycle assessment, progress report per siswa per periode | Sprint 04 selesai, schema Sprint 01 siap, dan data siswa/sesi sudah stabil |
| 07 | [Reports Module](implementation_06_reports_module.md) | Laporan pendapatan, unpaid, rekap kehadiran, laporan per siswa, filter semester/periode, data preparation export | Sprint 05 dan Sprint 06 selesai |
| 08 | [Backup Restore Export](implementation_07_backup_restore_export.md) | Backup DB, restore replace strategy, validasi file, export PDF/Excel untuk laporan pendapatan, rekap kehadiran, dan progress report | Sprint 07 selesai dan schema DB stabil |

## Alasan Urutan

- Sprint 01 wajib pertama karena semua modul membutuhkan database, provider, repository, routing, dan app shell.
- Sprint 02 mendahului jadwal karena jadwal wajib memilih siswa aktif.
- Sprint 03 mendahului sesi karena sesi adalah realisasi dari jadwal dan reminder reschedule harus sudah punya sumber data jadwal final.
- Sprint 04 mendahului pembayaran karena invoice per sesi dan rekap kehadiran sama-sama lahir dari data sesi final.
- Sprint 05 mendahului laporan keuangan karena unpaid, due date, dan reminder invoice berasal dari invoice/payment final.
- Sprint 06 dikerjakan setelah sesi stabil karena progress report dan assignment periode membutuhkan data assessment dan absensi yang sudah konsisten.
- Sprint 07 dikerjakan setelah Sprint 05 dan Sprint 06 karena laporan semester/periode membaca pembayaran sekaligus perkembangan belajar.
- Sprint 08 dikerjakan terakhir agar backup/restore dan export tidak sering berubah mengikuti migrasi schema modul baru.

## Dependency Antar Sprint

- `students` menjadi parent data untuk `subjects`, `schedules`, `sessions`, `invoices`, dan laporan per siswa.
- `academic_periods` menjadi parent filter untuk `student_periods`, `schedules`, `sessions`, `invoices`, `attendance recap`, dan `progress reports`.
- `student_periods` menjadi relasi assignment siswa per periode agar histori semester tidak menimpa data siswa aktif.
- `subjects` dipakai jadwal, sesi, dan laporan per mata pelajaran.
- `schedules` dipakai sebagai sumber pembuatan `sessions`.
- `sessions` menjadi source of truth absensi, assessment, dan dapat memicu pembuatan `invoices` untuk tarif per sesi.
- `assessments` bergantung pada `sessions` atau `review_cycles` agar penilaian bisa dibuat per sesi atau per siklus review.
- `payments` selalu menempel ke `invoices` dan mengubah status invoice.
- `reminder_rules` dan `reminder_logs` membaca `schedules` serta `invoices`, tetapi tidak boleh menjadi sumber data bisnis utama.
- `progress_reports` membaca `students`, `academic_periods`, `sessions`, `assessments`, `invoices`, dan `payments` untuk ringkasan progres dan administrasi.
- `reports` membaca `students`, `subjects`, `academic_periods`, `schedules`, `sessions`, `assessments`, `invoices`, dan `payments`.
- `backup/restore` menyentuh file database sehingga harus menunggu tabel dan migration baseline stabil.

## Aturan Tidak Boleh Lompat

- [ ] Jangan implement Sprint 02 sebelum database provider, repository foundation, dan app shell Sprint 01 selesai.
- [ ] Jangan implement jadwal sebelum data siswa aktif bisa dibuat, diedit, dibaca, dan dinonaktifkan.
- [ ] Jangan implement sesi sebelum jadwal bisa difilter dan memiliki status.
- [ ] Jangan implement progress report sebelum assessment terstruktur dan assignment periode tersedia.
- [ ] Jangan implement pembayaran sebelum invoice bisa dibuat dari sesi atau dibuat manual.
- [ ] Jangan implement laporan semester/periode sebelum assignment `academic_period` pada siswa/jadwal/sesi jelas.
- [ ] Jangan implement laporan sebelum status invoice, payment, dan rekap kehadiran benar.
- [ ] Jangan implement restore database sebelum strategi tutup/buka ulang database ditetapkan.
- [ ] Jangan membuat UI melakukan query Drift langsung.
- [ ] Jangan hard delete data penting seperti siswa jika data itu sudah direferensikan jadwal/sesi/pembayaran.

## Struktur File Yang Akan Dibuat Secara Global

```text
lib/
├── app/
│   ├── app.dart
│   └── router.dart
├── core/
│   ├── database/
│   │   ├── app_database.dart
│   │   ├── database_provider.dart
│   │   └── tables/
│   ├── constants/
│   ├── helpers/
│   └── utils/
└── features/
    ├── dashboard/
    ├── students/
    ├── schedules/
    ├── sessions/
    ├── payments/
    ├── academic/
    ├── reports/
    └── backup/
```

## Definition of Done Global

- [ ] Semua fitur utama bisa berjalan tanpa internet.
- [ ] Data hanya diakses melalui Riverpod provider dan repository.
- [ ] Query list utama memakai stream Drift agar UI reactive.
- [ ] Aksi simpan/update/delete memakai notifier dengan state loading, success, error.
- [ ] Transaction dipakai untuk menyelesaikan sesi dan mencatat pembayaran.
- [ ] Assignment periode akademik tidak merusak histori semester sebelumnya.
- [ ] Rekap kehadiran selalu dihitung dari data sesi, bukan input manual terpisah.
- [ ] Progress report bisa dibentuk dari data assessment terstruktur dan catatan guru.
- [ ] Validasi form minimal tersedia sebelum data masuk database.
- [ ] Empty state, loading state, error state, dan success feedback tersedia di screen utama.
- [ ] Tidak ada hard delete untuk data yang punya riwayat bisnis.
- [ ] Dashboard membaca ringkasan dari repository, bukan menghitung langsung di widget.
- [ ] Laporan membaca data dari database lokal dan dapat disiapkan untuk export.
- [ ] Backup database dapat dibuat dengan nama file bertanggal.
- [ ] Restore database meminta konfirmasi dan memvalidasi file sebelum replace.

## Checklist Induk

- [ ] Sprint 01 selesai dan diverifikasi.
- [ ] Sprint 02 selesai dan diverifikasi.
- [ ] Sprint 03 selesai dan diverifikasi.
- [ ] Sprint 04 selesai dan diverifikasi.
- [ ] Sprint 05 selesai dan diverifikasi.
- [ ] Sprint 06 selesai dan diverifikasi.
- [ ] Sprint 07 selesai dan diverifikasi.
- [ ] Sprint 08 selesai dan diverifikasi.

## Acceptance Criteria

- [ ] Dokumen sprint menjadi sumber kerja utama bagi developer.
- [ ] Setiap sprint punya tujuan, prasyarat, output, struktur file, checklist, dan acceptance criteria.
- [ ] Urutan sprint jelas dan tidak ambigu.
- [ ] Dependency antar modul tercatat eksplisit.
- [ ] Dependensi periodisasi, assessment, reminder, dan progress report tercatat praktis.
- [ ] Scope MVP tidak melebar ke backend, cloud sync, login, atau payment gateway.
