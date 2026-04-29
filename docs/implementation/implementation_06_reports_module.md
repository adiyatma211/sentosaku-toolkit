# Sprint 06 - Reports Module

## Tujuan

Membuat modul laporan setelah data pembayaran stabil. Modul ini mencakup laporan pendapatan, tagihan belum dibayar, laporan per siswa, filter periode, dan persiapan data export untuk Sprint 07.

## Dependency / Prasyarat

- Sprint 01 sampai Sprint 05 selesai.
- Invoice dan payment status sudah akurat.
- Data siswa, subject, jadwal, sesi, invoice, dan payment bisa dibaca dari repository.

## Output Akhir

- Guru bisa melihat total pendapatan berdasarkan periode.
- Guru bisa melihat daftar tagihan belum dibayar.
- Guru bisa melihat performa pembayaran per siswa.
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
| Per siswa | `students`, `sessions`, `invoices`, `payments` | Total sesi, total tagihan, total bayar, sisa tagihan |
| Ringkasan sesi | `sessions` | Jumlah sesi selesai per periode |

## Provider Yang Dibuat

- `reportRepositoryProvider`.
- `reportFilterProvider` untuk periode dan filter siswa.
- `incomeReportProvider(filter)`.
- `unpaidReportProvider`.
- `studentReportProvider(filter)`.
- `exportReportDataProvider(filter)` untuk persiapan Sprint 07.

## Filter Laporan

- Hari ini.
- Minggu ini.
- Bulan ini.
- Custom tanggal.
- Per siswa.
- Per mata pelajaran jika subject sudah cukup stabil.
- Belum dibayar.

## Urutan Implementasi / Checklist

- [ ] Buat model data laporan sederhana di `report_models.dart`.
- [ ] Buat `ReportFilter` berisi `startDate`, `endDate`, `studentId`, `subjectId`, dan tipe filter.
- [ ] Buat `ReportRepository.getIncomeReport(filter)` dari tabel `payments`.
- [ ] Buat query total pendapatan yang hanya menghitung pembayaran yang benar-benar diterima.
- [ ] Buat `ReportRepository.getUnpaidReport()` dari invoice `unpaid` dan `partial`.
- [ ] Buat `ReportRepository.getStudentReport(filter)` untuk total sesi, invoice, payment, dan outstanding per siswa.
- [ ] Buat `ReportRepository.getExportData(filter)` yang mengembalikan data tabular siap export.
- [ ] Buat provider filter dan provider laporan.
- [ ] Buat `ReportScreen` sebagai entry point laporan.
- [ ] Buat filter bar dengan periode hari ini, minggu ini, bulan ini, dan custom.
- [ ] Buat tampilan summary card: total pendapatan, total tagihan, outstanding, jumlah sesi selesai, siswa aktif.
- [ ] Buat daftar unpaid invoice dengan nama siswa, nominal tagihan, total terbayar, sisa, dan kontak WA.
- [ ] Buat laporan per siswa.
- [ ] Pastikan UI hanya memanggil provider, bukan query database langsung.

## Aturan Perhitungan

- Pendapatan dihitung dari `payments.amount`, bukan dari `invoices.amount`.
- Outstanding dihitung dari `invoices.amount - invoices.paid_amount` untuk status `unpaid` dan `partial`.
- Invoice `cancelled` tidak dihitung sebagai tagihan aktif.
- Sesi selesai dihitung dari `sessions.attendance_status = present` atau status billable sesuai aturan Sprint 04.
- Filter tanggal pendapatan memakai `payments.paid_at`.

## Acceptance Criteria

- [ ] Guru bisa melihat pendapatan hari ini, minggu ini, bulan ini, dan custom tanggal.
- [ ] Guru bisa melihat tagihan belum dibayar dengan sisa nominal yang benar.
- [ ] Guru bisa melihat ringkasan per siswa.
- [ ] Angka pendapatan berubah setelah pembayaran baru dicatat.
- [ ] Data export preparation tersedia tanpa logic khusus di UI.
- [ ] Tidak ada perhitungan uang di widget selain format tampilan.
