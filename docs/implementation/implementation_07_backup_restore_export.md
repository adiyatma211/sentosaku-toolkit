# Sprint 07 - Backup, Restore, dan Export

## Tujuan

Membuat modul backup, restore, dan export setelah database dan laporan stabil. Sprint ini memastikan data offline lebih aman, bisa dipindahkan manual, dan laporan bisa dibagikan dalam format PDF/Excel.

## Dependency / Prasyarat

- Sprint 01 sampai Sprint 06 selesai.
- Schema database MVP sudah stabil.
- Laporan sudah punya data preparation dari `ReportRepository`.
- Strategi lokasi file database Drift sudah jelas.

## Output Akhir

- Guru bisa membuat backup file database dengan nama bertanggal.
- Guru bisa restore database dengan strategi replace setelah validasi dan konfirmasi.
- Aplikasi bisa membuka ulang database setelah restore.
- Guru bisa export laporan PDF/Excel dari data laporan.
- Metadata backup terakhir bisa ditampilkan untuk reminder backup.

## Struktur File Yang Akan Dibuat

```text
lib/features/backup/
├── data/
│   └── backup_repository.dart
├── providers/
│   └── backup_provider.dart
├── screens/
│   └── backup_restore_screen.dart
└── widgets/
    ├── backup_status_card.dart
    └── backup_history_tile.dart

lib/features/reports/
├── data/
│   └── export_service.dart
└── providers/
    └── export_report_provider.dart
```

## Provider Yang Dibuat

- `backupRepositoryProvider`.
- `backupNotifierProvider` untuk proses backup.
- `restoreNotifierProvider` untuk proses restore.
- `lastBackupProvider` untuk warning backup berkala.
- `exportReportNotifierProvider` untuk export PDF/Excel.

## Strategi Backup Database

- Backup dilakukan dengan menyalin file SQLite utama ke lokasi yang dipilih/diizinkan.
- Nama file wajib memuat tanggal, contoh `backup_private_teacher_2026-04-29.db`.
- Jika menggunakan WAL SQLite, pastikan database checkpoint/close aman sebelum file disalin atau gunakan API backup yang konsisten.
- Simpan metadata backup terakhir ke `backup_metadata` atau settings.
- Backup harus bisa dilakukan tanpa internet.

## Strategi Restore Replace

- User memilih file backup.
- Sistem validasi ekstensi, ukuran file, dan minimal bisa dibuka sebagai SQLite.
- Sistem menampilkan konfirmasi bahwa data lokal saat ini akan diganti.
- Aplikasi menutup koneksi database sementara.
- File database lama diganti dengan file backup.
- Database dibuka ulang.
- Provider yang bergantung ke database di-refresh.
- Dashboard dan screen utama membaca data hasil restore.

## Strategi Export

- Export tidak boleh query langsung dari widget.
- UI meminta data ke `ReportRepository.getExportData(filter)`.
- `ExportService` menerima data siap pakai dan membuat PDF/Excel.
- PDF berisi ringkasan rapi untuk dibagikan.
- Excel berisi data tabular mentah untuk diolah lagi.
- Nama file memuat jenis laporan dan periode, contoh `laporan_pendapatan_2026-04.xlsx`.

## Urutan Implementasi / Checklist

- [ ] Buat `BackupRepository.getDatabaseFile()` sesuai lokasi database Drift.
- [ ] Buat `BackupRepository.backupDatabase()` untuk menyalin database ke file backup.
- [ ] Tambahkan penamaan file backup bertanggal.
- [ ] Simpan metadata backup terakhir.
- [ ] Buat `BackupRestoreScreen` dengan status backup terakhir.
- [ ] Buat aksi backup dengan state loading, success, dan error.
- [ ] Buat validasi file restore: ekstensi, file exists, ukuran, dan bisa dibuka sebagai SQLite.
- [ ] Buat dialog konfirmasi restore yang menjelaskan data lama akan diganti.
- [ ] Implement restore dengan close database, replace file, reopen database, dan refresh provider.
- [ ] Buat error handling restore agar aplikasi tidak kehilangan database lama jika file backup invalid.
- [ ] Buat `ExportService` untuk PDF dan Excel.
- [ ] Hubungkan export dengan data preparation dari Sprint 06.
- [ ] Buat export pendapatan dan unpaid report minimal.
- [ ] Tambahkan warning backup jika backup terakhir lebih dari 7 hari.

## Validasi dan Error Handling

- [ ] Backup gagal harus menampilkan alasan, misalnya storage tidak tersedia atau permission ditolak.
- [ ] Restore invalid tidak boleh menghapus database lama.
- [ ] Restore harus meminta konfirmasi eksplisit.
- [ ] Jika reopen database gagal, aplikasi harus menampilkan error yang bisa dipahami.
- [ ] Export gagal harus menjaga data laporan tetap tampil.

## Acceptance Criteria

- [ ] Guru bisa membuat file backup database offline.
- [ ] File backup punya nama jelas dan bertanggal.
- [ ] Metadata backup terakhir tampil di screen backup.
- [ ] Restore menolak file invalid.
- [ ] Restore berhasil mengganti data lokal dan dashboard membaca data hasil restore.
- [ ] Export PDF/Excel bisa dibuat dari data laporan.
- [ ] Tidak ada proses backup/restore/export yang mengharuskan internet.
