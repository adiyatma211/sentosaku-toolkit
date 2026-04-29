# Workflow Aplikasi Offline untuk Freelance Guru & Guru Private

## 1. Ringkasan Aplikasi

Aplikasi ini dibuat untuk membantu **freelance guru, guru private, tutor rumahan, dan pengajar bimbel kecil** dalam mengelola aktivitas operasional harian secara offline.

Masalah utama yang diselesaikan:

- Data siswa masih dicatat di Excel atau kertas.
- Jadwal les masih dikelola manual.
- Riwayat pertemuan tidak terdokumentasi rapi.
- Pembayaran siswa sulit dipantau.
- Laporan pendapatan masih dihitung manual.
- Guru sering kesulitan melihat tagihan yang belum dibayar.
- Data mudah hilang karena tersebar di banyak file atau catatan.

Solusi aplikasi:

> Aplikasi Flutter offline-first untuk mengelola data siswa, jadwal les, absensi pertemuan, pembayaran, laporan pendapatan, dan backup data tanpa bergantung internet.

---

## 2. Aktor Utama

### 2.1 Guru / Tutor

Guru adalah pengguna utama aplikasi.

Guru dapat:

- Menambahkan data siswa.
- Mengatur jadwal les.
- Mencatat kehadiran siswa.
- Mencatat materi pembelajaran.
- Mencatat pembayaran.
- Melihat laporan pendapatan.
- Melakukan backup dan restore data.

### 2.2 Siswa

Siswa adalah data yang dikelola oleh guru.

Data siswa berisi:

- Nama siswa.
- Nama orang tua/wali.
- Nomor WhatsApp.
- Alamat.
- Sekolah.
- Kelas.
- Mata pelajaran.
- Tarif les.
- Status aktif atau nonaktif.

### 2.3 Orang Tua / Wali

Orang tua/wali tidak perlu login di MVP awal.

Data orang tua digunakan untuk:

- Kontak pembayaran.
- Kontak reminder jadwal.
- Informasi komunikasi guru dengan keluarga siswa.

---

## 3. Workflow Utama Aplikasi

```text
Guru buka aplikasi
↓
Guru input data siswa
↓
Guru input mata pelajaran dan tarif
↓
Guru membuat jadwal les
↓
Jadwal tersimpan di kalender lokal
↓
Aplikasi memberi reminder sebelum sesi dimulai
↓
Guru menjalankan sesi les
↓
Guru mencatat absensi dan materi pembelajaran
↓
Sistem menyimpan riwayat pertemuan
↓
Sistem membuat atau memperbarui tagihan
↓
Guru mencatat pembayaran siswa
↓
Sistem memperbarui status pembayaran
↓
Guru melihat laporan pendapatan
↓
Guru export laporan atau backup data
```

---

# 4. Workflow Detail Per Modul

---

## 4.1 Workflow Onboarding Awal

Tujuan onboarding adalah menyiapkan data dasar aplikasi saat pertama kali digunakan.

### Alur

```text
Install aplikasi
↓
Buka aplikasi pertama kali
↓
Input profil guru
↓
Input nama usaha / nama private
↓
Input nomor WhatsApp guru
↓
Input mata pelajaran default
↓
Input tarif default opsional
↓
Masuk ke dashboard
```

### Data yang Diinput

| Data | Keterangan |
|---|---|
| Nama guru | Nama pengguna aplikasi |
| Nama usaha/private | Contoh: Haris Private Class |
| Nomor WhatsApp | Untuk identitas invoice/laporan |
| Mata pelajaran default | Contoh: Matematika, Bahasa Inggris |
| Tarif default | Opsional |

### Output

- Profil guru tersimpan.
- Aplikasi siap digunakan.
- Dashboard dapat menampilkan data awal.

---

## 4.2 Workflow Master Data Siswa

Modul ini menggantikan pencatatan data siswa di Excel atau kertas.

### Alur Tambah Siswa

```text
Guru buka menu Siswa
↓
Klik Tambah Siswa
↓
Input biodata siswa
↓
Input data orang tua/wali
↓
Input mata pelajaran
↓
Input tipe tarif
↓
Simpan data
↓
Siswa muncul di daftar siswa aktif
```

### Data Siswa

