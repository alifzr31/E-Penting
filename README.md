# 📱 E-Penting (Elektronik Pendataan Stunting)

<p align="center">
  <b>Aplikasi Pendataan, Pemantauan Gizi, dan Pencegahan Stunting Balita</b><br>
  Pemerintah Kota Bandung
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Version-3.0.0%2B39-orange" alt="Version">
  <img src="https://img.shields.io/badge/Flutter-3.24%2B-02569B?logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.13%2B-0175C2?logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/State%20Management-BLoC%20%2F%20Cubit-blue" alt="BLoC">
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-brightgreen" alt="Platform">
  <img src="https://img.shields.io/badge/License-Proprietary-red" alt="License">
</p>

---

## 📌 Tentang E-Penting

**E-Penting (Elektronik Pendataan Stunting)** adalah aplikasi mobile resmi yang dikembangkan untuk mendukung program percepatan penurunan dan pencegahan stunting pada balita di wilayah **Kota Bandung**. 

Aplikasi ini mendigitalisasi proses pencatatan data antropometri di tingkat Posyandu, memberikan visualisasi grafik tumbuh kembang anak secara *real-time*, serta memudahkan orang tua dalam memantau jadwal imunisasi dan status gizi putra-putrinya.

---

## 👥 Pengguna Aplikasi

Aplikasi menyediakan dua jenis akses berdasarkan peran pengguna:

1. **Kader Posyandu** (Login via *Username & Password*)
   - Pendaftaran dan pembaruan data balita di wilayah kerja posyandu.
   - Pencatatan pengukuran rutin (Berat Badan, Tinggi/Panjang Badan, Cara Ukur, Lingkar Kepala/Lengan, Vit A, Pitting Edema, Kelas Ibu Balita, dan MBG).
   - Pencatatan jadwal dan riwayat pemberian imunisasi/vitamin (Buku KIA Digital).
   - Melihat ringkasan statistik dan rekapitulasi gizi balita posyandu.
   - Pengisian survei kepuasan layanan berkala berbasis platform SPBE digital Kota Bandung.

2. **Orang Tua Balita** (Login via *NIK 16 Digit & Password*)
   - Aktivasi akun mandiri via NIK orang tua untuk inisialisasi login pertama kali.
   - Memantau grafik pertumbuhan tinggi dan berat badan anak terhadap kurva standar WHO/Kemenkes.
   - Melihat klasifikasi status stunting anak secara otomatis (*Normal, Pendek, Sangat Pendek, Tinggi*).
   - Melihat riwayat penimbangan dan jadwal imunisasi yang sudah/belum diterima.
   - Login cepat dan aman menggunakan sensor Biometrik (*Fingerprint / Face Unlock*).

---

## ✨ Fitur Utama

- 📊 **Kalkulator & Klasifikasi Stunting Otomatis**: Menghitung status gizi secara instan berdasarkan umur bulan, jenis kelamin, tinggi badan, dan metode pengukuran (terlentang / berdiri).
- 📈 **Grafik Tumbuh Kembang (Growth Chart)**: Visualisasi riwayat pengukuran berkala anak dengan sistem *smart inset fitting* agar tooltip tidak terpotong.
- 💉 **Buku KIA Digital & Imunisasi**: Jadwal pemberian vaksin wajib balita terstruktur berdasarkan kelompok usia bulan.
- 📖 **Buku KIA Interaktif & Panduan Pertumbuhan**: Panduan digital pencegahan stunting interaktif dengan gesture *pinch-to-zoom*, *pan*, dan animasi matriks.
- 🔑 **Aktivasi Akun Mandiri Orang Tua**: Verifikasi NIK orang tua dan aktivasi akun instan langsung dari aplikasi tanpa registrasi manual.
- 📝 **Survei Kepuasan Layanan SPBE**: Integrasi kuesioner evaluasi posyandu terintegrasi sistem SPBE Kota Bandung via WebView dengan deteksi otomatis status pengisian.
- 🔐 **Dual Storage & Keamanan Biometrik**: Autentikasi biometrik terlindungi oleh hardware-backed Keystore (*Android Keystore & iOS Keychain*) dengan penanganan *graceful fallback*.
- 🛡️ **SSL Pinning**: Komunikasi data ke REST API diamankan dengan certificate pinning SHA-256 fingerprint.
- 🚫 **Role Guard & Halaman Forbidden**: Proteksi halaman antarmuka terhadap sesi atau hak akses yang tidak sah.
- 🔔 **Notifikasi Terintegrasi**: Push notification (FCM) untuk pengingat jadwal posyandu serta notifikasi lokal.
- 🔄 **In-App Force Update**: Pengecekan versi minimum aplikasi via Firebase Remote Config untuk memastikan pengguna selalu memakai versi terbaru yang aman.

