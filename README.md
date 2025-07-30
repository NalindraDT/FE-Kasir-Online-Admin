# Frontend Kasir Online Admin

[![GitHub](https://img.shields.io/badge/GitHub-NalindraDT%2FFE--Kasir--Online--Admin-blue?style=flat&logo=github)](https://github.com/NalindraDT/FE-Kasir-Online-Admin)

Repositori ini berisi kode *frontend* untuk aplikasi Kasir Online Admin, yang dibangun menggunakan *framework* Flutter. Aplikasi ini dirancang untuk berinteraksi dengan *backend* Laravel untuk mengelola data produk.

## Daftar Isi

1.  [Tentang Proyek](#tentang-proyek)
2.  [Fitur Aplikasi](#fitur-aplikasi)
3.  [Teknologi yang Digunakan](#teknologi-yang-digunakan)
4.  [Instalasi dan Setup](#instalasi-dan-setup)
5.  [Konfigurasi API Backend](#konfigurasi-api-backend)
6.  [Kredensial Login Statis](#kredensial-login-statis)
7.  [Backend Terkait](#backend-terkait)
8.  [Kontribusi](#kontribusi)
9.  [Lisensi](#lisensi)

## Tentang Proyek

Aplikasi Kasir Online Admin adalah sistem *mobile* sederhana yang memungkinkan administrator untuk mengelola data produk di rumah makan. Aplikasi ini menyediakan antarmuka pengguna yang intuitif untuk melakukan operasi CRUD (Create, Read, Update, Delete) pada data produk yang disimpan di *backend* Laravel.

## Fitur Aplikasi

* **Splash Screen Awal:** Tampilan pembuka aplikasi selama 5 detik.
* **Halaman Login:** Antarmuka untuk login administrator dengan kredensial statis.
* **Welcome Splash Screen:** Tampilan selamat datang singkat setelah login berhasil.
* **Dashboard Admin:** Menu utama dengan opsi untuk "Lihat Produk", "Input Produk", dan "Informasi Aplikasi".
* **Lihat Produk:** Menampilkan daftar produk dengan nama dan harga, diambil dari API backend.
* **Detail Produk:** Menampilkan informasi lengkap produk (nama, harga, stok, tanggal dibuat/diperbarui).
* **Input Produk:** Formulir untuk menambahkan produk baru ke database melalui API.
* **Edit Produk:** Formulir untuk mengubah detail produk yang sudah ada melalui API.
* **Hapus Produk:** Fungsionalitas untuk menghapus produk dari database melalui API.
* **Halaman Informasi:** Menyajikan deskripsi singkat tentang aplikasi.

## Teknologi yang Digunakan

* **Bahasa Pemrograman:** Dart
* **Framework UI:** Flutter (SDK Version: [Isi Versi Flutter Anda, contoh: 3.x.x])
* **Manajemen Paket:** `pub` (Flutter's package manager)
* **HTTP Client:** `http` package
* **Formatting Tanggal:** `intl` package
* **Emulator/Testing:** Android Studio Emulator

## Instalasi dan Setup

Ikuti langkah-langkah di bawah ini untuk menjalankan aplikasi Flutter di lingkungan lokal Anda:

1.  **Pastikan Flutter SDK Terinstal:**
    Jika Anda belum menginstal Flutter SDK, ikuti panduan resmi di [Flutter Documentation](https://flutter.dev/docs/get-started/install).

2.  **Clone Repositori:**
    Buka terminal atau Git Bash dan *clone* repositori ini:
    ```bash
    git clone [https://github.com/NalindraDT/FE-Kasir-Online-Admin.git](https://github.com/NalindraDT/FE-Kasir-Online-Admin.git)
    ```
    Masuk ke direktori proyek:
    ```bash
    cd FE-Kasir-Online-Admin
    ```

3.  **Instal Dependensi Flutter:**
    Unduh semua paket Dart yang diperlukan:
    ```bash
    flutter pub get
    ```

4.  **Siapkan Aset (Opsional):**
    Jika Anda menggunakan logo kustom (`dimas.png`) di halaman login, pastikan Anda menempatkannya di folder `assets/` di *root* proyek Anda.
    ```
    FE-Kasir-Online-Admin/
    ├── assets/
    │   └── dimas.png
    └── ...
    ```
    Dan pastikan `assets/` dideklarasikan di `pubspec.yaml` Anda:
    ```yaml
    flutter:
      uses-material-design: true
      assets:
        - assets/
    ```

5.  **Jalankan Aplikasi:**
    Pastikan emulator Android Anda berjalan atau perangkat fisik terhubung. Kemudian, jalankan aplikasi:
    ```bash
    flutter run
    ```

## Konfigurasi API Backend

Aplikasi ini terhubung ke *backend* Laravel. Anda perlu memastikan *backend* Anda berjalan dan dapat diakses oleh aplikasi Flutter.

* **URL API Dasar:**
    URL dasar untuk API backend dikonfigurasi di *file* `lib/product_list_screen.dart`, `lib/product_input_screen.dart`, dan `lib/product_edit_screen.dart`. Secara *default*, ini diatur ke:
    `http://127.0.0.1:8000/api/produk`

* **Jika Anda Menggunakan IP Lokal:**
    Jika *backend* Laravel Anda berjalan di IP lokal (misalnya `http://192.168.1.xxx:8000`), pastikan Anda memperbarui `_baseUrl` di ketiga *file* Flutter tersebut.
    Contoh: `final String _baseUrl = 'http://192.168.1.xxx:8000/api/produk';`

* **Pastikan Backend Berjalan:**
    Sebelum menjalankan aplikasi Flutter, pastikan *server* Laravel Anda berjalan di alamat IP dan *port* yang benar. Anda bisa menjalankannya dengan:
    ```bash
    php artisan serve --host=[IP_ANDA] --port=8000
    ```
    (Ganti `[IP_ANDA]` dengan IP lokal Anda atau `127.0.0.1` jika menggunakan *localhost*).

## Kredensial Login Statis

Untuk tujuan demonstrasi dan sertifikasi, aplikasi ini menggunakan *login* statis (hardcoded).

* **Email:** `admin@kasir.com`
* **Password:** `password`

## Backend Terkait

Aplikasi *frontend* ini mengkonsumsi API yang disediakan oleh *backend* Laravel. Anda dapat menemukan repositori *backend* di:

* [Link Repositori Backend Anda di GitHub] (Misal: `https://github.com/NalindraDT/BE-Kasir-Online-Admin.git`)

## Kontribusi

Kontribusi dipersilakan! Jika Anda menemukan *bug* atau memiliki saran fitur, silakan buka *issue* atau kirimkan *pull request*.

## Lisensi

Proyek ini dilisensikan di bawah Lisensi MIT.