| Field | Contoh |
|---|---|
| Nama siswa | Andi Pratama |
| Nama orang tua/wali | Bapak Budi |
| Nomor WhatsApp | 081234567890 |
| Alamat | Jl. Merdeka No. 10 |
| Sekolah | SMP Negeri 1 |
| Kelas | 8 |
| Mata pelajaran | Matematika |
| Tipe tarif | Per sesi |
| Nominal tarif | Rp100.000 |
| Status | Aktif |
| Catatan | Lemah di aljabar |

### Status Siswa

| Status | Fungsi |
|---|---|
| Aktif | Masih mengikuti les |
| Nonaktif | Tidak lagi mengikuti les |
| Pending | Calon siswa / trial |

### Output

- Data siswa tersimpan di database lokal.
- Siswa bisa dipilih saat membuat jadwal.
- Siswa bisa dipilih saat membuat tagihan/pembayaran.

---

## 4.3 Workflow Jadwal Les

Modul jadwal digunakan untuk mengatur waktu belajar siswa.

### Alur Buat Jadwal

```text
Guru buka menu Jadwal
↓
Klik Tambah Jadwal
↓
Pilih siswa
↓
Pilih mata pelajaran
↓
Input tanggal
↓
Input jam mulai dan jam selesai
↓
Pilih tipe jadwal
↓
Simpan jadwal
↓
Jadwal muncul di kalender
```

### Tipe Jadwal

| Tipe | Keterangan |
|---|---|
| Sekali | Jadwal hanya 1 kali pertemuan |
| Mingguan | Jadwal berulang setiap minggu |
| Custom | Jadwal manual sesuai tanggal tertentu |

### Status Jadwal

| Status | Keterangan |
|---|---|
| Terjadwal | Jadwal sudah dibuat |
| Selesai | Sesi sudah dilaksanakan |
| Batal | Sesi dibatalkan |
| Reschedule | Jadwal dipindah |
| Tidak Hadir | Siswa tidak hadir |

### Alur Reminder Jadwal

```text
Jadwal tersimpan
↓
Sistem membuat reminder lokal
↓
Waktu mendekati jadwal
↓
Aplikasi menampilkan notifikasi
↓
Guru membuka detail jadwal
↓
Guru menjalankan sesi les
```

### Output

- Jadwal tersimpan offline.
- Guru dapat melihat jadwal harian, mingguan, dan bulanan.
- Guru mendapat reminder sebelum sesi dimulai.

---

## 4.4 Workflow Pertemuan / Sesi Les

Modul ini mencatat realisasi dari jadwal les.

### Alur Setelah Les Selesai

```text
Guru buka jadwal hari ini
↓
Pilih jadwal siswa
↓
Klik Tandai Selesai
↓
Input absensi
↓
Input materi yang diajarkan
↓
Input PR atau tugas
↓
Input catatan perkembangan siswa
↓
Simpan sesi
↓
Sistem membuat riwayat pertemuan
↓
Sistem memperbarui status jadwal menjadi selesai
```

### Data Pertemuan

| Field | Contoh |
|---|---|
| Tanggal sesi | 29 April 2026 |
| Nama siswa | Andi Pratama |
| Mata pelajaran | Matematika |
| Jam mulai | 08:00 |
| Jam selesai | 09:30 |
| Materi | Persamaan linear |
| PR | Latihan halaman 20 |
| Kehadiran | Hadir |
| Catatan | Masih perlu latihan soal cerita |
| Biaya sesi | Rp100.000 |
| Status bayar | Belum dibayar |

### Status Kehadiran

| Status | Keterangan |
|---|---|
| Hadir | Siswa mengikuti les |
| Izin | Siswa izin |
| Tidak hadir | Siswa tidak hadir |
| Batal | Sesi dibatalkan |
| Diganti jadwal | Sesi dipindahkan |

### Output

- Riwayat pertemuan tersimpan.
- Data bisa digunakan untuk laporan belajar.
- Data bisa digunakan untuk perhitungan tagihan.

---

## 4.5 Workflow Pembayaran

Modul pembayaran digunakan untuk mencatat uang masuk dari siswa.

### Model Pembayaran

| Model | Contoh |
|---|---|
| Per sesi | Rp100.000 setiap pertemuan |
| Bulanan | Rp800.000 per bulan |
| Paket | Rp700.000 untuk 8 pertemuan |

---

### 4.5.1 Workflow Pembayaran Per Sesi