---

## 🛠️ Tech Stack & Arsitektur

### Arsitektur
Proyek menerapkan **Clean Architecture** yang disederhanakan:
```
UI Layer (Page/View) ──> Business Logic (Cubit) ──> Repository Layer ──> Data Layer (Service/Dio/Storage)
```

### Dependencies Utama
- **State Management**: [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) / [`bloc`](https://pub.dev/packages/bloc) (Pattern Cubit)
- **Networking**: [`dio`](https://pub.dev/packages/dio), [`pretty_dio_logger`](https://pub.dev/packages/pretty_dio_logger)
- **Dependency Injection**: [`get_it`](https://pub.dev/packages/get_it)
- **Storage & Security**:
  - [`flutter_secure_storage`](https://pub.dev/packages/flutter_secure_storage) (Token JWT & data profil terenkripsi)
  - [`biometric_storage`](https://pub.dev/packages/biometric_storage) & [`local_auth`](https://pub.dev/packages/local_auth) (Hardware-backed biometric)
  - [`shared_preferences`](https://pub.dev/packages/shared_preferences) (Status onboarding & timestamp survei)
  - [`encrypt`](https://pub.dev/packages/encrypt) & [`crypto`](https://pub.dev/packages/crypto)
- **Firebase Suite**: [`firebase_core`](https://pub.dev/packages/firebase_core), [`firebase_messaging`](https://pub.dev/packages/firebase_messaging), [`firebase_remote_config`](https://pub.dev/packages/firebase_remote_config)
- **Notifikasi Lokal**: [`flutter_local_notifications`](https://pub.dev/packages/flutter_local_notifications)
- **Webview**: [`flutter_inappwebview`](https://pub.dev/packages/flutter_inappwebview)
- **UI Components**: [`fl_chart`](https://pub.dev/packages/fl_chart), [`skeletonizer`](https://pub.dev/packages/skeletonizer), [`toastification`](https://pub.dev/packages/toastification), [`loader_overlay`](https://pub.dev/packages/loader_overlay), [`remix_icons_flutter`](https://pub.dev/packages/remix_icons_flutter), [`easy_stepper`](https://pub.dev/packages/easy_stepper), [`dropdown_button2`](https://pub.dev/packages/dropdown_button2)
- **Environment**: [`envied`](https://pub.dev/packages/envied)

---

## 🗺️ Alur Navigasi & Daftar Rute Halaman

<details>
<summary><b>Lihat Seluruh Daftar Rute Aplikasi (16 Routes)</b></summary>
<br>

| Konstanta Rute | Path URL | Argumen / Parameter | Deskripsi & Fungsi Halaman |
|:---|:---|:---|:---|
| `RouteName.splash` | `/` | `-` | Splash screen, inisialisasi Firebase Remote Config, & auto-login |
| `RouteName.forbidden` | `/forbidden` | `-` | Layar penolakan akses jika hak akses pengguna tidak sah |
| `RouteName.update` | `/update` | `-` | Layar wajib pembaruan aplikasi jika versi terpasang usang |
| `RouteName.onboard` | `/onboard` | `-` | Slider carousel pengenalan aplikasi (muncul pada instalasi pertama) |
| `RouteName.login` | `/login` | `-` | Form autentikasi Kader (Username) & Orang Tua Balita (NIK) |
| `RouteName.activation` | `/activation` | `-` | Form aktivasi akun mandiri via NIK orang tua balita |
| `RouteName.nutrition` | `/nutrition` | `-` | Kalkulator mandiri status gizi dan klasifikasi stunting balita |
| `RouteName.dashboard` | `/dashboard` | `-` | Beranda utama aplikasi (grafik, rekapitulasi data, & menu utama) |
| `RouteName.detailGuide` | `/detail_guide` | `imageName: String?` | Panduan digital Buku KIA interaktif dengan gesture zoom/pan |
| `RouteName.createToddler` | `/create_toddler` | `-` | Pendaftaran balita baru / konfirmasi balita pindahan posyandu |
| `RouteName.editToddler` | `/edit_toddler` | `toddlerId: int` | Form pembaruan profil data balita |
| `RouteName.createMeasurement` | `/create_measurement` | `-` | Form pencatatan penimbangan & antropometri balita baru |
| `RouteName.editMeasurement` | `/edit_measurement` | `measurementId: int` | Form edit catatan penimbangan balita |
| `RouteName.createImmunization` | `/create_immunization` | `-` | Form pencatatan riwayat imunisasi balita baru |
| `RouteName.editImmunization` | `/edit_immunization` | `immunizationId: int` | Form edit riwayat imunisasi balita |
| `RouteName.survey` | `/survey` | `-` | Modul WebView survei kepuasan layanan posyandu digital (SPBE) |

</details>

---

## 🌐 Dokumentasi API Endpoint

Komunikasi data dengan REST API dikelola secara terpusat melalui `DioClient` dengan autentikasi otomatis `Bearer <access_token>` melalui header:
```http
Authorization: Bearer <access_token>
```

<details>
<summary><b>1. 🔐 Autentikasi & Sesi Pengguna</b></summary>
<br>

| Method | Endpoint | Parameter / Payload | Deskripsi & Fungsi |
|:---:|:---|:---|:---|
| `POST` | `/login` | **Body**: `username`, `password` | Autentikasi sesi kader atau orang tua balita |
| `POST` | `/logout` | - | Mengakhiri sesi pengguna dan invalidasi token |

</details>

<details>
<summary><b>2. 👶 Pendataan Balita</b></summary>
<br>

| Method | Endpoint | Parameter / Payload | Deskripsi & Fungsi |
|:---:|:---|:---|:---|
| `GET` | `/balita/latest-nik` | **Query**: `nik` | Data balita terkini (khusus role orang tua) |
| `GET` | `/balita/latest` | - | Daftar balita terbaru yang terdaftar di posyandu |
| `GET` | `/balita/list` | **Query**: `page`, `sorting` *(rentang usia)* | Daftar seluruh balita dengan pagination dan filter usia |
| `GET` | `/balita/search` | **Query**: `name` | Pencarian data balita berdasarkan nama |
| `GET` | `/balita/detail` | **Query**: `id` | Detail lengkap profil satu balita |
| `GET` | `/balita/pindah/search` | **Query**: `name` | Pencarian balita untuk proses mutasi/pindah posyandu |
| `POST` | `/balita/cek-nik` | **Body**: `nik` | Validasi ketersediaan atau duplikasi NIK balita di sistem |
| `POST` | `/balita/create` | **Body**: *Payload data anak, orang tua, & domisili* | Mendaftarkan data balita baru |
| `PATCH` | `/balita/pindah` | **Query**: `id_identitas` | Konfirmasi mutasi/pindah posyandu balita |
| `PATCH` | `/balita` | **Query**: `id`<br>**Body**: *Payload pembaruan data balita* | Memperbarui informasi data profil balita |

</details>

<details>
<summary><b>3. 📏 Pengukuran & Antropometri</b></summary>
<br>

| Method | Endpoint | Parameter / Payload | Deskripsi & Fungsi |
|:---:|:---|:---|:---|
| `GET` | `/penimbangan/history` | **Query**: `nik` | Riwayat lengkap catatan pengukuran berkala balita |
| `GET` | `/penimbangan/chart/tinggi` | **Query**: `nik` | Koordinat titik data grafik pertumbuhan tinggi/panjang badan |
| `GET` | `/penimbangan/chart/berat` | **Query**: `nik` | Koordinat titik data grafik pertumbuhan berat badan |
| `GET` | `/penimbangan/latest` | - | Daftar pencatatan pengukuran terbaru di posyandu |
| `GET` | `/penimbangan/list` | **Query**: `page`, `month`, `year` | Daftar penimbangan dengan pagination & filter bulan/tahun |
| `GET` | `/penimbangan/search` | **Query**: `name` | Pencarian riwayat penimbangan berdasarkan nama balita |
| `GET` | `/penimbangan/detail` | **Query**: `id_penimbangan` | Detail lengkap satu catatan penimbangan antropometri |
| `POST` | `/penimbangan` | **Body**: *Payload data antropometri, gizi, vitamin A, pitting edema, kelas ibu balita, & MBG* | Input catatan penimbangan balita baru |
| `PATCH` | `/penimbangan` | **Query**: `id_pengukuran`<br>**Body**: *Payload update data penimbangan* | Memperbarui catatan penimbangan balita |

</details>

<details>
<summary><b>4. 💉 Pencatatan Imunisasi</b></summary>
<br>

| Method | Endpoint | Parameter / Payload | Deskripsi & Fungsi |
|:---:|:---|:---|:---|
| `GET` | `/imunisasi/history-nik` | **Query**: `nik` | Riwayat vaksin wajib yang telah diterima balita |
| `GET` | `/imunisasi/latest` | - | Daftar catatan imunisasi terbaru di posyandu |
| `GET` | `/imunisasi/list` | **Query**: `page`, `month`, `year` | Daftar imunisasi dengan pagination & filter bulan/tahun |
| `GET` | `/imunisasi/search` | **Query**: `name` | Pencarian catatan imunisasi berdasarkan nama balita |
| `GET` | `/imunisasi/detail` | **Query**: `id_imunisasi` | Detail satu catatan pemberian imunisasi |
| `POST` | `/imunisasi` | **Body**: *Payload status boolean vaksin* | Mencatat riwayat imunisasi baru |
| `PATCH` | `/imunisasi` | **Query**: `id_imunisasi`<br>**Body**: *Payload update* | Mengedit riwayat catatan imunisasi balita |

</details>

<details>
<summary><b>5. 🥗 Klasifikasi Gizi & Stunting</b></summary>
<br>

| Method | Endpoint | Parameter / Payload | Deskripsi & Fungsi |
|:---:|:---|:---|:---|
| `GET` | `/classification` | **Query**: `umur_bulan`, `tinggi`, `cara_ukur`, `jenis_kelamin` | Menghitung klasifikasi status stunting tinggi/panjang badan |
| `GET` | `/berat-badan` | **Query**: `umur_bulan`, `jenis_kelamin`, `berat` | Menghitung klasifikasi status berat badan balita |
| `GET` | `/gizi` | **Query**: `umur_bulan`, `tinggi`, `berat`, `jenis_kelamin`, `cara_ukur` | Menghitung klasifikasi status gizi menyeluruh (BB/TB) |

</details>

<details>
<summary><b>6. 📊 Statistik Dashboard</b></summary>
<br>

| Method | Endpoint | Parameter / Payload | Deskripsi & Fungsi |
|:---:|:---|:---|:---|
| `GET` | `/percentage` | - | Mengambil ringkasan persentase data stunting posyandu |

</details>

<details>
<summary><b>7. 🔑 Aktivasi Akun Orang Tua</b></summary>
<br>

| Method | Endpoint | Parameter / Payload | Deskripsi & Fungsi |
|:---:|:---|:---|:---|
| `POST` | `/orangtua/check` | **Body**: `nik_orangtua` | Cek validasi, status aktif, dan verifikasi NIK orang tua di sistem |
| `POST` | `/orangtua/activate` | **Body**: `nik_orangtua` | Mengaktifkan akun orang tua agar dapat login dengan kredensial default |

</details>

---

## 🚀 Memulai (Getting Started)

### Prasyarat
- Flutter SDK `^3.24.0` atau lebih baru
- Dart SDK `^3.13.2`
- Android Studio / VS Code dengan ekstensi Flutter & Dart
- JDK 17 (untuk Android build)

### 1. Clone Repositori
```bash
git clone <url-repository>
cd e_penting
```

### 2. Konfigurasi Environment (`.env`)
Buat berkas `.env` di direktori *root* proyek:
```env
BASE_URL=https://<domain-backend>
BASE_API_URL=https://<domain-backend>/api
EPENTING_SIGNATURE=XX:XX:XX:... # SHA-256 Fingerprint SSL Certificate
```

Jalankan code generator untuk membuat file `app_env.g.dart`:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Konfigurasi Firebase
Pastikan file konfigurasi Firebase lokal sudah tersedia:
- Android: `android/app/google-services.json`
- Flutter Options: `lib/app/configs/firebase/firebase_options.dart`

*(Catatan: File konfigurasi kredensial ini dijaga di luar version control publik untuk keamanan).*

### 4. Unduh Dependensi & Jalankan
```bash
flutter pub get
flutter run
```

---

## 📦 Panduan Build Rilis (Android)

Build rilis Android telah dikonfigurasi dengan **R8 Code Shrinking, Resource Shrinking, dan Obfuscation** (`isMinifyEnabled = true`, `isShrinkResources = true`). Seluruh aturan proteksi plugin native telah terdefinisi di [`android/app/proguard-rules.pro`](file:///Users/alifzr/Documents/Developer%20Project/Flutter/e_penting/android/app/proguard-rules.pro).

### 1. Konfigurasi Keystore
Pastikan file `android/keystore.properties` telah dikonfigurasi:
```properties
keyAlias=<nama-alias>
keyPassword=<password-key>
storeFile=<path-ke-file.jks>
storePassword=<password-keystore>
```

### 2. Kompilasi APK / AppBundle
```bash
# Build APK rilis:
flutter build apk --release

# Build Android App Bundle (AAB) untuk Google Play Store:
flutter build appbundle --release
```

---

## 📂 Struktur Direktori Proyek

```
lib/
├── main.dart                          # Entry point aplikasi
└── app/
    ├── configs/                       # Konfigurasi Dio, Storage, Router, Firebase, DI
    ├── cubits/                        # State management BLoC/Cubit per modul fitur
    ├── models/                        # Data models (JSON Serializable & Equatable)
    ├── repositories/                  # Abstraksi data layer & AppException mapper
    ├── services/                      # HTTP Service dengan CancelToken & StorageService
    ├── utils/                         # Enums, Consts, Helpers, Extensions, Formatters
    ├── views/                         # UI Screens (Page & View terpisah)
    └── widgets/                       # Reusable Shared Base Widgets
```

---

## 🏛️ Hak Cipta & Pengembang

Dikembangkan dan dikelola oleh [**Alif ZR**](https://github.com/alifzr31) untuk **Pemerintah Kota Bandung** guna mendukung program kesehatan nasional pencegahan stunting pada balita.

Copyright © 2026 [**Alif ZR**](https://github.com/alifzr31). All rights reserved.
