# Workflow State Management Aplikasi Guru Private Offline

## 1. Ringkasan

Dokumen ini menjelaskan workflow state management untuk aplikasi **Freelance Guru / Guru Private Offline** berbasis Flutter.

Rekomendasi stack:

```text
Flutter
↓
Riverpod
↓
Repository Layer
↓
Drift
↓
SQLite Local Database
```

Tujuan workflow ini:

- Membuat struktur aplikasi lebih rapi.
- Memisahkan UI dari logic bisnis.
- Membuat data offline tetap reactive.
- Memudahkan pengembangan modul siswa, jadwal, sesi, pembayaran, laporan, dan backup.
- Menyiapkan fondasi jika nanti aplikasi dikembangkan ke cloud sync.

---

## 2. Arsitektur State Management

### 2.1 Alur Utama

```text
User membuka halaman
↓
Widget membaca Provider
↓
Provider memanggil Repository
↓
Repository mengambil data dari Drift
↓
Drift membaca SQLite lokal
↓
Data dikirim kembali ke Provider
↓
Provider mengirim state ke UI
↓
UI menampilkan data
```

### 2.2 Alur Ketika Data Berubah

```text
User menambah / mengubah / menghapus data
↓
UI memanggil method di Notifier / Controller
↓
Notifier memanggil Repository
↓
Repository menjalankan query ke Drift
↓
Drift mengubah data di SQLite
↓
Stream database mendeteksi perubahan
↓
Provider menerima data terbaru
↓
UI otomatis rebuild
```

---

## 3. Layer Aplikasi

### 3.1 UI Layer

UI Layer berisi halaman dan widget.

Contoh:

```text
StudentListScreen
StudentFormScreen
ScheduleScreen
PaymentScreen
ReportScreen
DashboardScreen
```

Tugas UI Layer:

- Menampilkan data.
- Menangkap input user.
- Menampilkan loading, error, dan empty state.
- Memanggil provider/notifier.
- Tidak langsung mengakses database.

Aturan penting:

```text
UI tidak boleh melakukan query langsung ke database.
```

---

### 3.2 Provider Layer

Provider Layer adalah penghubung antara UI dan business logic.

Tugas Provider Layer:

- Menyediakan data ke UI.
- Menjaga state loading, success, error.
- Mengelola filter.
- Mengelola selected item.
- Memanggil repository.
- Menyediakan stream data reactive.

Jenis provider yang digunakan:

| Jenis Provider | Fungsi |
|---|---|
| Provider | Dependency injection seperti database dan repository |
| StreamProvider | Data realtime dari database lokal |
| FutureProvider | Data sekali ambil seperti laporan tertentu |
| Notifier | State sederhana seperti filter dan form |
| AsyncNotifier | Proses async seperti tambah data, update data, backup, restore |

---

### 3.3 Repository Layer

Repository Layer berisi logic akses data.

Tugas Repository:

- Menyediakan function CRUD.
- Menjalankan query database.
- Menyembunyikan detail Drift dari UI.
- Menggabungkan data dari beberapa tabel.
- Menyiapkan data untuk dashboard dan laporan.

Contoh repository:

```text
StudentRepository
ScheduleRepository
SessionRepository
PaymentRepository
ReportRepository
BackupRepository
```

---

### 3.4 Database Layer

Database Layer menggunakan Drift dan SQLite.

Tugas Database Layer:

- Menyimpan data lokal.
- Menyediakan tabel.
- Menjalankan query.
- Menyediakan stream reactive.
- Menjaga relasi data.

Contoh tabel:

```text
students
subjects
schedules
sessions
payments
expenses
settings
```

---

## 4. Struktur Folder Rekomendasi