```text
Sesi les selesai
↓
Sistem membuat tagihan berdasarkan tarif sesi
↓
Status pembayaran: Belum dibayar
↓
Guru menerima pembayaran
↓
Guru buka detail tagihan
↓
Input nominal pembayaran
↓
Pilih metode pembayaran
↓
Simpan pembayaran
↓
Status berubah menjadi Lunas
```

### 4.5.2 Workflow Pembayaran Bulanan

```text
Awal bulan / periode tagihan
↓
Guru membuat tagihan bulanan
↓
Pilih siswa
↓
Input bulan dan nominal tagihan
↓
Simpan tagihan
↓
Status: Belum dibayar
↓
Guru menerima pembayaran
↓
Input pembayaran
↓
Status berubah menjadi Lunas
```

### 4.5.3 Workflow Pembayaran Paket

```text
Guru membuat paket belajar
↓
Input jumlah pertemuan
↓
Input harga paket
↓
Siswa membayar paket
↓
Paket aktif
↓
Setiap sesi selesai, kuota paket berkurang
↓
Jika kuota habis, sistem memberi tanda paket selesai
```

### Metode Pembayaran

| Metode | Keterangan |
|---|---|
| Cash | Pembayaran tunai |
| Transfer | Transfer bank |
| E-wallet | Dana, OVO, GoPay, ShopeePay |
| Lainnya | Metode lain |

### Status Pembayaran

| Status | Keterangan |
|---|---|
| Belum dibayar | Tagihan belum dibayar |
| Sebagian | Baru dibayar sebagian |
| Lunas | Tagihan sudah lunas |
| Dibatalkan | Tagihan tidak berlaku |

### Output

- Pembayaran tersimpan.
- Status tagihan berubah otomatis.
- Pendapatan bertambah di laporan.
- Guru bisa melihat siswa yang belum membayar.

---

## 4.6 Workflow Laporan Pendapatan

Modul laporan digunakan untuk melihat performa pendapatan guru.

### Alur Lihat Laporan

```text
Guru buka menu Laporan
↓
Pilih periode laporan
↓
Sistem mengambil data pembayaran
↓
Sistem menghitung total pendapatan
↓
Sistem menampilkan ringkasan
↓
Guru dapat export laporan
```

### Filter Laporan

| Filter | Keterangan |
|---|---|
| Hari ini | Pendapatan hari berjalan |
| Minggu ini | Pendapatan minggu berjalan |
| Bulan ini | Pendapatan bulan berjalan |
| Custom tanggal | Periode sesuai pilihan guru |
| Per siswa | Laporan per nama siswa |
| Per mata pelajaran | Laporan berdasarkan mapel |
| Belum dibayar | Tagihan outstanding |

### Isi Laporan

| Komponen | Keterangan |
|---|---|
| Total pendapatan | Total pembayaran diterima |
| Total tagihan | Total tagihan dibuat |
| Tagihan belum dibayar | Outstanding payment |
| Jumlah sesi selesai | Total pertemuan terlaksana |
| Siswa aktif | Jumlah siswa aktif |
| Pendapatan per siswa | Breakdown siswa |
| Pendapatan per mapel | Breakdown mata pelajaran |

### Output

- Guru mengetahui pendapatan aktual.
- Guru mengetahui tagihan belum dibayar.
- Guru bisa export PDF/Excel.
- Guru bisa membuat rekap bulanan.

---

## 4.7 Workflow Export Laporan

Export digunakan agar guru tetap bisa menyimpan laporan dalam bentuk dokumen.

### Alur Export PDF

```text
Guru buka menu Laporan
↓
Pilih periode laporan
↓
Klik Export PDF
↓
Sistem membuat file PDF
↓
Guru menyimpan atau membagikan file
```

### Alur Export Excel

```text
Guru buka menu Laporan
↓
Pilih periode laporan
↓
Klik Export Excel
↓
Sistem membuat file .xlsx
↓
Guru menyimpan atau membagikan file
```

### Jenis Export

| Jenis | Fungsi |
|---|---|
| PDF | Laporan rapi untuk dibagikan |
| Excel | Data mentah untuk diolah lagi |
| CSV | Alternatif ringan untuk backup data |

### Output

- File laporan bisa dikirim ke WhatsApp/email.
- Guru tetap bisa menyimpan arsip eksternal.
- Data tidak hanya terkunci di aplikasi.

