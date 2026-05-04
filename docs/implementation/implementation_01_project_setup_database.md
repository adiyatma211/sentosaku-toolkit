# Sprint 01 - Project Setup, Database, dan Fondasi Aplikasi

## Tujuan

Menyiapkan fondasi teknis aplikasi Flutter offline-first sebelum modul bisnis dibuat. Sprint ini fokus pada dependency, struktur folder, Drift database schema awal, provider database, repository foundation, router, app shell, dan dashboard placeholder.

## Dependency / Prasyarat

- Flutter project sudah tersedia.
- Belum ada modul bisnis yang bergantung ke data produksi.
- Mengikuti arsitektur `UI -> Riverpod Provider -> Repository -> Drift -> SQLite`.

## Output Akhir

- Dependency Riverpod, Drift, SQLite, routing, dan utilitas dasar siap.
- Folder feature-based tersedia.
- Database SQLite lokal bisa dibuka melalui Drift.
- Tabel awal tersedia untuk siswa, subject, periode akademik, assignment periode siswa, jadwal, sesi, assessment, invoice, payment, progress report, reminder log, settings, dan backup metadata.
- App shell dan dashboard placeholder bisa dibuka.

## Struktur File Yang Akan Dibuat

```text
lib/
├── main.dart
├── app/
│   ├── app.dart
│   └── router.dart
├── core/
│   ├── database/
│   │   ├── app_database.dart
│   │   ├── database_provider.dart
│   │   └── tables/
│   │       ├── students_table.dart
│   │       ├── subjects_table.dart
│   │       ├── academic_periods_table.dart
│   │       ├── student_periods_table.dart
│   │       ├── schedules_table.dart
│   │       ├── sessions_table.dart
│   │       ├── assessments_table.dart
│   │       ├── invoices_table.dart
│   │       ├── payments_table.dart
│   │       ├── progress_reports_table.dart
│   │       ├── reminder_rules_table.dart
│   │       ├── reminder_logs_table.dart
│   │       ├── settings_table.dart
│   │       └── backup_metadata_table.dart
│   ├── constants/
│   │   └── app_constants.dart
│   ├── helpers/
│   └── utils/
└── features/
    ├── dashboard/
    │   ├── data/dashboard_repository.dart
    │   ├── providers/dashboard_provider.dart
    │   └── screens/dashboard_screen.dart
    ├── students/
    ├── schedules/
    ├── sessions/
    ├── payments/
    ├── reports/
    └── backup/
```

## Dependency Pubspec Minimum

- `flutter_riverpod`: state management dan dependency injection.
- `riverpod_annotation`: optional jika memakai generator provider.
- `drift`: ORM SQLite lokal.
- `sqlite3_flutter_libs`: SQLite native library.
- `path_provider`: lokasi file database dan backup.
- `path`: path utility.
- `go_router`: routing app shell dan halaman feature.
- `intl`: format tanggal dan nominal uang.
- `build_runner`, `drift_dev`, `riverpod_generator`: dev dependency bila memakai code generation.

## Schema Database Awal