```text
lib/
├── main.dart
│
├── app/
│   ├── app.dart
│   └── router.dart
│
├── core/
│   ├── database/
│   │   ├── app_database.dart
│   │   ├── database_provider.dart
│   │   └── tables/
│   │       ├── students_table.dart
│   │       ├── schedules_table.dart
│   │       ├── sessions_table.dart
│   │       ├── payments_table.dart
│   │       └── settings_table.dart
│   │
│   ├── constants/
│   ├── helpers/
│   └── utils/
│
├── features/
│   ├── dashboard/
│   │   ├── data/
│   │   │   └── dashboard_repository.dart
│   │   ├── providers/
│   │   │   └── dashboard_provider.dart
│   │   ├── screens/
│   │   │   └── dashboard_screen.dart
│   │   └── widgets/
│   │
│   ├── students/
│   │   ├── data/
│   │   │   └── student_repository.dart
│   │   ├── providers/
│   │   │   └── student_provider.dart
│   │   ├── screens/
│   │   │   ├── student_list_screen.dart
│   │   │   ├── student_form_screen.dart
│   │   │   └── student_detail_screen.dart
│   │   └── widgets/
│   │
│   ├── schedules/
│   │   ├── data/
│   │   │   └── schedule_repository.dart
│   │   ├── providers/
│   │   │   └── schedule_provider.dart
│   │   ├── screens/
│   │   └── widgets/
│   │
│   ├── sessions/
│   │   ├── data/
│   │   │   └── session_repository.dart
│   │   ├── providers/
│   │   │   └── session_provider.dart
│   │   ├── screens/
│   │   └── widgets/
│   │
│   ├── payments/
│   │   ├── data/
│   │   │   └── payment_repository.dart
│   │   ├── providers/
│   │   │   └── payment_provider.dart
│   │   ├── screens/
│   │   └── widgets/
│   │
│   ├── reports/
│   │   ├── data/
│   │   │   └── report_repository.dart
│   │   ├── providers/
│   │   │   └── report_provider.dart
│   │   ├── screens/
│   │   └── widgets/
│   │
│   └── backup/
│       ├── data/
│       │   └── backup_repository.dart
│       ├── providers/
│       │   └── backup_provider.dart
│       ├── screens/
│       └── widgets/
```

---

## 5. Workflow Global Aplikasi

### 5.1 Workflow Saat Aplikasi Dibuka

```text
User membuka aplikasi
↓
main.dart menjalankan ProviderScope
↓
AppDatabase dibuat melalui databaseProvider
↓
Repository dibuat melalui repositoryProvider
↓
DashboardScreen membaca dashboardProvider
↓
dashboardProvider mengambil data dari dashboardRepository
↓
dashboardRepository membaca data dari Drift
↓
UI menampilkan ringkasan dashboard
```

Output:

```text
Dashboard tampil dengan:
- Total siswa aktif
- Jadwal hari ini
- Pendapatan bulan ini
- Tagihan belum dibayar
```

---

### 5.2 Workflow Menampilkan Data Realtime

```text
Screen membaca StreamProvider
↓
StreamProvider memanggil repository.watchData()
↓
Repository menjalankan query watch dari Drift
↓
Drift membuat stream dari SQLite
↓
Jika data berubah, stream mengirim data baru
↓
Provider menerima data baru
↓
UI otomatis rebuild
```

Cocok untuk:

```text
Daftar siswa
Jadwal hari ini
Tagihan belum dibayar
Riwayat pembayaran
Dashboard summary
```

---

### 5.3 Workflow Menambah Data

```text
User mengisi form
↓
User klik Simpan
↓
UI memanggil AsyncNotifier.addData()
↓
Notifier mengubah state menjadi loading
↓
Notifier memanggil repository.insertData()
↓
Repository menyimpan data ke Drift
↓
Drift menyimpan data ke SQLite
↓
Jika berhasil, Notifier mengubah state menjadi success
↓
StreamProvider terkait otomatis menerima update
↓
UI kembali ke halaman list
↓
Data baru muncul
```

---

### 5.4 Workflow Mengubah Data

```text
User membuka detail data
↓
User klik Edit
↓
UI menampilkan form berisi data lama
↓
User mengubah data
↓
User klik Simpan
↓
UI memanggil AsyncNotifier.updateData()
↓
Notifier memanggil Repository
↓
Repository menjalankan update ke Drift
↓
SQLite diperbarui
↓
StreamProvider menerima data terbaru
↓
UI otomatis berubah
```

---

### 5.5 Workflow Menghapus / Menonaktifkan Data

Untuk data penting seperti siswa, sebaiknya tidak langsung dihapus permanen.

Gunakan soft delete atau status nonaktif.

```text
User membuka detail siswa
↓
User klik Nonaktifkan Siswa
↓
UI menampilkan konfirmasi
↓
User menyetujui
↓
Notifier memanggil repository.deactivateStudent()
↓
Repository mengubah status siswa menjadi nonaktif
↓
Database menyimpan perubahan
↓
Daftar siswa aktif otomatis update
```

Alasan:

- Riwayat jadwal tetap aman.
- Riwayat pembayaran tidak hilang.
- Laporan lama tetap valid.
- Data bisa diaktifkan kembali.

---

## 6. Workflow Modul Siswa

### 6.1 Provider yang Digunakan