---

## 4.8 Workflow Backup dan Restore

Karena aplikasi offline, backup wajib tersedia agar data tidak hilang.

### Alur Backup Manual

```text
Guru buka menu Backup & Restore
↓
Klik Backup Data
↓
Sistem membuat file backup database
↓
Guru memilih lokasi penyimpanan
↓
File backup tersimpan
```

### Alur Restore

```text
Guru buka menu Backup & Restore
↓
Klik Restore Data
↓
Pilih file backup
↓
Sistem validasi file
↓
Data lama diganti / digabung sesuai aturan
↓
Aplikasi memuat ulang data
```

### Opsi Lokasi Backup

| Lokasi | Keterangan |
|---|---|
| Penyimpanan internal HP | Backup lokal |
| Google Drive manual | Guru upload sendiri |
| WhatsApp Document | Guru kirim ke diri sendiri |
| Laptop/PC | Dipindahkan manual |

### Aturan Penting

- Backup harus bisa dilakukan tanpa internet.
- File backup harus jelas tanggalnya.
- Restore harus menampilkan konfirmasi sebelum mengganti data.
- Aplikasi perlu memberi warning jika guru belum pernah backup.

### Contoh Nama File Backup

```text
backup_private_teacher_2026-04-29.db
backup_private_teacher_2026-04-29.zip
```

### Output

- Data lebih aman.
- Guru bisa pindah HP.
- Risiko kehilangan data lebih kecil.

---

# 5. Workflow Dashboard

Dashboard adalah halaman utama setelah aplikasi dibuka.

## Isi Dashboard

```text
Pendapatan Bulan Ini
Tagihan Belum Dibayar
Siswa Aktif
Jadwal Hari Ini
Jadwal Minggu Ini
Pertemuan Belum Selesai
Reminder Pembayaran
```

## Alur Dashboard

```text
Guru buka aplikasi
↓
Sistem membaca database lokal
↓
Sistem menghitung ringkasan
↓
Dashboard menampilkan informasi terbaru
↓
Guru bisa langsung membuka jadwal atau pembayaran
```

## Contoh Layout Dashboard

```text
Dashboard
------------------------------------------------
Pendapatan Bulan Ini      Rp3.500.000
Tagihan Belum Dibayar     Rp750.000
Siswa Aktif               12
Jadwal Hari Ini           4 sesi

Jadwal Hari Ini
08:00 - 09:30  Matematika - Andi
13:00 - 14:30  Bahasa Inggris - Sinta
16:00 - 17:30  Fisika - Raka

Tagihan Belum Dibayar
Andi      Rp200.000
Sinta     Rp300.000
Raka      Rp250.000
```

---

# 6. Workflow Status Data

## 6.1 Status Siswa

```text
Pending → Aktif → Nonaktif
```

| Status | Keterangan |
|---|---|
| Pending | Calon siswa atau trial |
| Aktif | Siswa masih belajar |
| Nonaktif | Siswa berhenti |

---

## 6.2 Status Jadwal

```text
Terjadwal → Selesai
Terjadwal → Batal
Terjadwal → Reschedule
Terjadwal → Tidak Hadir
```

| Status | Keterangan |
|---|---|
| Terjadwal | Sesi sudah dibuat |
| Selesai | Sesi sudah terlaksana |
| Batal | Jadwal dibatalkan |
| Reschedule | Jadwal dipindah |
| Tidak Hadir | Siswa tidak hadir |

---

## 6.3 Status Pembayaran

```text
Belum Dibayar → Sebagian → Lunas
Belum Dibayar → Dibatalkan
```

| Status | Keterangan |
|---|---|
| Belum Dibayar | Tagihan belum dibayar |
| Sebagian | Dibayar sebagian |
| Lunas | Tagihan sudah dibayar penuh |
| Dibatalkan | Tagihan tidak jadi ditagihkan |

---

# 7. Workflow Berdasarkan Use Case

---

## 7.1 Use Case: Guru Menambah Siswa Baru

```text
Guru menerima siswa baru
↓
Buka menu Siswa
↓
Klik Tambah Siswa
↓
Isi data siswa dan orang tua
↓
Isi mata pelajaran
↓
Isi tarif
↓
Simpan
↓
Siswa masuk daftar aktif
```

