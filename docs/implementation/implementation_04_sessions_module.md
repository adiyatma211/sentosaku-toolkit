# Sprint 04 - Sessions Module

## Tujuan

Membuat modul sesi/pertemuan sebagai realisasi jadwal les. Sprint ini mencakup pembuatan sesi dari jadwal, pencatatan absensi, materi, PR, catatan perkembangan, assessment terstruktur, update status jadwal, sumber data rekap kehadiran, dan pembuatan invoice jika tipe pembayaran membutuhkan tagihan per sesi.

## Dependency / Prasyarat

- Sprint 01 sampai Sprint 03 selesai.
- Jadwal bisa dibuat dan memiliki status.
- Siswa dan subject sudah bisa dipilih dari jadwal.
- Table `sessions` dan `invoices` tersedia dari schema awal.

## Output Akhir

- Guru bisa menandai jadwal sebagai selesai dan membuat riwayat sesi.
- Proses simpan sesi berjalan dalam database transaction.
- Status jadwal berubah sesuai hasil sesi.
- Assessment sesi tersimpan terstruktur dan bisa dipakai ulang untuk review cycle/progress report.
- Rekap kehadiran per siswa/periode memiliki sumber data tunggal dari tabel sesi.
- Invoice dibuat otomatis jika siswa memakai tarif per sesi.
- Riwayat sesi bisa dilihat per siswa dan secara umum.

## Struktur File Yang Akan Dibuat

```text
lib/features/sessions/
├── data/
│   └── session_repository.dart
├── providers/
│   └── session_provider.dart
├── screens/
│   ├── session_list_screen.dart
│   ├── session_form_screen.dart
│   └── session_detail_screen.dart
└── widgets/
    ├── session_card.dart
    ├── attendance_status_chip.dart
    └── session_empty_state.dart
```

## Data Sesi

| Field | Keterangan |
|---|---|
| `schedule_id` | Jadwal asal sesi |
| `student_id` | Siswa sesi |
| `subject_id` | Mata pelajaran sesi |
| `academic_period_id` | Periode akademik yang diturunkan dari jadwal atau pilihan aktif |
| `session_date` | Tanggal realisasi |
| `start_time` | Jam mulai aktual atau dari jadwal |
| `end_time` | Jam selesai aktual atau dari jadwal |
| `attendance_status` | `present`, `permission`, `absent`, `cancelled`, `rescheduled` |
| `material` | Materi yang diajarkan |
| `homework` | PR/tugas |
| `progress_note` | Catatan perkembangan |
| `fee_amount` | Biaya sesi |
| `is_attendance_source` | Penanda bahwa row ini ikut dihitung pada rekap kehadiran |
| `invoice_id` | Invoice yang dibuat jika ada |

## Data Assessment Terstruktur

| Field | Keterangan |
|---|---|
| `session_id` | Referensi sesi jika assessment dibuat per sesi |
| `student_id` | Siswa yang dinilai |
| `academic_period_id` | Periode akademik assessment |
| `assessment_type` | `per_session` atau `review_cycle` |
| `review_cycle_label` | Label review, misalnya `Review Bulanan Agustus` |
| `pemahaman_materi` | Ringkasan pemahaman materi |
| `keaktifan_tanya_jawab` | Observasi interaksi siswa |
| `ketepatan_kerapian_tugas` | Evaluasi tugas/PR |
| `konsistensi_kehadiran_fokus` | Konsistensi hadir dan fokus belajar |
| `target_materi_drilling` | Target materi berikutnya / drilling soal |
| `sikap_belajar_respon` | Sikap belajar dan respon siswa |
| `summary_note` | Catatan guru tambahan |

## Provider Yang Dibuat

- `sessionRepositoryProvider`.
- `sessionsProvider` untuk riwayat semua sesi.
- `studentSessionsProvider(studentId)` untuk riwayat per siswa.
- `sessionDetailProvider(sessionId)`.
- `sessionFormNotifierProvider` untuk create/update sesi.
- `studentAttendanceRecapProvider(filter)` untuk ringkasan kehadiran berbasis sesi.