```text
databaseProvider
studentRepositoryProvider
studentsProvider
activeStudentsProvider
studentDetailProvider
studentFormNotifierProvider
```

### 6.2 Alur Menampilkan Daftar Siswa

```text
StudentListScreen dibuka
↓
UI watch activeStudentsProvider
↓
activeStudentsProvider memanggil StudentRepository.watchActiveStudents()
↓
Repository mengambil stream dari tabel students
↓
Drift membaca SQLite
↓
Data siswa aktif tampil di UI
```

### 6.3 Alur Tambah Siswa

```text
Guru buka StudentFormScreen
↓
Guru input data siswa
↓
Guru klik Simpan
↓
studentFormNotifier.setLoading()
↓
studentFormNotifier memvalidasi input
↓
studentFormNotifier memanggil StudentRepository.insertStudent()
↓
Repository insert ke tabel students
↓
Database menyimpan data siswa
↓
Notifier mengembalikan status success
↓
StudentListScreen otomatis update
```

### 6.4 Alur Edit Siswa

```text
Guru buka detail siswa
↓
Guru klik Edit
↓
Form mengambil data dari studentDetailProvider
↓
Guru mengubah data
↓
Guru klik Simpan
↓
Notifier memanggil updateStudent()
↓
Repository update data siswa
↓
Stream daftar siswa mengirim data terbaru
↓
UI otomatis update
```

---

## 7. Workflow Modul Jadwal

### 7.1 Provider yang Digunakan

```text
scheduleRepositoryProvider
todaySchedulesProvider
weeklySchedulesProvider
scheduleByDateProvider
scheduleFormNotifierProvider
selectedDateProvider
```

### 7.2 Alur Menampilkan Jadwal Hari Ini

```text
ScheduleScreen dibuka
↓
UI membaca selectedDateProvider
↓
UI watch scheduleByDateProvider(selectedDate)
↓
Provider memanggil ScheduleRepository.watchSchedulesByDate()
↓
Repository query jadwal berdasarkan tanggal
↓
Drift mengirim stream data jadwal
↓
UI menampilkan daftar jadwal
```

### 7.3 Alur Membuat Jadwal

```text
Guru klik Tambah Jadwal
↓
Pilih siswa
↓
Pilih mata pelajaran
↓
Pilih tanggal
↓
Pilih jam mulai dan jam selesai
↓
Pilih tipe jadwal
↓
Klik Simpan
↓
scheduleFormNotifier memvalidasi data
↓
Notifier memanggil ScheduleRepository.insertSchedule()
↓
Repository menyimpan jadwal ke Drift
↓
Jika jadwal berulang, repository membuat beberapa jadwal sesuai aturan
↓
SQLite menyimpan data jadwal
↓
Provider jadwal otomatis update
```

### 7.4 Alur Reschedule

```text
Guru membuka detail jadwal
↓
Klik Reschedule
↓
Pilih tanggal dan jam baru
↓
Klik Simpan
↓
scheduleFormNotifier memanggil reschedule()
↓
Repository mengubah tanggal dan jam jadwal
↓
Status jadwal berubah menjadi Reschedule atau tetap Terjadwal
↓
UI jadwal update otomatis
```

### 7.5 Alur Membatalkan Jadwal

```text
Guru membuka detail jadwal
↓
Klik Batalkan
↓
Input alasan opsional
↓
Konfirmasi batal
↓
Notifier memanggil cancelSchedule()
↓
Repository update status menjadi Batal
↓
UI jadwal update
```

---

## 8. Workflow Modul Pertemuan / Sesi Les

### 8.1 Provider yang Digunakan

```text
sessionRepositoryProvider
sessionsProvider
studentSessionsProvider
sessionFormNotifierProvider
```

### 8.2 Alur Tandai Jadwal Selesai

```text
Guru membuka jadwal hari ini
↓
Pilih jadwal
↓
Klik Tandai Selesai
↓
Form sesi terbuka
↓
Guru input:
- Status kehadiran
- Materi
- PR
- Catatan perkembangan
- Biaya sesi
↓
Klik Simpan
↓
sessionFormNotifier memvalidasi data
↓
Notifier memanggil SessionRepository.createSessionFromSchedule()
↓
Repository membuat data session
↓
Repository update status schedule menjadi Selesai
↓
Jika tipe pembayaran per sesi, repository membuat tagihan
↓
Database menyimpan semua perubahan dalam transaction
↓
Provider jadwal, sesi, pembayaran, dan dashboard otomatis update
```