Hasil:

- Siswa bisa dibuatkan jadwal.
- Siswa bisa dibuatkan tagihan.
- Siswa muncul di laporan.

---

## 7.2 Use Case: Guru Membuat Jadwal Les

```text
Guru buka menu Jadwal
↓
Klik Tambah Jadwal
↓
Pilih siswa
↓
Pilih tanggal dan jam
↓
Pilih mata pelajaran
↓
Pilih jadwal sekali atau berulang
↓
Simpan
↓
Jadwal muncul di kalender
```

Hasil:

- Guru dapat melihat jadwal.
- Reminder lokal aktif.
- Jadwal bisa ditandai selesai setelah les.

---

## 7.3 Use Case: Guru Menyelesaikan Sesi Les

```text
Guru membuka jadwal hari ini
↓
Pilih jadwal siswa
↓
Klik Tandai Selesai
↓
Isi materi pembelajaran
↓
Isi catatan siswa
↓
Isi status kehadiran
↓
Simpan
↓
Sistem membuat riwayat sesi
↓
Sistem membuat tagihan jika diperlukan
```

Hasil:

- Riwayat pembelajaran tersimpan.
- Pendapatan/tagihan bisa dihitung.
- Status jadwal berubah menjadi selesai.

---

## 7.4 Use Case: Guru Mencatat Pembayaran

```text
Guru menerima pembayaran
↓
Buka menu Pembayaran
↓
Pilih tagihan siswa
↓
Input nominal pembayaran
↓
Pilih metode pembayaran
↓
Simpan
↓
Status tagihan diperbarui
```

Hasil:

- Pendapatan bertambah.
- Status tagihan bisa berubah menjadi lunas.
- Data masuk laporan pendapatan.

---

## 7.5 Use Case: Guru Melihat Siswa yang Belum Bayar

```text
Guru buka menu Pembayaran
↓
Pilih filter Belum Dibayar
↓
Sistem menampilkan daftar tagihan outstanding
↓
Guru melihat nama siswa dan nominal tagihan
↓
Guru dapat menghubungi orang tua/wali
```

Hasil:

- Guru tahu siapa saja yang belum bayar.
- Guru bisa melakukan follow-up pembayaran.

---

## 7.6 Use Case: Guru Membuat Laporan Bulanan

```text
Guru buka menu Laporan
↓
Pilih filter Bulan Ini
↓
Sistem menampilkan ringkasan pendapatan
↓
Guru klik Export PDF / Excel
↓
File laporan dibuat
↓
Guru menyimpan file laporan
```

Hasil:

- Guru punya rekap pendapatan bulanan.
- Data bisa digunakan untuk arsip pribadi.
- Guru tidak perlu menghitung manual di Excel.

---

## 7.7 Use Case: Guru Backup Data

```text
Guru buka menu Backup & Restore
↓
Klik Backup Data
↓
Sistem membuat file backup
↓
Guru menyimpan file di HP atau cloud manual
↓
Backup selesai
```

Hasil:

- Data lebih aman.
- Guru bisa restore saat ganti HP.
- Risiko kehilangan data berkurang.

---

# 8. Workflow MVP Versi 1

MVP versi 1 fokus pada fungsi yang paling penting.

## Fitur MVP

```text
1. Dashboard
2. Master data siswa
3. Jadwal les
4. Riwayat pertemuan
5. Pembayaran
6. Laporan pendapatan sederhana
7. Backup dan restore manual
```

## Fitur yang Ditunda

```text
1. Login akun
2. Cloud sync
3. Multi-device
4. Portal orang tua
5. Payment gateway
6. Chat internal
7. Marketplace guru
8. Video meeting
```

## Alur MVP

```text
Input siswa
↓
Buat jadwal
↓
Tandai sesi selesai
↓
Catat pembayaran
↓
Lihat laporan
↓
Backup data
```

---

# 9. Workflow Offline-First

Karena aplikasi dirancang offline, semua data utama tersimpan di perangkat.

## Prinsip Offline-First

```text
Aplikasi tetap bisa digunakan tanpa internet
↓
Semua data tersimpan di SQLite lokal
↓
Operasi CRUD berjalan di perangkat
↓
Laporan dihitung dari database lokal
↓
Backup dilakukan manual oleh pengguna
↓
Cloud sync dapat ditambahkan di versi berikutnya
```