## Transaction Wajib

Pembuatan sesi dari jadwal harus atomic:

```text
Transaction start
Insert session
Insert/update assessment jika diisi pada form sesi
Update schedule status
Create invoice jika rate_type = per_session dan sesi billable
Update session.invoice_id jika invoice dibuat
Transaction commit
```

Jika salah satu langkah gagal, semua perubahan harus rollback.

## Urutan Implementasi / Checklist

- [ ] Lengkapi table `sessions` dengan field absensi, materi, PR, catatan, fee, dan invoice reference.
- [ ] Lengkapi table `sessions` dengan `academic_period_id` dan `is_attendance_source`.
- [ ] Buat table `assessments` atau struktur setara untuk penilaian terstruktur.
- [ ] Lengkapi table `invoices` minimal untuk invoice per sesi.
- [ ] Buat query session join student, subject, schedule, assessment ringkas, dan invoice untuk list/detail.
- [ ] Buat `SessionRepository.watchSessions()`.
- [ ] Buat `SessionRepository.watchStudentSessions(studentId)`.
- [ ] Buat `SessionRepository.getAttendanceRecap(filter)` yang menghitung hadir/izin/tidak hadir/batal/reschedule dari tabel `sessions`.
- [ ] Buat `SessionRepository.createSessionFromSchedule()` dengan transaction.
- [ ] Di transaction, insert row `sessions`.
- [ ] Di transaction, simpan assessment terstruktur jika user mengisi form penilaian.
- [ ] Di transaction, update `schedules.status` menjadi `done`, `no_show`, `cancelled`, atau `rescheduled` sesuai absensi.
- [ ] Di transaction, buat invoice jika status sesi billable dan tipe tarif siswa adalah per sesi.
- [ ] Pastikan sesi tidak bisa dibuat dua kali untuk schedule yang sama kecuali ada aturan eksplisit.
- [ ] Buat route list, form dari schedule detail, dan detail sesi.
- [ ] Buat form sesi dengan field absensi, materi, PR, catatan, biaya sesi, dan 6 aspek assessment terstruktur.
- [ ] Update dashboard agar sesi selesai bulan ini bisa dihitung.

## Aturan Billable Session

- `present` biasanya billable.
- `permission`, `absent`, `cancelled`, dan `rescheduled` mengikuti opsi form apakah tetap ditagihkan.
- Default MVP: hanya `present` yang otomatis membuat invoice.
- Fee default diambil dari `students.rate_amount`, tetapi bisa diedit saat membuat sesi.

## Aturan Rekap Kehadiran

- Rekap kehadiran per siswa/periode selalu dihitung dari `sessions.attendance_status` dengan `is_attendance_source = true`.
- Row `cancelled` dan `rescheduled` tetap disimpan untuk histori operasional, tetapi cara penghitungannya ke summary harus eksplisit di repository.
- Tidak boleh ada tabel rekap manual yang menjadi sumber kebenaran utama; jika perlu cache agregat, cache harus bisa diregenerasi dari sesi.

## Acceptance Criteria

- [ ] Guru bisa membuka jadwal dan menandainya selesai.
- [ ] Sesi tersimpan sebagai riwayat pertemuan.
- [ ] Status jadwal berubah setelah sesi dibuat.
- [ ] Assessment terstruktur tersimpan dan dapat dibaca kembali pada detail sesi.
- [ ] Invoice otomatis dibuat untuk sesi billable per sesi.
- [ ] Jika insert session gagal, status jadwal dan invoice tidak berubah.
- [ ] Rekap kehadiran per siswa bisa dihitung akurat dari data sesi.
- [ ] Riwayat sesi bisa dilihat per siswa.
- [ ] Dashboard berubah setelah sesi selesai.
