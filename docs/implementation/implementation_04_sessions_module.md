# Sprint 04 - Sessions Module

## Tujuan

Membuat modul sesi/pertemuan sebagai realisasi jadwal les. Sprint ini mencakup pembuatan sesi dari jadwal, pencatatan absensi, materi, PR, catatan perkembangan, update status jadwal, dan pembuatan invoice jika tipe pembayaran membutuhkan tagihan per sesi.

## Dependency / Prasyarat

- Sprint 01 sampai Sprint 03 selesai.
- Jadwal bisa dibuat dan memiliki status.
- Siswa dan subject sudah bisa dipilih dari jadwal.
- Table `sessions` dan `invoices` tersedia dari schema awal.

## Output Akhir

- Guru bisa menandai jadwal sebagai selesai dan membuat riwayat sesi.
- Proses simpan sesi berjalan dalam database transaction.
- Status jadwal berubah sesuai hasil sesi.
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
| `session_date` | Tanggal realisasi |
| `start_time` | Jam mulai aktual atau dari jadwal |
| `end_time` | Jam selesai aktual atau dari jadwal |
| `attendance_status` | `present`, `permission`, `absent`, `cancelled`, `rescheduled` |
| `material` | Materi yang diajarkan |
| `homework` | PR/tugas |
| `progress_note` | Catatan perkembangan |
| `fee_amount` | Biaya sesi |
| `invoice_id` | Invoice yang dibuat jika ada |

## Provider Yang Dibuat

- `sessionRepositoryProvider`.
- `sessionsProvider` untuk riwayat semua sesi.
- `studentSessionsProvider(studentId)` untuk riwayat per siswa.
- `sessionDetailProvider(sessionId)`.
- `sessionFormNotifierProvider` untuk create/update sesi.

## Transaction Wajib

Pembuatan sesi dari jadwal harus atomic:

```text
Transaction start
Insert session
Update schedule status
Create invoice jika rate_type = per_session dan sesi billable
Update session.invoice_id jika invoice dibuat
Transaction commit
```

Jika salah satu langkah gagal, semua perubahan harus rollback.

## Urutan Implementasi / Checklist

- [ ] Lengkapi table `sessions` dengan field absensi, materi, PR, catatan, fee, dan invoice reference.
- [ ] Lengkapi table `invoices` minimal untuk invoice per sesi.
- [ ] Buat query session join student, subject, schedule, dan invoice untuk list/detail.
- [ ] Buat `SessionRepository.watchSessions()`.
- [ ] Buat `SessionRepository.watchStudentSessions(studentId)`.
- [ ] Buat `SessionRepository.createSessionFromSchedule()` dengan transaction.
- [ ] Di transaction, insert row `sessions`.
- [ ] Di transaction, update `schedules.status` menjadi `done`, `no_show`, `cancelled`, atau `rescheduled` sesuai absensi.
- [ ] Di transaction, buat invoice jika status sesi billable dan tipe tarif siswa adalah per sesi.
- [ ] Pastikan sesi tidak bisa dibuat dua kali untuk schedule yang sama kecuali ada aturan eksplisit.
- [ ] Buat route list, form dari schedule detail, dan detail sesi.
- [ ] Buat form sesi dengan field absensi, materi, PR, catatan, dan biaya sesi.
- [ ] Update dashboard agar sesi selesai bulan ini bisa dihitung.

## Aturan Billable Session

- `present` biasanya billable.
- `permission`, `absent`, `cancelled`, dan `rescheduled` mengikuti opsi form apakah tetap ditagihkan.
- Default MVP: hanya `present` yang otomatis membuat invoice.
- Fee default diambil dari `students.rate_amount`, tetapi bisa diedit saat membuat sesi.

## Acceptance Criteria

- [ ] Guru bisa membuka jadwal dan menandainya selesai.
- [ ] Sesi tersimpan sebagai riwayat pertemuan.
- [ ] Status jadwal berubah setelah sesi dibuat.
- [ ] Invoice otomatis dibuat untuk sesi billable per sesi.
- [ ] Jika insert session gagal, status jadwal dan invoice tidak berubah.
- [ ] Riwayat sesi bisa dilihat per siswa.
- [ ] Dashboard berubah setelah sesi selesai.