### 8.3 Kenapa Perlu Transaction

Saat menyelesaikan sesi, ada beberapa data yang berubah sekaligus:

```text
sessions bertambah
schedules berubah status
payments/invoices bisa dibuat
dashboard berubah
```

Maka proses harus menggunakan database transaction agar data tidak setengah tersimpan.

```text
Mulai transaction
↓
Insert session
↓
Update schedule
↓
Create invoice jika diperlukan
↓
Commit transaction
```

Jika salah satu gagal:

```text
Rollback
↓
Data kembali seperti semula
```

---

## 9. Workflow Modul Pembayaran

### 9.1 Provider yang Digunakan

```text
paymentRepositoryProvider
unpaidInvoicesProvider
paidPaymentsProvider
paymentFormNotifierProvider
studentPaymentHistoryProvider
```

### 9.2 Alur Menampilkan Tagihan Belum Dibayar

```text
PaymentScreen dibuka
↓
UI watch unpaidInvoicesProvider
↓
Provider memanggil PaymentRepository.watchUnpaidInvoices()
↓
Repository query tagihan status belum dibayar
↓
Drift mengirim stream data
↓
UI menampilkan daftar tagihan belum dibayar
```

### 9.3 Alur Input Pembayaran

```text
Guru menerima pembayaran
↓
Buka detail tagihan
↓
Klik Catat Pembayaran
↓
Input nominal pembayaran
↓
Pilih metode pembayaran
↓
Klik Simpan
↓
paymentFormNotifier memvalidasi nominal
↓
Notifier memanggil PaymentRepository.insertPayment()
↓
Repository menyimpan pembayaran
↓
Repository menghitung total pembayaran untuk tagihan
↓
Jika sudah penuh, status tagihan menjadi Lunas
↓
Jika belum penuh, status tagihan menjadi Sebagian
↓
Database menyimpan perubahan
↓
Dashboard dan laporan otomatis update
```

### 9.4 Alur Pembayaran Sebagian

```text
Tagihan Rp800.000
↓
Siswa bayar Rp300.000
↓
Sistem mencatat pembayaran Rp300.000
↓
Total terbayar Rp300.000
↓
Sisa tagihan Rp500.000
↓
Status tagihan menjadi Sebagian
```

### 9.5 Alur Pelunasan

```text
Tagihan status Sebagian
↓
Siswa membayar sisa tagihan
↓
Sistem mencatat pembayaran baru
↓
Total pembayaran dihitung ulang
↓
Jika total pembayaran >= nominal tagihan
↓
Status tagihan menjadi Lunas
```

---

## 10. Workflow Modul Dashboard

### 10.1 Provider yang Digunakan

```text
dashboardRepositoryProvider
dashboardSummaryProvider
todayScheduleSummaryProvider
monthlyIncomeProvider
unpaidSummaryProvider
```

### 10.2 Alur Dashboard Realtime

```text
DashboardScreen dibuka
↓
UI watch dashboardSummaryProvider
↓
Provider memanggil DashboardRepository.watchSummary()
↓
Repository mengambil data dari beberapa tabel:
- students
- schedules
- sessions
- payments
- invoices
↓
Repository menggabungkan hasil query
↓
Provider mengirim summary ke UI
↓
Dashboard menampilkan ringkasan
```

### 10.3 Data yang Ditampilkan

```text
Total siswa aktif
Total jadwal hari ini
Total sesi selesai bulan ini
Total pendapatan bulan ini
Total tagihan belum dibayar
Jadwal terdekat
Siswa yang belum bayar
```

### 10.4 Alur Update Dashboard

```text
Guru menambah siswa
↓
studentsProvider update
↓
dashboardSummaryProvider update
↓
Total siswa aktif berubah
```

```text
Guru mencatat pembayaran
↓
paymentsProvider update
↓
dashboardSummaryProvider update
↓
Pendapatan bulan ini berubah
↓
Tagihan belum dibayar berkurang
```

---

## 11. Workflow Modul Laporan

### 11.1 Provider yang Digunakan

```text
reportRepositoryProvider
reportFilterProvider
incomeReportProvider
studentReportProvider
unpaidReportProvider
```

### 11.2 Alur Membuat Laporan Pendapatan

```text
Guru buka ReportScreen
↓
UI membaca reportFilterProvider
↓
Guru memilih periode tanggal
↓
UI watch incomeReportProvider(filter)
↓
Provider memanggil ReportRepository.getIncomeReport(filter)
↓
Repository query pembayaran berdasarkan tanggal
↓
Repository menghitung total
↓
Provider mengirim data laporan
↓
UI menampilkan laporan
```

