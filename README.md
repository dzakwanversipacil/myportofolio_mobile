# MyPortfolio Mobile

A personal portfolio mobile application
developed using Flutter.

## Features

- Personal information cards
- Portfolio action buttons
- Individual button background colors
- Interactive SnackBar notifications

## Tech Stack

- Flutter
- Dart
- Material Design 3

## Project Structure

lib/
├── main.dart
└── menu.dart

## Setup and Installation

1. Clone the repository.
2. Run flutter pub get.
3. Run flutter analyze.
4. Run flutter run.

## Individual Assignment Reflections

### Tugas 7

1. _Widget tree_ merupakan struktur hierarkis yang menggambarkan hubungan antar-_widget_ dalam sebuah aplikasi Flutter. Setiap _widget_ dapat memiliki satu atau lebih _widget_ lain sebagai _child_, sehingga membentuk struktur seperti _tree_. _Parent widget_ bertanggung jawab mengatur _layout_, konfigurasi, maupun _behavior_ dari _widget_ _child_-nya.

2. Widget yang digunakan dalam proyek portofolio versi _mobile_ ini beserta fungsinya adalah sebagai berikut:

- MyApp: Widget utama yang menjadi titik awal struktur aplikasi dan mengatur konfigurasi dasar melalui MaterialApp.
- MaterialApp: Menyediakan konfigurasi aplikasi berbasis Material Design, termasuk tema, judul, dan halaman awal.
- MyHomePage: Widget halaman utama yang menampilkan informasi pemilik portofolio dan menu navigasi. Widget ini menggunakan StatelessWidget karena tidak mengelola state internal yang berubah secara dinamis.
- Scaffold: Menyediakan struktur dasar halaman aplikasi, seperti AppBar dan area konten utama.
- AppBar: Menampilkan bilah navigasi pada bagian atas aplikasi yang berisi judul MyPortfolio.
- Padding: Memberikan jarak di antara batas halaman dan konten agar tampilan lebih rapi.
- Column: Menyusun beberapa widget anak secara vertikal.
- Row: Menyusun widget anak secara horizontal, seperti tiga kartu informasi profil.
- InfoCard: Widget kustom yang digunakan untuk menampilkan informasi NPM, nama, dan kelas dalam bentuk kartu.
- Card: Menampilkan informasi profil dalam bentuk kartu dengan efek elevasi atau bayangan.
- Container: Menyediakan wadah untuk mengatur ukuran, padding, dan tata letak konten.
- SizedBox: Memberikan jarak atau ruang kosong dengan ukuran tertentu di antara widget.
- Center: Menempatkan widget anak pada posisi tengah area yang tersedia.
- GridView.count: Menampilkan kumpulan kartu menu dalam bentuk grid dengan jumlah kolom yang telah ditentukan.
- ItemCard: Widget kustom yang merepresentasikan tombol aksi portofolio dan menangani interaksi ketika kartu ditekan.
- Material: Menyediakan permukaan visual untuk kartu menu, termasuk warna latar dan bentuk sudut.
- InkWell: Memberikan kemampuan interaksi sentuhan (tap) pada kartu menu.
- Icon: Menampilkan ikon yang merepresentasikan setiap aksi, seperti melihat proyek, menambahkan proyek, dan logout.
- Text: Menampilkan teks, seperti judul aplikasi, informasi profil, pesan sambutan, dan nama tombol.
- SnackBar: Menampilkan notifikasi sementara ketika pengguna menekan salah satu tombol menu.

Selain widget tersebut, proyek ini juga memanfaatkan beberapa API dan kelas support Flutter, seperti MediaQuery untuk memperoleh informasi ukuran layar, Theme.of(context) untuk mengakses tema aplikasi, serta ScaffoldMessenger untuk menampilkan SnackBar.

3. MaterialApp merupakan _widget_ yang menyediakan konfigurasi dasar untuk aplikasi Flutter yang menggunakan prinsip desain Material Design. _Widget_ ini mengatur berbagai aspek aplikasi, seperti tema visual (_theme_), judul aplikasi, navigasi, serta halaman awal yang ditampilkan melalui properti _home_.

