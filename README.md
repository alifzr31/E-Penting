# 📱 E-Penting (Elektronik Pendataan Stunting)

<p align="center">
  <b>Aplikasi Pendataan, Pemantauan Gizi, dan Pencegahan Stunting Balita</b><br>
  Pemerintah Kota Bandung
</p>

<p align="center">
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
   - Pencatatan pengukuran rutin (Berat Badan, Tinggi/Panjang Badan, Cara Ukur, Lingkar Kepala/Lengan).
   - Pencatatan jadwal dan riwayat pemberian imunisasi/vitamin (Buku KIA Digital).
   - Melihat ringkasan statistik dan rekapitulasi gizi balita posyandu.

2. **Orang Tua Balita** (Login via *NIK 16 Digit & Password*)
   - Memantau grafik pertumbuhan tinggi dan berat badan anak terhadap kurva standar WHO/Kemenkes.
   - Melihat klasifikasi status stunting anak secara otomatis (*Normal, Pendek, Sangat Pendek, Tinggi*).
   - Melihat riwayat penimbangan dan jadwal imunisasi yang sudah/belum diterima.
   - Login cepat dan aman menggunakan sensor Biometrik (*Fingerprint / Face Unlock*).

---

## ✨ Fitur Utama

- 📊 **Kalkulator & Klasifikasi Stunting Otomatis**: Menghitung status gizi secara instan berdasarkan umur bulan, jenis kelamin, tinggi badan, dan metode pengukuran (terlentang / berdiri).
- 📈 **Grafik Tumbuh Kembang (Growth Chart)**: Visualisasi visual riwayat pengukuran berkala anak.
- 💉 **Buku KIA Digital & Imunisasi**: Jadwal pemberian vaksin wajib balita terstruktur berdasarkan kelompok usia bulan.
- 🔐 **Dual Storage & Keamanan Biometrik**: Autentikasi biometrik terlindungi oleh hardware-backed Keystore (*Android Keystore & iOS Keychain*) dengan penanganan *graceful fallback*.
- 🛡️ **SSL Pinning**: Komunikasi data ke REST API diamankan dengan certificate pinning SHA-256 fingerprint.
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
  - [`shared_preferences`](https://pub.dev/packages/shared_preferences) (Status onboarding)
  - [`encrypt`](https://pub.dev/packages/encrypt) & [`crypto`](https://pub.dev/packages/crypto)
- **Firebase Suite**: [`firebase_core`](https://pub.dev/packages/firebase_core), [`firebase_messaging`](https://pub.dev/packages/firebase_messaging), [`firebase_remote_config`](https://pub.dev/packages/firebase_remote_config)
- **Notifikasi Lokal**: [`flutter_local_notifications`](https://pub.dev/packages/flutter_local_notifications)
- **UI Components**: [`fl_chart`](https://pub.dev/packages/fl_chart), [`skeletonizer`](https://pub.dev/packages/skeletonizer), [`toastification`](https://pub.dev/packages/toastification), [`loader_overlay`](https://pub.dev/packages/loader_overlay), [`remix_icons_flutter`](https://pub.dev/packages/remix_icons_flutter)
- **Environment**: [`envied`](https://pub.dev/packages/envied)

---

## 🚀 Memulai (Getting Started)

### Prasyarat
- Flutter SDK `^3.13.2` atau lebih baru
- Dart SDK `^3.13.2`
- Android Studio / VS Code dengan Flutter extension
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

Dikembangkan dan dikelola untuk **Pemerintah Kota Bandung** guna mendukung program kesehatan nasional pencegahan stunting pada balita.