## Data yang Wajib Offline

| Data | Offline |
|---|---|
| Data siswa | Ya |
| Jadwal | Ya |
| Pertemuan | Ya |
| Pembayaran | Ya |
| Laporan | Ya |
| Backup | Ya |
| Reminder | Ya |

## Risiko dan Solusi

| Risiko | Solusi |
|---|---|
| HP rusak | Backup manual berkala |
| Data terhapus | Restore dari file backup |
| Ganti HP | Import file backup |
| Tidak ada internet | Aplikasi tetap berjalan |
| Lupa backup | Reminder backup mingguan |

---

# 10. Rekomendasi Prioritas Development

## Sprint 1: Setup Project dan Database

Target:

- Setup Flutter project.
- Setup local database.
- Buat struktur tabel.
- Buat halaman dashboard awal.

Output:

```text
Project Flutter siap
Database lokal siap
Struktur tabel utama siap
```

---

## Sprint 2: Modul Siswa

Target:

- List siswa.
- Tambah siswa.
- Edit siswa.
- Detail siswa.
- Nonaktifkan siswa.

Output:

```text
Guru bisa mengelola data siswa secara offline
```

---

## Sprint 3: Modul Jadwal

Target:

- List jadwal.
- Tambah jadwal.
- Edit jadwal.
- Status jadwal.
- Tampilan jadwal harian/mingguan.

Output:

```text
Guru bisa mengelola jadwal les
```

---

## Sprint 4: Modul Pertemuan

Target:

- Tandai jadwal selesai.
- Input materi.
- Input absensi.
- Input catatan.
- Buat riwayat sesi.

Output:

```text
Setiap sesi les terdokumentasi
```

---

## Sprint 5: Modul Pembayaran

Target:

- Buat tagihan.
- Input pembayaran.
- Status lunas/belum.
- Filter belum bayar.

Output:

```text
Guru bisa memantau pembayaran siswa
```

---

## Sprint 6: Modul Laporan

Target:

- Laporan pendapatan harian.
- Laporan pendapatan bulanan.
- Laporan per siswa.
- Laporan tagihan belum dibayar.

Output:

```text
Guru bisa melihat pendapatan tanpa hitung manual
```

---

## Sprint 7: Backup, Restore, dan Export

Target:

- Backup database.
- Restore database.
- Export PDF.
- Export Excel.

Output:

```text
Data aman dan laporan bisa dibagikan
```

---

# 11. Rekomendasi Struktur Menu

```text
Dashboard
├── Ringkasan pendapatan
├── Jadwal hari ini
├── Tagihan belum dibayar
└── Siswa aktif

Siswa
├── Daftar siswa
├── Tambah siswa
├── Detail siswa
└── Riwayat siswa

Jadwal
├── Kalender
├── Jadwal hari ini
├── Tambah jadwal
└── Riwayat jadwal

Pertemuan
├── Daftar sesi
├── Detail sesi
├── Absensi
└── Catatan materi

Pembayaran
├── Daftar tagihan
├── Tambah pembayaran
├── Belum dibayar
└── Riwayat pembayaran

Laporan
├── Pendapatan harian
├── Pendapatan bulanan
├── Laporan per siswa
└── Export laporan

Backup & Restore
├── Backup data
├── Restore data
└── Riwayat backup

Pengaturan
├── Profil guru
├── Mata pelajaran
├── Tarif default
└── Reminder
```

---

# 12. Kesimpulan Workflow

Workflow utama aplikasi ini sederhana:

```text
Kelola siswa
↓
Kelola jadwal
↓
Catat sesi belajar
↓
Catat pembayaran
↓
Lihat laporan pendapatan
↓
Backup data
```

Aplikasi ini sebaiknya dibangun sebagai **Flutter offline-first app** dengan database lokal. MVP awal tidak perlu backend dan tidak perlu login, karena fokus utama adalah menyelesaikan masalah operasional guru secara cepat.

Fitur paling penting untuk versi awal:

1. Data siswa.
2. Jadwal les.
3. Riwayat pertemuan.
4. Pembayaran.
5. Laporan pendapatan.
6. Backup dan restore.

Dengan workflow ini, guru private/freelance bisa berpindah dari pencatatan manual ke sistem digital yang lebih rapi, cepat, dan aman.