### 11.3 Alur Filter Laporan

```text
User pilih filter:
- Hari ini
- Minggu ini
- Bulan ini
- Custom tanggal
- Per siswa
- Per mata pelajaran
↓
reportFilterProvider berubah
↓
incomeReportProvider rebuild
↓
Repository query ulang sesuai filter
↓
UI menampilkan laporan baru
```

### 11.4 Alur Export Laporan

```text
Guru memilih periode laporan
↓
Klik Export PDF atau Excel
↓
exportReportNotifier state menjadi loading
↓
Notifier memanggil ReportRepository.getReportData()
↓
Data laporan dikirim ke ExportService
↓
File dibuat
↓
State menjadi success
↓
UI menampilkan lokasi file / tombol share
```

---

## 12. Workflow Modul Backup dan Restore

### 12.1 Provider yang Digunakan

```text
backupRepositoryProvider
backupNotifierProvider
restoreNotifierProvider
lastBackupProvider
```

### 12.2 Alur Backup Data

```text
Guru buka menu Backup & Restore
↓
Klik Backup Data
↓
backupNotifier state menjadi loading
↓
Notifier memanggil BackupRepository.backupDatabase()
↓
Repository mengambil file database SQLite
↓
Repository membuat salinan file backup
↓
File diberi nama berdasarkan tanggal
↓
State menjadi success
↓
UI menampilkan pesan backup berhasil
```

### 12.3 Alur Restore Data

```text
Guru klik Restore Data
↓
Pilih file backup
↓
restoreNotifier state menjadi loading
↓
Notifier validasi file backup
↓
Aplikasi menutup koneksi database sementara
↓
File database lama diganti dengan file backup
↓
Database dibuka ulang
↓
Provider di-refresh
↓
UI menampilkan data hasil restore
```

### 12.4 Alur Reminder Backup

```text
Aplikasi membaca lastBackupProvider
↓
Jika backup terakhir lebih dari 7 hari
↓
Dashboard menampilkan warning
↓
Guru klik Backup Sekarang
↓
Workflow backup dijalankan
```

---

## 13. Workflow Error Handling

### 13.1 Error Saat Load Data

```text
Provider membaca data
↓
Terjadi error query/database
↓
Provider masuk AsyncError
↓
UI menampilkan pesan error
↓
User bisa klik Coba Lagi
```

UI state:

```text
Loading
Success
Empty
Error
```

### 13.2 Error Saat Simpan Data

```text
User klik Simpan
↓
Notifier state loading
↓
Repository gagal insert/update
↓
Notifier state error
↓
UI menampilkan pesan gagal
↓
Data form tidak hilang
↓
User bisa perbaiki dan simpan ulang
```

### 13.3 Error Saat Backup

```text
User klik Backup
↓
Storage tidak tersedia / permission gagal
↓
Notifier state error
↓
UI menampilkan alasan gagal
↓
User diarahkan memilih lokasi lain
```

---

## 14. Workflow Validasi Form

### 14.1 Validasi Tambah Siswa

```text
User klik Simpan
↓
Notifier validasi nama siswa
↓
Notifier validasi nomor WA opsional
↓
Notifier validasi tarif
↓
Jika valid, simpan data
↓
Jika tidak valid, tampilkan error
```

Validasi minimal:

| Field | Validasi |
|---|---|
| Nama siswa | Wajib |
| Mata pelajaran | Wajib |
| Tipe tarif | Wajib |
| Nominal tarif | Wajib jika tipe pembayaran aktif |
| Nomor WhatsApp | Opsional, tapi format dicek jika diisi |

---

### 14.2 Validasi Jadwal

| Field | Validasi |
|---|---|
| Siswa | Wajib |
| Mata pelajaran | Wajib |
| Tanggal | Wajib |
| Jam mulai | Wajib |
| Jam selesai | Wajib |
| Jam selesai | Harus lebih besar dari jam mulai |

---

### 14.3 Validasi Pembayaran

| Field | Validasi |
|---|---|
| Siswa/tagihan | Wajib |
| Nominal pembayaran | Wajib dan lebih dari 0 |
| Metode pembayaran | Wajib |
| Tanggal pembayaran | Wajib |

---

## 15. Contoh Provider Mapping

### 15.1 Global Provider

```text
databaseProvider
appSettingsProvider
themeProvider
routerProvider
```

### 15.2 Student Provider

