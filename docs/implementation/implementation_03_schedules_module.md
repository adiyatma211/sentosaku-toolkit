# Sprint 03 - Schedules Module

## Tujuan

Membuat modul jadwal les setelah data siswa siap. Modul ini mencakup subject, schedule, recurring sederhana, filter tanggal, reminder lokal jadwal, aturan reminder reschedule, assignment periode akademik pada jadwal, dan status jadwal.

## Dependency / Prasyarat

- Sprint 01 dan Sprint 02 selesai.
- Siswa aktif bisa dibuat dan dipilih.
- `students`, `subjects`, dan `schedules` table tersedia.
- Router sudah bisa membuka halaman modul jadwal.

## Output Akhir

- Guru bisa membuat jadwal sekali dan mingguan sederhana.
- Jadwal bisa difilter berdasarkan tanggal.
- Jadwal punya status `scheduled`, `done`, `cancelled`, `rescheduled`, atau `no_show`.
- Jadwal menampilkan nama siswa, mata pelajaran, dan periode akademik.
- Reminder lokal sesi terjadwal dan reminder setelah reschedule punya aturan integrasi yang jelas.

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
| `academic_period_id` | Periode akademik/semester terkait |
| `date` | Tanggal jadwal |
| `start_time` | Jam mulai |
| `end_time` | Jam selesai |
| `schedule_type` | `once`, `weekly`, atau `custom` untuk nanti |
| `status` | Status jadwal |
| `recurrence_group_id` | ID grup untuk jadwal berulang sederhana |
| `reminder_enabled` | Flag reminder lokal |
| `reminder_offset_minutes` | Offset menit sebelum sesi |
| `note` | Catatan jadwal |

## Provider Yang Dibuat

- `subjectRepositoryProvider` dan `subjectsByStudentProvider(studentId)`.
- `scheduleRepositoryProvider`.
- `selectedScheduleDateProvider` untuk tanggal yang sedang dipilih.
- `scheduleByDateProvider(date)` untuk stream jadwal tanggal tertentu.
- `todaySchedulesProvider` untuk dashboard.
- `weeklySchedulesProvider` jika dibutuhkan ringkasan minggu.
- `scheduleFormNotifierProvider` untuk tambah/edit/reschedule/cancel.
- `pendingScheduleRemindersProvider` untuk daftar jadwal yang perlu dijadwalkan notifikasinya.

## Recurring Sederhana

- MVP cukup mendukung `once` dan `weekly`.
- Untuk `weekly`, repository membuat beberapa row jadwal sekaligus berdasarkan jumlah minggu atau tanggal akhir yang dipilih.
- Semua row recurring punya `recurrence_group_id` yang sama.
- Edit satu jadwal hanya mengubah jadwal tersebut kecuali nanti dibuat opsi edit semua.

## Scope Reminder Lokal

- Reminder lokal bukan lagi placeholder; Sprint 03 harus menyiapkan contract service yang benar-benar bisa dipanggil oleh notifikasi lokal saat plugin dipasang.
- Sumber reminder hanya dari row `schedules` yang `status = scheduled` dan `reminder_enabled = true`.
- Default offset reminder sesi adalah 60 menit sebelum jadwal, tetapi tetap configurable dari form jika aturan global sudah tersedia.
- Saat jadwal dibatalkan, reminder aktif wajib dibatalkan.
- Saat jadwal di-reschedule, reminder lama wajib dibatalkan dan reminder baru dibuat ulang memakai tanggal/jam pengganti.
- Semua operasi schedule create, update, cancel, dan reschedule harus memanggil lapisan integrasi reminder agar perilaku konsisten.

## Aturan Reschedule

- Reschedule wajib menyimpan waktu lama dan waktu baru minimal di audit note atau metadata agar histori operasional tetap bisa ditelusuri.
- Status jadwal berubah menjadi `rescheduled` hanya untuk row lama bila model memakai row pengganti baru; jika tetap memakai row yang sama, status akhir kembali `scheduled` dengan penanda `last_rescheduled_at`.
- Reminder follow-up reschedule cukup lokal di aplikasi: menampilkan badge/list bahwa ada jadwal yang baru dipindah dan perlu diperhatikan guru.
- Sprint ini belum wajib mengirim WhatsApp; yang wajib adalah audit log dan notifikasi lokal internal.

## Urutan Implementasi / Checklist

- [ ] Lengkapi table `subjects` dan repository subject.
- [ ] Pastikan subject bisa dibuat dari data awal siswa atau dari form jadwal.
- [ ] Lengkapi table `schedules` dengan `academic_period_id`, status, type, recurrence group, dan field reminder.
- [ ] Buat query join schedule dengan student dan subject untuk tampilan list.
- [ ] Pastikan assignment `academic_period_id` otomatis mengikuti periode aktif siswa, tetapi tetap bisa disesuaikan bila diperlukan.
- [ ] Buat `ScheduleRepository.watchSchedulesByDate(date)`.
- [ ] Buat `ScheduleRepository.watchTodaySchedules()` untuk dashboard.
- [ ] Buat `ScheduleRepository.insertSchedule()` untuk jadwal sekali.
- [ ] Buat logic recurring mingguan sederhana di repository.
- [ ] Buat `ScheduleRepository.reschedule()` untuk ubah tanggal/jam.
- [ ] Buat `ScheduleRepository.cancelSchedule()` untuk status `cancelled`.
- [ ] Buat contract `LocalReminderScheduler` atau service setara dengan method `scheduleSessionReminder`, `cancelScheduleReminder`, dan `rescheduleSessionReminder`.
- [ ] Simpan log status penjadwalan reminder ke tabel/log lokal jika tersedia.
- [ ] Buat provider filter tanggal dan stream jadwal.
- [ ] Buat route list, form, dan detail jadwal.
- [ ] Buat `ScheduleListScreen` dengan date filter dan indikator reminder aktif/reschedule.
- [ ] Buat `ScheduleFormScreen` dengan picker siswa aktif, subject, periode akademik, tanggal, jam mulai, jam selesai, tipe jadwal, reminder flag, dan offset reminder.
- [ ] Update dashboard agar menampilkan jadwal hari ini.

## Validasi Form

- [ ] Siswa wajib dipilih dan harus aktif.
- [ ] Subject wajib dipilih.
- [ ] Periode akademik wajib terisi jika siswa sudah punya assignment periode aktif.
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
- [ ] Reminder lokal dibuat untuk jadwal yang memenuhi syarat.
- [ ] Reminder lama dibatalkan dan reminder baru dibuat saat jadwal di-reschedule.
- [ ] Kegagalan sinkronisasi reminder tidak boleh menghapus jadwal, tetapi harus tercatat sebagai error yang bisa ditindaklanjuti.
