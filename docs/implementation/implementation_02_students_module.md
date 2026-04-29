# Sprint 02 - Students Module

## Tujuan

Membuat modul master data siswa sebagai fondasi seluruh workflow. Siswa harus bisa ditambah, dilihat, diedit, dibuka detailnya, dan dinonaktifkan menggunakan soft delete/status nonaktif agar riwayat jadwal, sesi, dan pembayaran tetap aman.

## Dependency / Prasyarat

- Sprint 01 selesai.
- `students` table tersedia di Drift.
- `databaseProvider`, router, app shell, dan repository pattern sudah tersedia.
- Dashboard placeholder bisa dibuka.

## Output Akhir

- Guru bisa mengelola data siswa secara offline.
- Daftar siswa aktif tampil reactive dari SQLite.
- Form siswa melakukan validasi minimal.
- Detail siswa menampilkan biodata, tarif, status, dan catatan.
- Nonaktifkan siswa tidak menghapus riwayat.

## Struktur File Yang Akan Dibuat

```text
lib/features/students/
├── data/
│   └── student_repository.dart
├── providers/
│   └── student_provider.dart
├── screens/
│   ├── student_list_screen.dart
│   ├── student_form_screen.dart
│   └── student_detail_screen.dart
└── widgets/
    ├── student_card.dart
    ├── student_empty_state.dart
    └── student_status_chip.dart
```

## Data dan Status

| Field | Keterangan |
|---|---|
| `name` | Nama siswa, wajib |
| `parent_name` | Nama orang tua/wali |
| `whatsapp` | Nomor WA untuk komunikasi dan pembayaran |
| `address` | Alamat siswa |
| `school` | Nama sekolah |
| `grade` | Kelas siswa |
| `default_subject` | Mata pelajaran utama awal |
| `rate_type` | `per_session`, `monthly`, atau `package` |
| `rate_amount` | Nominal tarif default |
| `status` | `pending`, `active`, atau `inactive` |
| `note` | Catatan belajar |
| `deleted_at` | Diisi hanya jika soft delete diperlukan |

## Provider Yang Dibuat

- `studentRepositoryProvider` sebagai dependency injection repository.
- `studentsProvider` untuk semua siswa non-deleted.
- `activeStudentsProvider` untuk siswa aktif.
- `studentDetailProvider(studentId)` untuk detail siswa.
- `studentFormNotifierProvider` untuk tambah dan edit siswa.
- `studentStatusFilterProvider` jika list membutuhkan filter status.

## Urutan Implementasi / Checklist

- [ ] Lengkapi field `students` di Drift sesuai kebutuhan master data.
- [ ] Buat `StudentRepository.watchStudents()` untuk stream semua siswa non-deleted.
- [ ] Buat `StudentRepository.watchActiveStudents()` untuk siswa status aktif.
- [ ] Buat `StudentRepository.watchStudentById(id)` atau `getStudentById(id)` untuk detail.
- [ ] Buat `StudentRepository.insertStudent()` untuk tambah siswa.
- [ ] Buat `StudentRepository.updateStudent()` untuk edit siswa.
- [ ] Buat `StudentRepository.deactivateStudent()` untuk status `inactive`.
- [ ] Buat `StudentRepository.softDeleteStudent()` hanya jika benar-benar butuh menghilangkan dari list.
- [ ] Buat provider dan notifier sesuai mapping.
- [ ] Tambahkan route list, form tambah, form edit, dan detail siswa.
- [ ] Buat `StudentListScreen` yang membaca `activeStudentsProvider` secara reactive.
- [ ] Buat empty state ketika belum ada siswa.
- [ ] Buat `StudentFormScreen` untuk tambah/edit dengan validasi nama, mata pelajaran, rate type, rate amount, dan format WA jika diisi.
- [ ] Buat `StudentDetailScreen` yang menampilkan data orang tua, sekolah, tarif, status, dan catatan.
- [ ] Tambahkan aksi nonaktifkan siswa dengan dialog konfirmasi.
- [ ] Update dashboard summary agar jumlah siswa aktif membaca data asli.

## Validasi Form

- [ ] Nama siswa wajib diisi.
- [ ] Mata pelajaran awal wajib diisi untuk siswa aktif.
- [ ] Tipe tarif wajib dipilih.
- [ ] Nominal tarif wajib lebih dari 0 jika tipe pembayaran aktif.
- [ ] Nomor WA boleh kosong, tetapi jika diisi harus berupa angka dengan panjang wajar.
- [ ] Status default siswa baru adalah `active` atau `pending` sesuai pilihan form.

## Acceptance Criteria

- [ ] Guru bisa tambah siswa dan data muncul di daftar tanpa restart aplikasi.
- [ ] Guru bisa edit siswa dan perubahan tampil di list/detail secara reactive.
- [ ] Guru bisa membuka detail siswa.
- [ ] Guru bisa menonaktifkan siswa tanpa menghapus row database.
- [ ] Siswa nonaktif tidak muncul di picker siswa aktif untuk jadwal Sprint 03.
- [ ] Dashboard menampilkan jumlah siswa aktif dari database.
- [ ] Tidak ada akses database langsung dari widget.