| Tabel | Fungsi | Field Kunci |
|---|---|---|
| `students` | Master siswa dan orang tua | `id`, `name`, `parent_name`, `whatsapp`, `school`, `grade`, `rate_type`, `rate_amount`, `status`, `default_academic_period_id`, `deleted_at` |
| `subjects` | Mata pelajaran per siswa/default | `id`, `student_id`, `name`, `default_rate_amount`, `is_active` |
| `academic_periods` | Master semester/periode belajar | `id`, `name`, `period_type`, `start_date`, `end_date`, `is_active`, `note` |
| `student_periods` | Assignment siswa ke periode akademik | `id`, `student_id`, `academic_period_id`, `enrolled_at`, `status`, `note` |
| `schedules` | Jadwal les | `id`, `student_id`, `subject_id`, `academic_period_id`, `date`, `start_time`, `end_time`, `schedule_type`, `status`, `recurrence_group_id`, `reminder_enabled`, `last_rescheduled_at` |
| `sessions` | Realisasi pertemuan | `id`, `schedule_id`, `student_id`, `subject_id`, `academic_period_id`, `attendance_status`, `material`, `homework`, `progress_note`, `fee_amount`, `is_attendance_source`, `invoice_id` |
| `assessments` | Penilaian terstruktur per sesi atau review cycle | `id`, `session_id`, `student_id`, `academic_period_id`, `assessment_type`, `review_cycle_label`, `pemahaman_materi`, `keaktifan_tanya_jawab`, `ketepatan_kerapian_tugas`, `konsistensi_kehadiran_fokus`, `target_materi_drilling`, `sikap_belajar_respon`, `summary_note` |
| `invoices` | Tagihan | `id`, `student_id`, `session_id`, `academic_period_id`, `period_label`, `amount`, `paid_amount`, `status`, `due_date`, `last_reminded_at` |
| `payments` | Pembayaran tagihan | `id`, `invoice_id`, `amount`, `method`, `paid_at`, `note` |
| `progress_reports` | Ringkasan perkembangan siswa per periode | `id`, `student_id`, `academic_period_id`, `report_type`, `generated_at`, `attendance_summary_json`, `assessment_summary_json`, `teacher_note`, `status` |
| `reminder_rules` | Konfigurasi reminder lokal | `id`, `reminder_type`, `offset_minutes`, `days_before_due`, `is_enabled`, `channel` |
| `reminder_logs` | Audit reminder yang sudah dijadwalkan/ditembakkan | `id`, `reminder_type`, `reference_table`, `reference_id`, `scheduled_at`, `triggered_at`, `status`, `payload_json` |
| `settings` | Profil guru dan konfigurasi | `key`, `value`, `updated_at` |
| `backup_metadata` | Riwayat backup lokal | `id`, `file_name`, `file_path`, `created_at` |

## Urutan Implementasi / Checklist

- [ ] Tambahkan dependency runtime dan dev dependency ke `pubspec.yaml`.
- [ ] Jalankan package get dan pastikan dependency resolve.
- [ ] Buat struktur folder `app`, `core`, dan `features`.
- [ ] Bungkus aplikasi dengan `ProviderScope` di `main.dart`.
- [ ] Buat `App` root widget dan konfigurasi tema dasar.
- [ ] Buat `router.dart` dengan route dashboard dan placeholder route modul.
- [ ] Buat tabel Drift awal di `core/database/tables`.
- [ ] Buat `AppDatabase` dengan daftar tabel dan `schemaVersion` awal.
- [ ] Buat `databaseProvider` untuk menyediakan instance database.
- [ ] Tetapkan relasi dasar `students -> student_periods -> academic_periods` dan pastikan histori periode tidak bergantung pada field mutable tunggal.
- [ ] Siapkan indeks dasar untuk query `academic_period_id`, `student_id`, `schedule_id`, `session_id`, dan `due_date`.
- [ ] Buat repository foundation untuk dashboard.
- [ ] Buat `dashboardSummaryProvider` placeholder yang membaca repository.
- [ ] Buat `DashboardScreen` placeholder berisi ringkasan kosong: siswa aktif, jadwal hari ini, pendapatan bulan ini, tagihan belum dibayar, reminder hari ini, dan periode aktif.
- [ ] Siapkan enum/status sebagai konstanta string untuk `student_status`, `schedule_status`, `attendance_status`, `invoice_status`, `academic_period_status`, `assessment_type`, dan `reminder_status`.
- [ ] Pastikan semua screen placeholder tidak mengakses database langsung.

## Aturan Implementasi

- Simpan tanggal sebagai `DateTime` atau integer timestamp secara konsisten.
- Simpan uang sebagai integer minor unit rupiah tanpa desimal.
- Gunakan `created_at`, `updated_at`, dan `deleted_at` untuk tabel bisnis utama.
- Gunakan soft delete untuk data yang memiliki riwayat.
- Simpan field agregat besar seperti ringkasan progress report dalam JSON text hanya jika turunan dari data utama dan tetap bisa diregenerasi.
- Reminder tetap offline-first: aturan dan log disimpan lokal, tanpa ketergantungan backend.
- Jangan membuat cloud sync field kecuali memang disiapkan eksplisit untuk masa depan.

## Acceptance Criteria

- [ ] Aplikasi bisa start sampai dashboard placeholder.
- [ ] Database SQLite lokal berhasil dibuat di perangkat/emulator.
- [ ] `databaseProvider` dapat diakses dari provider/repository.
- [ ] Semua tabel awal terdaftar di `AppDatabase`.
- [ ] Struktur folder sudah siap untuk Sprint 02 sampai Sprint 08.
- [ ] Tidak ada screen yang melakukan query Drift langsung.
