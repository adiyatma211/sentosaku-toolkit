# Sprint 07 - Reports Module

## Tujuan

Membuat modul laporan setelah data pembayaran, periodisasi, dan assessment stabil. Modul ini mencakup laporan pendapatan, tagihan belum dibayar, laporan per siswa, rekap kehadiran, filter semester/periode, dan persiapan data export untuk Sprint 08.

## Dependency / Prasyarat

- Sprint 01 sampai Sprint 06 selesai.
- Invoice dan payment status sudah akurat.
- Assignment periode akademik pada siswa/jadwal/sesi sudah konsisten.
- Data siswa, subject, jadwal, sesi, assessment, invoice, dan payment bisa dibaca dari repository.

## Output Akhir

- Guru bisa melihat total pendapatan berdasarkan periode.
- Guru bisa melihat daftar tagihan belum dibayar.
- Guru bisa melihat performa pembayaran per siswa.
- Guru bisa melihat rekap kehadiran per siswa/periode.
- Guru bisa memfilter laporan berdasarkan semester atau periode akademik.
- Data laporan siap dikirim ke export PDF/Excel tanpa query ulang di UI.

## Struktur File Yang Akan Dibuat

```text
lib/features/reports/
├── data/
│   ├── report_repository.dart
│   └── report_models.dart
├── providers/
│   └── report_provider.dart
├── screens/
│   ├── report_screen.dart
│   ├── income_report_screen.dart
│   ├── unpaid_report_screen.dart
│   ├── attendance_report_screen.dart
│   └── student_report_screen.dart
└── widgets/
    ├── report_filter_bar.dart
    ├── report_summary_card.dart
    ├── unpaid_invoice_tile.dart
    └── student_report_tile.dart
```

## Jenis Laporan MVP

| Laporan | Sumber Data | Output |
|---|---|---|
| Pendapatan | `payments` join `invoices` join `students` | Total pembayaran diterima per periode |
| Tagihan belum dibayar | `invoices` status `unpaid`/`partial` | Total outstanding dan daftar siswa |
| Per siswa | `students`, `sessions`, `assessments`, `invoices`, `payments` | Total sesi, total tagihan, total bayar, sisa tagihan, ringkasan progres |
| Rekap kehadiran | `sessions` | Jumlah hadir, izin, tidak hadir, batal, reschedule per siswa/periode |
| Ringkasan sesi | `sessions` | Jumlah sesi selesai per periode |

## Provider Yang Dibuat

- `reportRepositoryProvider`.
- `reportFilterProvider` untuk periode dan filter siswa.
- `incomeReportProvider(filter)`.
- `unpaidReportProvider`.
- `attendanceReportProvider(filter)`.
- `studentReportProvider(filter)`.
- `exportReportDataProvider(filter)` untuk persiapan Sprint 08.

## Filter Laporan

- Hari ini.
- Minggu ini.
- Bulan ini.
- Semester/periode akademik.
- Custom tanggal.
- Per siswa.
- Per mata pelajaran jika subject sudah cukup stabil.
- Belum dibayar.

## Urutan Implementasi / Checklist

- [ ] Buat model data laporan sederhana di `report_models.dart`.
- [ ] Buat `ReportFilter` berisi `startDate`, `endDate`, `studentId`, `subjectId`, dan tipe filter.
- [ ] Tambahkan `academicPeriodId` dan `includeAttendanceRecap` pada `ReportFilter`.
- [ ] Buat `ReportRepository.getIncomeReport(filter)` dari tabel `payments`.
- [ ] Buat query total pendapatan yang hanya menghitung pembayaran yang benar-benar diterima.
- [ ] Buat `ReportRepository.getUnpaidReport()` dari invoice `unpaid` dan `partial`.
- [ ] Buat `ReportRepository.getAttendanceReport(filter)` dari tabel `sessions` sebagai sumber data tunggal rekap kehadiran.
- [ ] Buat `ReportRepository.getStudentReport(filter)` untuk total sesi, assessment, invoice, payment, dan outstanding per siswa.
- [ ] Buat `ReportRepository.getExportData(filter)` yang mengembalikan data tabular siap export.
- [ ] Buat provider filter dan provider laporan.
- [ ] Buat `ReportScreen` sebagai entry point laporan.
- [ ] Buat filter bar dengan periode hari ini, minggu ini, bulan ini, semester/periode, dan custom.
- [ ] Buat tampilan summary card: total pendapatan, total tagihan, outstanding, jumlah sesi selesai, rekap kehadiran, dan siswa aktif.
- [ ] Buat daftar unpaid invoice dengan nama siswa, nominal tagihan, total terbayar, sisa, dan kontak WA.
- [ ] Buat screen rekap kehadiran per siswa/periode.
- [ ] Buat laporan per siswa.
- [ ] Pastikan UI hanya memanggil provider, bukan query database langsung.

## Aturan Perhitungan

- Pendapatan dihitung dari `payments.amount`, bukan dari `invoices.amount`.
- Outstanding dihitung dari `invoices.amount - invoices.paid_amount` untuk status `unpaid` dan `partial`.
- Invoice `cancelled` tidak dihitung sebagai tagihan aktif.
- Sesi selesai dihitung dari `sessions.attendance_status = present` atau status billable sesuai aturan Sprint 04.
- Filter tanggal pendapatan memakai `payments.paid_at`.
- Rekap kehadiran semester/periode dihitung dari `sessions.academic_period_id` dan `attendance_status`.
- Jika filter semester dipakai, query tidak boleh hanya mengandalkan rentang tanggal; gunakan `academic_period_id` sebagai filter utama bila tersedia.

## Acceptance Criteria

- [ ] Guru bisa melihat pendapatan hari ini, minggu ini, bulan ini, dan custom tanggal.
- [ ] Guru bisa melihat tagihan belum dibayar dengan sisa nominal yang benar.
- [ ] Guru bisa melihat ringkasan per siswa.
- [ ] Guru bisa melihat rekap kehadiran per siswa/periode dengan angka yang konsisten terhadap data sesi.
- [ ] Guru bisa memfilter laporan berdasarkan semester/periode akademik.
- [ ] Angka pendapatan berubah setelah pembayaran baru dicatat.
- [ ] Data export preparation tersedia tanpa logic khusus di UI.
- [ ] Tidak ada perhitungan uang di widget selain format tampilan.
