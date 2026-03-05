# Registrasi Event App

Aplikasi Flutter untuk mengelola pendaftaran peserta event. Pengguna dapat mengisi form registrasi secara bertahap, melihat daftar peserta yang sudah terdaftar, melakukan pencarian dan filter, mengedit data, serta melihat detail tiap peserta. Seluruh state dikelola menggunakan **Provider** sehingga perubahan data langsung tercermin di semua bagian UI tanpa perlu reload manual.

---

## Struktur Folder

```
lib/
├── models/
│   └── registrant_model.dart
├── providers/
│   └── registration_provider.dart
├── pages/
│   ├── registration_page.dart
│   ├── registrant_list_page.dart
│   ├── registrant_detail_page.dart
│   └── edit_registrant_page.dart
└── main.dart
```

---

## Fitur Aplikasi

### Form Registrasi Multi-Step
Form pendaftaran dibagi menjadi tiga langkah menggunakan widget `Stepper`. Setiap langkah divalidasi sebelum pengguna bisa melanjutkan ke langkah berikutnya, sehingga tidak ada data yang terlewat.

- **Step 1 - Akun:** Input nama lengkap, email, dan password. Password memiliki toggle show/hide. Email dicek duplikasinya sebelum lanjut ke step berikutnya.
- **Step 2 - Profil:** Pilih jenis kelamin menggunakan `RadioListTile`, program studi menggunakan `DropdownButtonFormField`, dan tanggal lahir menggunakan `DatePicker`.
- **Step 3 - Konfirmasi:** Menampilkan ringkasan semua data yang diisi sebelum submit, disertai checkbox persetujuan syarat dan ketentuan.

### Daftar Pendaftar
Menampilkan semua peserta yang sudah terdaftar menggunakan `ListView`. Jumlah peserta ditampilkan secara real-time di app bar melalui `Consumer`. Setiap item memiliki tombol edit dan hapus. Tombol hapus menampilkan dialog konfirmasi sebelum data benar-benar dihapus.

### Pencarian dan Filter
- Search bar di bagian atas halaman memfilter daftar secara real-time berdasarkan nama, email, atau program studi.
- Tombol filter membuka bottom sheet dengan `ChoiceChip` untuk memfilter berdasarkan jenis kelamin dan program studi.
- Filter yang sedang aktif ditampilkan sebagai chip di bawah search bar dan bisa dihapus satu per satu.
- Terdapat keterangan jumlah hasil yang ditampilkan dari total seluruh peserta.

### Edit Data Pendaftar
Halaman edit menampilkan form yang sudah terisi otomatis dengan data pendaftar yang dipilih. Saat menyimpan, validasi email duplikat tetap berjalan namun mengecualikan email milik peserta itu sendiri. Waktu registrasi asli tidak berubah meskipun data diperbarui.

### Detail Pendaftar
Menampilkan informasi lengkap satu peserta dalam tampilan card, meliputi avatar inisial nama, email, jenis kelamin, program studi, tanggal lahir, umur yang dihitung otomatis, dan waktu registrasi.

---

## Penjelasan Komponen

### Registrant (Model)
Menyimpan seluruh data satu peserta. Memiliki tiga getter tambahan: `age` untuk menghitung umur berdasarkan tanggal lahir saat ini, `formattedDateOfBirth` untuk format tanggal yang mudah dibaca, dan `formattedRegisteredAt` untuk format waktu registrasi.

### RegistrationProvider
Kelas utama yang mengelola state aplikasi dengan meng-extend `ChangeNotifier`. Menyimpan list peserta secara internal dan mengeksposnya sebagai `List.unmodifiable` agar tidak bisa dimodifikasi dari luar. Setiap operasi CRUD memanggil `notifyListeners()` agar UI otomatis diperbarui.

| Method | Fungsi |
|---|---|
| `addRegistrant` | Menambahkan peserta baru ke list |
| `removeRegistrant` | Menghapus peserta berdasarkan ID |
| `updateRegistrant` | Mengganti data peserta yang sudah ada |
| `getById` | Mengambil satu peserta berdasarkan ID |
| `isEmailRegistered` | Mengecek apakah email sudah terdaftar, dengan opsi `excludeId` untuk keperluan edit |

### Halaman dan Navigasi
Aplikasi menggunakan named routes yang didefinisikan di `main.dart`. Perpindahan antar halaman menggunakan `Navigator.pushNamed` dengan argumen berupa ID peserta untuk halaman detail dan edit.

| Route | Halaman |
|---|---|
| `/` | Form registrasi (RegistrationPage) |
| `/list` | Daftar pendaftar (RegistrantListPage) |
| `/detail` | Detail peserta (RegistrantDetailPage) |
| `/edit` | Edit data peserta (EditRegistrantPage) |

---

## Teknologi yang digunakan

- Flutter & Dart
- Provider ^6.0.5

---