```text
studentRepositoryProvider
studentsProvider
activeStudentsProvider
studentDetailProvider
studentFormNotifierProvider
```

### 15.3 Schedule Provider

```text
scheduleRepositoryProvider
selectedScheduleDateProvider
scheduleByDateProvider
todaySchedulesProvider
scheduleFormNotifierProvider
```

### 15.4 Session Provider

```text
sessionRepositoryProvider
sessionsProvider
studentSessionsProvider
sessionFormNotifierProvider
```

### 15.5 Payment Provider

```text
paymentRepositoryProvider
unpaidInvoicesProvider
paymentHistoryProvider
paymentFormNotifierProvider
```

### 15.6 Report Provider

```text
reportRepositoryProvider
reportFilterProvider
incomeReportProvider
unpaidReportProvider
exportReportNotifierProvider
```

### 15.7 Backup Provider

```text
backupRepositoryProvider
backupNotifierProvider
restoreNotifierProvider
lastBackupProvider
```

---

## 16. State yang Cocok untuk Tiap Fitur

| Fitur | Provider |
|---|---|
| Database instance | Provider |
| Repository | Provider |
| List siswa | StreamProvider |
| Detail siswa | FutureProvider / StreamProvider |
| Form siswa | AsyncNotifier |
| Jadwal hari ini | StreamProvider |
| Filter tanggal jadwal | Notifier |
| Simpan jadwal | AsyncNotifier |
| Riwayat sesi | StreamProvider |
| Catat sesi selesai | AsyncNotifier |
| Tagihan belum dibayar | StreamProvider |
| Input pembayaran | AsyncNotifier |
| Laporan pendapatan | FutureProvider / AsyncNotifier |
| Filter laporan | Notifier |
| Backup data | AsyncNotifier |
| Restore data | AsyncNotifier |

---

## 17. Workflow Transaction Penting

Beberapa proses wajib menggunakan transaction.

### 17.1 Tandai Sesi Selesai

```text
Transaction start
↓
Insert session
↓
Update schedule status
↓
Create invoice jika pembayaran per sesi
↓
Transaction commit
```

### 17.2 Catat Pembayaran

```text
Transaction start
↓
Insert payment
↓
Hitung total paid
↓
Update invoice status
↓
Transaction commit
```

### 17.3 Hapus / Nonaktifkan Siswa

```text
Transaction start
↓
Update student status menjadi nonaktif
↓
Update jadwal future jika diperlukan
↓
Transaction commit
```

---

## 18. Workflow Refresh Data

Karena data berasal dari database lokal reactive, refresh manual tidak wajib untuk semua halaman.

### 18.1 Data Stream

```text
Data berubah
↓
Stream dari Drift otomatis update
↓
Provider update
↓
UI rebuild
```

Cocok untuk:

```text
Siswa
Jadwal
Pembayaran
Dashboard
```

### 18.2 Data Future

```text
User memilih filter
↓
Provider melakukan query ulang
↓
UI menampilkan hasil
```

Cocok untuk:

```text
Laporan berat
Export
Backup information
```

---

## 19. Workflow Jika Nanti Ada Cloud Sync

MVP awal offline, tapi struktur ini bisa disiapkan untuk cloud sync.

### 19.1 Alur Sync Masa Depan

```text
Data dibuat di SQLite lokal
↓
Data diberi sync_status = pending
↓
Saat internet tersedia, SyncService berjalan
↓
Data pending dikirim ke server
↓
Server memberi response sukses
↓
sync_status berubah menjadi synced
```

### 19.2 Field Tambahan untuk Sync

```text
local_id
server_id
sync_status
created_at
updated_at
deleted_at
```

### 19.3 Status Sync

| Status | Keterangan |
|---|---|
| pending | Belum terkirim ke server |
| synced | Sudah sinkron |
| failed | Gagal sinkron |
| conflict | Ada konflik data |

---

## 20. Kesimpulan

Workflow state management yang direkomendasikan:

```text
UI
↓
Riverpod Provider / Notifier
↓
Repository
↓
Drift
↓
SQLite
```

Dengan pembagian ini, aplikasi menjadi:

- Rapi.
- Mudah dikembangkan.
- Cocok untuk offline-first.
- Reactive saat data berubah.
- Aman untuk laporan pendapatan.
- Siap dikembangkan ke cloud sync di masa depan.

Rekomendasi final:

```text
State Management: Riverpod
Database: Drift + SQLite
Pattern: Feature-based architecture
Data Flow: UI → Provider → Repository → Database
```
