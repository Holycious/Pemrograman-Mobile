void main() {
  String Nama = "Leon Shan Yoedha Adjie";
  String NIM = "2341720136";
  
  for (int angka = 2; angka <= 201; angka++) {
    int i = 2;

    while (i * i <= angka && angka % i != 0) i++;

    if (i * i > angka) print(angka.toString() + ". " + Nama + " | " + NIM);
  }
}
