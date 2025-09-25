void main() {
  var mahasiswaAwal = ('first', a: 2, b: true, 'last');
  print('Record awal              : $mahasiswaAwal');
  print('awal.1=${mahasiswaAwal.$1}, awal.a=${mahasiswaAwal.a}, awal.b=${mahasiswaAwal.b}, awal.2=${mahasiswaAwal.$2}');
  print('---');
  var mahasiswa2 = ('2341720136', a: 'Mahasiswa', b: true, 'Leon Shan Yoedha Adjie');
  print(mahasiswa2.$1); 
  print(mahasiswa2.a);  
  print(mahasiswa2.b);  
  print(mahasiswa2.$2); 
  print('---');
  print('Record sesudah diganti   : $mahasiswa2');
}