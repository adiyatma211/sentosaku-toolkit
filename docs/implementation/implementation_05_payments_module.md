# Sprint 05 - Payments Module

## Tujuan

Membuat modul tagihan dan pembayaran setelah sesi tersedia. Sprint ini mencakup invoices, payments, pembayaran sebagian, pelunasan, due date, reminder invoice lokal, filter tagihan belum dibayar, dan transaction untuk update status invoice.

## Dependency / Prasyarat

- Sprint 01 sampai Sprint 04 selesai.
- Invoice per sesi bisa dibuat dari sesi billable.
- Table `invoices` dan `payments` tersedia.
- Dashboard sudah membaca data siswa, jadwal, dan sesi.

## Output Akhir

- Guru bisa melihat daftar tagihan belum dibayar.
- Guru bisa mencatat pembayaran cash, transfer, e-wallet, atau lainnya.
- Pembayaran sebagian mengubah status invoice menjadi `partial`.
- Pelunasan mengubah status invoice menjadi `paid`.
- Tagihan punya tanggal jatuh tempo dan status reminder yang bisa ditindaklanjuti.
- Semua update payment dan invoice berjalan dalam transaction.

## Struktur File Yang Akan Dibuat

```text
lib/features/payments/
├── data/
│   └── payment_repository.dart
├── providers/
│   └── payment_provider.dart
├── screens/
│   ├── invoice_list_screen.dart
│   ├── invoice_detail_screen.dart
│   └── payment_form_screen.dart
└── widgets/
    ├── invoice_card.dart
    ├── invoice_status_chip.dart
    ├── payment_history_tile.dart
    └── unpaid_empty_state.dart
```

## Data Invoice dan Payment

| Tabel | Field | Keterangan |
|---|---|---|
| `invoices` | `student_id` | Pemilik tagihan |
| `invoices` | `session_id` | Sumber tagihan jika dari sesi |
| `invoices` | `period_label` | Label periode, contoh `April 2026` |
| `invoices` | `amount` | Total tagihan |
| `invoices` | `paid_amount` | Total terbayar hasil akumulasi |
| `invoices` | `status` | `unpaid`, `partial`, `paid`, `cancelled` |
| `invoices` | `due_date` | Tanggal jatuh tempo tagihan |
| `invoices` | `last_reminded_at` | Waktu reminder terakhir dikirim/ditampilkan |
| `payments` | `invoice_id` | Tagihan yang dibayar |
| `payments` | `amount` | Nominal pembayaran |
| `payments` | `method` | `cash`, `transfer`, `ewallet`, `other` |
| `payments` | `paid_at` | Tanggal pembayaran |
| `payments` | `note` | Catatan pembayaran |

## Provider Yang Dibuat

- `paymentRepositoryProvider`.
- `unpaidInvoicesProvider` untuk tagihan `unpaid` dan `partial`.
- `invoiceDetailProvider(invoiceId)`.
- `paymentHistoryProvider(invoiceId)`.
- `studentPaymentHistoryProvider(studentId)`.
- `paymentFormNotifierProvider` untuk catat pembayaran.
- `dueSoonInvoicesProvider` untuk tagihan mendekati jatuh tempo.
- `overdueInvoicesProvider` untuk tagihan lewat jatuh tempo.

## Scope Reminder Invoice

- Reminder invoice bersifat lokal/offline-first dan membaca `due_date`, `status`, serta `last_reminded_at`.
- Reminder hanya berlaku untuk invoice `unpaid` dan `partial`.
- Minimal ada dua kondisi reminder: `due_soon` dan `overdue`.
- Saat invoice menjadi `paid` atau `cancelled`, reminder aktif wajib dinonaktifkan atau ditandai selesai.
- Modul ini belum mengirim pesan otomatis ke WhatsApp; yang wajib adalah daftar follow-up, notifikasi lokal, dan log reminder.

## Transaction Wajib

```text
Transaction start
Insert payment
Hitung total payment untuk invoice
Update invoices.paid_amount
Update invoices.status menjadi unpaid/partial/paid
Transaction commit
```

## Urutan Implementasi / Checklist

- [ ] Lengkapi table `invoices` dengan `paid_amount`, `status`, dan `due_date` jika belum ada.
- [ ] Tambahkan `last_reminded_at` atau field log referensi reminder pada table `invoices`.
- [ ] Lengkapi table `payments` dengan method, tanggal, dan note.
- [ ] Buat query invoice join student dan session untuk list.
- [ ] Buat `PaymentRepository.watchUnpaidInvoices()`.
- [ ] Buat `PaymentRepository.watchDueSoonInvoices()` dan `watchOverdueInvoices()`.
- [ ] Buat `PaymentRepository.watchInvoiceDetail(invoiceId)`.
- [ ] Buat `PaymentRepository.watchPaymentHistory(invoiceId)`.
- [ ] Buat `PaymentRepository.insertPayment()` dengan transaction.
- [ ] Di transaction, validasi nominal pembayaran lebih dari 0.
- [ ] Di transaction, cegah pembayaran ke invoice status `paid` atau `cancelled` kecuali ada aturan koreksi.
- [ ] Hitung ulang total terbayar dari tabel `payments`, bukan hanya menambah angka dari input.
- [ ] Update status invoice: `unpaid` jika 0, `partial` jika kurang dari amount, `paid` jika total >= amount.
- [ ] Buat service/contract reminder invoice untuk schedule, refresh, dan close reminder berdasarkan due date dan status invoice.
- [ ] Buat `InvoiceListScreen` dengan filter unpaid dan all.
- [ ] Buat `InvoiceDetailScreen` menampilkan tagihan, due date, status reminder, sisa bayar, dan riwayat pembayaran.
- [ ] Buat `PaymentFormScreen` untuk input nominal, metode, tanggal, dan catatan.
- [ ] Update dashboard agar pendapatan bulan ini, tagihan belum dibayar, dan reminder invoice membaca invoice/payment asli.

## Validasi Form

- [ ] Invoice wajib dipilih.
- [ ] Nominal pembayaran wajib lebih dari 0.
- [ ] Nominal pembayaran boleh kurang dari sisa tagihan untuk partial payment.
- [ ] Metode pembayaran wajib dipilih.
- [ ] Tanggal pembayaran wajib diisi.
- [ ] Jika nominal melebihi sisa tagihan, sistem harus punya keputusan jelas: tolak atau izinkan sebagai overpayment. MVP disarankan menolak.
- [ ] Due date wajib terisi untuk invoice manual atau invoice bulanan yang membutuhkan follow-up.

## Acceptance Criteria

- [ ] Tagihan dari sesi muncul di daftar pembayaran.
- [ ] Guru bisa mencatat pembayaran sebagian.
- [ ] Status invoice berubah menjadi `partial` saat belum lunas.
- [ ] Status invoice berubah menjadi `paid` saat total pembayaran memenuhi tagihan.
- [ ] Invoice mendekati jatuh tempo dan lewat jatuh tempo bisa difilter untuk follow-up.
- [ ] Dashboard pendapatan bulan ini berubah setelah pembayaran dicatat.
- [ ] Dashboard tagihan belum dibayar berkurang setelah invoice lunas.
- [ ] Reminder invoice ditutup atau tidak lagi aktif saat tagihan lunas.
- [ ] Semua proses payment dan invoice update atomic.
