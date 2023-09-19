class StringManu {
  String sliceStr({String? str, int? index, Pattern pattern = " "}) {
    return str!.split(pattern)[index!];
  }
}
