void main(){
  int Index;
  int index = 0;
  for (Index = 10; index < 27; index++){
    print(Index);

    if (Index == 21)
    break;

    else if (index > 1 || index < 7) 
    continue;
    print(index);
  }
}