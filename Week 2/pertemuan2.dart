void main() {
  // for (int i= 22; i > 1; i--) {
  //   print('My name is Yoedha, i am ${i-1} years old');
  // }
  
// Null Safety

  // Non-nullable: Harus memiliki nilai (tidak null)
  // String nama = "Yoedha";
  
  // // Nullable: Boleh berisi null (ditandai dengan ?)
  // String? tinggi = null;
  
  // // Mengakses nilai nullable dengan aman
  // print(nama.toUpperCase());    // YOEDHA (aman)
  // print(tinggi?.toUpperCase()); // null (aman)

  // // Menetapkan nilai ke nullable
  // tinggi = "181";
  // print(tinggi); // 181

// Late Variabel
late String pesan;
  
  // Fungsi sederhana
  void setPesan() {
    print("Menyiapkan pesan...");
    pesan = "Halo Dunia!";
  }
  
  // Pesan belum diinisialisasi di sini
  // print(pesan); // ERROR: LateInitializationError
  
  // Inisialisasi pesan
  setPesan();
  
  // Sekarang aman untuk diakses
  print(pesan);  // Halo Dunia!
  
  // Late dengan initializer - dijalankan saat pertama kali diakses
  late String waktu = ambilWaktu();
  print("Sebelum mengakses waktu");
  print(waktu);  // Initializer berjalan saat ini
  print(waktu);  // Initializer tidak berjalan lagi
}

String ambilWaktu() {
  print("Mengambil waktu sekarang...");
  return "14:30";
}