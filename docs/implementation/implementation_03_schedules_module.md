# Sprint 03 - Schedules Module

## Tujuan

Membuat modul jadwal les setelah data siswa siap. Modul ini mencakup subject, schedule, recurring sederhana, filter tanggal, placeholder reminder lokal, dan status jadwal.

## Dependency / Prasyarat

- Sprint 01 dan Sprint 02 selesai.
- Siswa aktif bisa dibuat dan dipilih.
- `students`, `subjects`, dan `schedules` table tersedia.
- Router sudah bisa membuka halaman modul jadwal.

## Output Akhir

- Guru bisa membuat jadwal sekali dan mingguan sederhana.
- Jadwal bisa difilter berdasarkan tanggal.
- Jadwal punya status `scheduled`, `done`, `cancelled`, `rescheduled`, atau `no_show`.
- Jadwal menampilkan nama siswa dan mata pelajaran.
- Placeholder reminder lokal tersedia untuk integrasi notifikasi berikutnya.

## Struktur File Yang Akan Dibuat

```text
lib/features/schedules/
├── data/
│   ├── schedule_repository.dart
│   └── subject_repository.dart
├── providers/
│   ├── schedule_provider.dart
│   └── subject_provider.dart
├── screens/
│   ├── schedule_list_screen.dart
│   ├── schedule_form_screen.dart
│   └── schedule_detail_screen.dart
└── widgets/
    ├── schedule_card.dart
    ├── schedule_date_filter.dart
    ├── schedule_status_chip.dart
    └── schedule_empty_state.dart
```

## Data Jadwal

| Field | Keterangan |
|---|---|
| `student_id` | Siswa aktif yang mengikuti les |
| `subject_id` | Mata pelajaran |
| `date` | Tanggal jadwal |
| `start_time` | Jam mulai |
| `end_time` | Jam selesai |
| `schedule_type` | `once`, `weekly`, atau `custom` untuk nanti |
| `status` | Status jadwal |
| `recurrence_group_id` | ID grup untuk jadwal berulang sederhana |
| `reminder_enabled` | Flag reminder lokal |
| `note` | Catatan jadwal |

## Provider Yang Dibuat

- `subjectRepositoryProvider` dan `subjectsByStudentProvider(studentId)`.
- `scheduleRepositoryProvider`.
- `selectedScheduleDateProvider` untuk tanggal yang sedang dipilih.
- `scheduleByDateProvider(date)` untuk stream jadwal tanggal tertentu.
- `todaySchedulesProvider` untuk dashboard.
- `weeklySchedulesProvider` jika dibutuhkan ringkasan minggu.
- `scheduleFormNotifierProvider` untuk tambah/edit/reschedule/cancel.

## Recurring Sederhana

- MVP cukup mendukung `once` dan `weekly`.
- Untuk `weekly`, repository membuat beberapa row jadwal sekaligus berdasarkan jumlah minggu atau tanggal akhir yang dipilih.
- Semua row recurring punya `recurrence_group_id` yang sama.
- Edit satu jadwal hanya mengubah jadwal tersebut kecuali nanti dibuat opsi edit semua.

## Urutan Implementasi / Checklist

- [ ] Lengkapi table `subjects` dan repository subject.
- [ ] Pastikan subject bisa dibuat dari data awal siswa atau dari form jadwal.
- [ ] Lengkapi table `schedules` dengan status, type, dan recurrence group.
- [ ] Buat query join schedule dengan student dan subject untuk tampilan list.
- [ ] Buat `ScheduleRepository.watchSchedulesByDate(date)`.
- [ ] Buat `ScheduleRepository.watchTodaySchedules()` untuk dashboard.
- [ ] Buat `ScheduleRepository.insertSchedule()` untuk jadwal sekali.
- [ ] Buat logic recurring mingguan sederhana di repository.
- [ ] Buat `ScheduleRepository.reschedule()` untuk ubah tanggal/jam.
- [ ] Buat `ScheduleRepository.cancelSchedule()` untuk status `cancelled`.
- [ ] Buat provider filter tanggal dan stream jadwal.
- [ ] Buat route list, form, dan detail jadwal.
- [ ] Buat `ScheduleListScreen` dengan date filter.
- [ ] Buat `ScheduleFormScreen` dengan picker siswa aktif, subject, tanggal, jam mulai, jam selesai, tipe jadwal, dan reminder flag.
- [ ] Buat placeholder `LocalReminderService` atau method repository yang belum menjadwalkan notifikasi nyata tetapi sudah punya titik integrasi.
- [ ] Update dashboard agar menampilkan jadwal hari ini.

## Validasi Form

- [ ] Siswa wajib dipilih dan harus aktif.
- [ ] Subject wajib dipilih.
- [ ] Tanggal wajib diisi.
- [ ] Jam mulai dan jam selesai wajib diisi.
- [ ] Jam selesai harus lebih besar dari jam mulai.
- [ ] Tipe jadwal wajib dipilih.
- [ ] Untuk weekly recurring, jumlah pengulangan atau tanggal akhir wajib jelas.

## Acceptance Criteria

- [ ] Guru bisa membuat jadwal untuk siswa aktif.
- [ ] Jadwal tampil berdasarkan tanggal yang dipilih.
- [ ] Jadwal hari ini tampil di dashboard.
- [ ] Jadwal weekly membuat beberapa row dengan recurrence group yang sama.
- [ ] Jadwal bisa dibatalkan tanpa dihapus.
- [ ] Jadwal bisa di-reschedule.
- [ ] Reminder placeholder tidak memblokir pembuatan jadwal jika notifikasi belum diaktifkan.
