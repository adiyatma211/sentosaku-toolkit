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

- Aplikasi Flutter offline-first dengan dashboard, siswa, jadwal, sesi, pembayaran, laporan, backup, restore, dan export MVP.
- Struktur feature-based yang konsisten.
- Database Drift stabil dengan relasi tabel utama.
- Provider Riverpod reactive untuk list/dashboard dan notifier untuk aksi form/transaksi.
- Semua proses penting menggunakan transaction agar data tidak setengah tersimpan.

## Urutan Eksekusi Sprint

| Sprint | Dokumen | Fokus | Boleh Mulai Jika |
|---|---|---|---|
| 01 | [Project Setup Database](implementation_01_project_setup_database.md) | Setup dependency, arsitektur folder, Drift schema awal, database provider, repository foundation, router, app shell, dashboard placeholder | Langsung mulai |
| 02 | [Students Module](implementation_02_students_module.md) | CRUD siswa, list, form, detail, soft delete/nonaktif | Sprint 01 selesai |
| 03 | [Schedules Module](implementation_03_schedules_module.md) | Subject, jadwal, recurring sederhana, filter tanggal, reminder placeholder, status jadwal | Sprint 02 selesai |
| 04 | [Sessions Module](implementation_04_sessions_module.md) | Sesi dari jadwal, transaction, update status jadwal, invoice per sesi jika perlu | Sprint 03 selesai |
| 05 | [Payments Module](implementation_05_payments_module.md) | Invoice, payment, pembayaran sebagian, update status invoice dalam transaction | Sprint 04 selesai |
| 06 | [Reports Module](implementation_06_reports_module.md) | Laporan pendapatan, unpaid, per siswa, filter, data preparation export | Sprint 05 selesai |
| 07 | [Backup Restore Export](implementation_07_backup_restore_export.md) | Backup DB, restore replace strategy, validasi file, export PDF/Excel | Sprint 06 selesai dan schema DB stabil |

## Alasan Urutan

- Sprint 01 wajib pertama karena semua modul membutuhkan database, provider, repository, routing, dan app shell.
- Sprint 02 mendahului jadwal karena jadwal wajib memilih siswa aktif.
- Sprint 03 mendahului sesi karena sesi adalah realisasi dari jadwal.
- Sprint 04 mendahului pembayaran karena invoice per sesi dapat dibuat saat sesi selesai.
- Sprint 05 mendahului laporan karena laporan pendapatan dan unpaid berasal dari invoice/payment final.
- Sprint 06 mendahului backup/export karena export laporan membutuhkan data report yang sudah siap.
- Sprint 07 dikerjakan terakhir agar backup/restore tidak sering berubah mengikuti migrasi schema awal.

## Dependency Antar Sprint

- `students` menjadi parent data untuk `subjects`, `schedules`, `sessions`, `invoices`, dan laporan per siswa.
- `subjects` dipakai jadwal, sesi, dan laporan per mata pelajaran.
- `schedules` dipakai sebagai sumber pembuatan `sessions`.
- `sessions` dapat memicu pembuatan `invoices` untuk tarif per sesi.
- `payments` selalu menempel ke `invoices` dan mengubah status invoice.
- `reports` membaca `students`, `subjects`, `schedules`, `sessions`, `invoices`, dan `payments`.
- `backup/restore` menyentuh file database sehingga harus menunggu tabel dan migration baseline stabil.

## Aturan Tidak Boleh Lompat

- [ ] Jangan implement Sprint 02 sebelum database provider, repository foundation, dan app shell Sprint 01 selesai.
- [ ] Jangan implement jadwal sebelum data siswa aktif bisa dibuat, diedit, dibaca, dan dinonaktifkan.
- [ ] Jangan implement sesi sebelum jadwal bisa difilter dan memiliki status.
- [ ] Jangan implement pembayaran sebelum invoice bisa dibuat dari sesi atau dibuat manual.
- [ ] Jangan implement laporan sebelum status invoice dan payment benar.
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
    ├── reports/
    └── backup/
```

## Definition of Done Global

- [ ] Semua fitur utama bisa berjalan tanpa internet.
- [ ] Data hanya diakses melalui Riverpod provider dan repository.
- [ ] Query list utama memakai stream Drift agar UI reactive.
- [ ] Aksi simpan/update/delete memakai notifier dengan state loading, success, error.
- [ ] Transaction dipakai untuk menyelesaikan sesi dan mencatat pembayaran.
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

## Acceptance Criteria

- [ ] Dokumen sprint menjadi sumber kerja utama bagi developer.
- [ ] Setiap sprint punya tujuan, prasyarat, output, struktur file, checklist, dan acceptance criteria.
- [ ] Urutan sprint jelas dan tidak ambigu.
- [ ] Dependency antar modul tercatat eksplisit.
- [ ] Scope MVP tidak melebar ke backend, cloud sync, login, atau payment gateway.
