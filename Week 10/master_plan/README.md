# Praktikum 1: Dasar State dengan Model-View

## 1. Selesaikan langkah-langkah praktikum tersebut, lalu dokumentasikan berupa GIF hasil akhir praktikum beserta penjelasannya di file README.md! Jika Anda menemukan ada yang error atau tidak berjalan dengan baik, silakan diperbaiki.
 
## 2. Jelaskan maksud dari langkah 4 pada praktikum tersebut! Mengapa dilakukan demikian?

Langkah 4: Buat file data_layer.dart berisi:
Kita dapat membungkus beberapa data layer ke dalam sebuah file yang nanti akan mengekspor kedua model tersebut. Dengan begitu, proses impor akan lebih ringkas seiring berkembangnya aplikasi. Buat file bernama data_layer.dart di folder models. Kodenya hanya berisi export seperti berikut.

``` dart
export 'plan.dart';
export 'task.dart';
```
### Penjelasan:
#### Langkah 4 membuat file data_layer.dart yang berfungsi sebagai barrel file atau re-export file. File ini mengumpulkan dan mengekspor ulang beberapa file model (plan.dart dan task.dart) dalam satu tempat. Fungsinya?

#### 1. Menyederhanakan Import: Alih-alih melakukan import terpisah untuk setiap model, Cukup dengan satu import yaitu data_layer.dart
#### 2. Maintainability: Ketika aplikasi berkembang dan memiliki banyak model, file data_layer.dart memudahkan pengelolaan dependencies.
#### 3. Encapsulation: Menyembunyikan detail implementasi internal dan memberikan interface yang bersih untuk akses ke data models.

## 3. Mengapa perlu variabel plan di langkah 6 pada praktikum tersebut? Mengapa dibuat konstanta ?

Langkah 6:
Pada folder views, buatlah sebuah file plan_screen.dart dan gunakan templat StatefulWidget untuk membuat class PlanScreen. Isi kodenya adalah sebagai berikut. Gantilah teks ‘Namaku' dengan nama panggilan Anda pada title AppBar.

``` dart
class _PlanScreenState extends State<PlanScreen> {
  Plan plan = const Plan();
```

### Penjelasan:
Variabel plan menyimpan state/data aplikasi (daftar tugas dan informasinya). Diperlukan untuk menampilkan data dan mengupdate UI ketika ada perubahan melalui setState().

Mengapa dibuat konstanta (const):

Nilai awal yang immutable: Memberikan state awal kosong saat aplikasi pertama kali dijalankan
Optimasi performa: Objek const dibuat saat compile-time, lebih efisien
Immutable pattern: Setiap perubahan membuat instance Plan baru, bukan memodifikasi yang lama. Ini membuat state lebih predictable dan aman dari side effects

## 4. Lakukan capture hasil dari Langkah 9 berupa GIF, kemudian jelaskan apa yang telah Anda buat!
![alt text](assets/Praktikum1.gif)
### Penjelasan: 
Aplikasi ini mendemonstrasikan konsep dasar State Management di Flutter menggunakan Model-View pattern dengan model data yang immutable.
## 5. Apa kegunaan method pada Langkah 11 dan 13 dalam lifecyle state ?
### Penjelasan:
initState() untuk setup awal, dispose() untuk cleanup akhir. Kedua method ini penting dalam lifecycle management Flutter untuk mencegah memory leak dan memastikan performa aplikasi optimal.
## 6. Kumpulkan laporan praktikum Anda berupa link commit atau repository GitHub ke dosen yang telah disepakati !