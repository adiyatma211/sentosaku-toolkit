# Sprint 06 - Academic Period, Assessment, dan Progress Report

## Tujuan

Menambahkan domain periodisasi akademik dan laporan perkembangan agar aplikasi tidak hanya mencatat operasional harian, tetapi juga bisa menyusun histori belajar per semester/periode secara rapi. Sprint ini menjadi penghubung antara data sesi, assessment, rekap kehadiran, dan laporan perkembangan siswa.

## Dependency / Prasyarat

- Sprint 01 sampai Sprint 04 selesai.
- Schema `academic_periods`, `student_periods`, `sessions`, dan `assessments` sudah tersedia.
- Jadwal dan sesi sudah stabil sebagai sumber data operasional.
- Assessment per sesi dari Sprint 04 sudah bisa disimpan.

## Output Akhir

- Guru bisa membuat dan mengelola periode akademik atau semester.
- Siswa bisa di-assign ke satu atau lebih periode tanpa merusak histori sebelumnya.
- Jadwal dan sesi dapat dikaitkan ke periode akademik yang benar.
- Assessment bisa dipakai per sesi atau dirangkum lagi per review cycle.
- Progress report per siswa per periode dapat dibuat, disimpan, dan disiapkan untuk export.

## Struktur File Yang Akan Dibuat

```text
lib/features/academic/
├── data/
│   ├── academic_period_repository.dart
│   ├── assessment_repository.dart
│   └── progress_report_repository.dart
├── providers/
│   ├── academic_period_provider.dart
│   ├── assessment_provider.dart
│   └── progress_report_provider.dart
├── screens/
│   ├── academic_period_list_screen.dart
│   ├── academic_period_form_screen.dart
│   ├── student_period_assignment_screen.dart
│   ├── assessment_review_screen.dart
│   └── progress_report_screen.dart
└── widgets/
    ├── academic_period_chip.dart
    ├── assessment_summary_card.dart
    ├── attendance_recap_card.dart
    └── progress_report_status_chip.dart
```

## Cakupan Data

| Entitas | Fungsi |
|---|---|
| `academic_periods` | Menyimpan semester/periode yang berlaku |
| `student_periods` | Menyimpan assignment siswa ke periode tertentu |
| `assessments` | Menyimpan penilaian 6 aspek per sesi atau per review cycle |
| `progress_reports` | Menyimpan hasil rangkuman perkembangan siswa per periode |

## Aturan Assignment Periode

- Satu siswa dapat memiliki beberapa riwayat periode, tetapi hanya satu assignment aktif untuk periode berjalan jika bisnis menghendaki.
- Jadwal baru default mengambil periode aktif siswa.
- Saat sesi dibuat dari jadwal, `academic_period_id` diturunkan dari jadwal agar histori tidak berubah jika assignment siswa nanti berganti.
- Laporan semester harus membaca assignment dan referensi periode yang tersimpan di jadwal/sesi, bukan hanya status periode saat ini.

## Review Cycle Assessment

- Assessment dasar tetap disimpan per sesi pada Sprint 04.
- Sprint ini menambahkan review cycle opsional, misalnya mingguan atau bulanan, yang merangkum beberapa assessment sesi menjadi satu catatan review.
- Review cycle tidak mengganti assessment sesi; ia hanya menjadi lapisan ringkasan tambahan untuk progress report.

## Struktur Progress Report

Progress report minimal memuat:

- Identitas siswa dan periode akademik.
- Ringkasan jumlah sesi dan rekap kehadiran.
- Ringkasan 6 aspek assessment.
- Catatan capaian materi.
- Catatan kendala belajar.
- Target materi atau drilling soal berikutnya.
- Catatan akhir guru.

## Urutan Implementasi / Checklist

- [ ] Buat repository untuk `academic_periods`, `student_periods`, `assessments`, dan `progress_reports`.
- [ ] Buat CRUD periode akademik: list, tambah, edit, aktif/nonaktif.
- [ ] Buat assignment siswa ke periode akademik.
- [ ] Pastikan form jadwal dan sesi dapat membaca periode aktif siswa.
- [ ] Buat query ringkasan assessment per siswa/periode.
- [ ] Buat query rekap kehadiran per siswa/periode dengan membaca tabel `sessions`.
- [ ] Buat `ProgressReportRepository.generateProgressReport(studentId, academicPeriodId)`.
- [ ] Simpan snapshot ringkasan ke `progress_reports` agar hasil laporan dapat dikunci saat dibutuhkan.
- [ ] Buat screen review progress report yang memungkinkan guru menambah catatan akhir.
- [ ] Buat status progress report minimal: `draft`, `finalized`, `exported`.

## Validasi

- [ ] Nama periode, tanggal mulai, dan tanggal selesai wajib diisi.
- [ ] Tanggal selesai tidak boleh lebih awal dari tanggal mulai.
- [ ] Siswa tidak boleh di-assign ganda ke periode yang sama.
- [ ] Progress report tidak boleh dibuat tanpa `student_id` dan `academic_period_id`.
- [ ] Review cycle tanpa assessment sumber yang jelas tidak boleh disimpan sebagai laporan final.

## Acceptance Criteria

- [ ] Guru bisa membuat periode akademik dan menandai periode aktif.
- [ ] Siswa bisa dihubungkan ke periode akademik tanpa menghapus histori periode lama.
- [ ] Jadwal dan sesi baru membawa referensi periode yang benar.
- [ ] Assessment per sesi dapat dirangkum menjadi review cycle.
- [ ] Progress report per siswa per periode bisa dibuat dari data nyata, bukan input manual kosong.
- [ ] Rekap kehadiran yang tampil di progress report konsisten dengan laporan sesi.