4. StatelessWidget adalah _widget_ yang tidak memiliki state internal yang dapat berubah selama siklus hidup _widget_. Tampilan _widget_ ditentukan berdasarkan konfigurasi atau data yang diterima. _Widget_ ini cocok digunakan ketika tampilan hanya perlu menampilkan informasi dan tidak perlu mengelola perubahan data secara mandiri.

Sebaliknya, StatefulWidget adalah _widget_ yang memiliki _state_ yang dapat berubah selama aplikasi berjalan. Perubahan _state_ biasanya dilakukan menggunakan metode setState(), yang akan memberi tahu Flutter bahwa _widget_ perlu di-_rebuild_ untuk menampilkan kondisi terbaru.

5. BuildContext merupakan objek yang merepresentasikan lokasi sebuah _widget_ di dalam _widget tree_. Setiap _widget_ memiliki BuildContext yang dapat digunakan untuk mengetahui posisi _widget_ tersebut dalam hierarki aplikasi dan mengakses informasi maupun layanan yang disediakan oleh _widget_-_widget_ induknya.

BuildContext penting karena memungkinkan sebuah _widget_ berinteraksi dengan lingkungan di sekitarnya tanpa harus menerima seluruh konfigurasi secara langsung. Contohnya, BuildContext dapat digunakan untuk mengakses tema aplikasi, ukuran layar, serta menampilkan notifikasi.

Dalam proyek ini, BuildContext digunakan pada metode _build_ milik MyHomePage dan InfoCard. Salah satu contohnya adalah:

`color: Theme.of(context).colorScheme.primary,`

Kode tersebut menggunakan context untuk mengakses konfigurasi tema dari _widget_ induk dan mengambil warna utama aplikasi.

6. _Hot reload_ merupakan fitur Flutter yang memungkinkan developer menerapkan perubahan kode ke aplikasi yang sedang berjalan tanpa harus memulai ulang aplikasi dari awal. Fitur ini bekerja dengan meng-_load_ perubahan kode dan _rebuild widget_ yang terdampak, sementara _state_ aplikasi yang sedang berjalan umumnya tetap dipertahankan.

Sebagai contoh, ketika mengubah warna pada ThemeData, memperbaiki tata letak InfoCard, atau mengubah ukuran teks pada ItemCard, developer dapat menggunakan _hot reload_ untuk melihat hasil perubahan dengan cepat tanpa kehilangan _state_ aplikasi yang sedang berjalan.

Sementara itu, _hot restart_ merupakan proses _restart_ aplikasi Flutter dari awal dengan menjalankan kembali fungsi main(). Berbeda dengan _hot reload_, proses ini menghapus _state_ aplikasi yang sebelumnya tersimpan dan menginisialisasi ulang aplikasi, tetapi tidak perlu membangun ulang seluruh proses kompilasi _native_ seperti pada _full restart_.

_Full restart_ diperlukan ketika perubahan yang dilakukan tidak dapat diterapkan hanya melalui mekanisme _hot reload_ maupun _hot restart_, terutama jika berkaitan dengan kode _native_, konfigurasi platform, atau perubahan dependensi yang memerlukan proses _rebuild_.

## AI Disclosure

Saya menggunakan ChatGPT sebagai Generative AI yang digunakan untuk memahami perubahan yang harus saya terapkan secara garis besar pada proyek ini agar selaras dengan proyek versi webnya, serta memahami beberapa materi mengenai Flutter. Meskipun begitu, saya melakukan _chat_ tersebut dalam mode temporer sehingga tidak bisa di-_share_. Berikut merupakan _prompt list_ yang saya gunakan:

- "Dengan tugas sederhana seperti ini, dan dengan proyek web saya yang seperti ini, bagaimana saya bisa menerapkan perubahan yang sesuai?"
- "Jelaskan mengenai [nama materi]."
- "Apa perbedaan [nama materi] dan [nama materi]? Jelaskan secara detail dan sesuaikan dengan pemahaman pemula Flutter."
