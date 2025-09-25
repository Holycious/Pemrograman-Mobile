void main() {
  final List<String?> list = [null, null, null, null, null];
  list[1] = 'Leon Shan Yoedha Adjie';
  list[2] = '2341720136';
  
  assert(list.length == 5);
  assert(list[1] == 'Leon Shan Yoedha Adjie');
  assert(list[2] == '2341720136');

  print(list.length);
  for (var value in list) {
    print(value);
  }
}