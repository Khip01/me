//// STATIC LOGICAL CODE DO NOT CHANGE
String encodeBase62(int number) {
  const String characters =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  final List<String> charList = characters.split('');
  final int base = charList.length;

  if (number == 0) {
    return charList[0];
  }

  String encoded = '';
  int num = number;

  while (num > 0) {
    encoded = charList[num % base] + encoded;
    num = num ~/ base;
  }

  return encoded;
}

int decodeBase62(String encoded) {
  const String characters =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  final List<String> charList = characters.split('');
  final int base = charList.length;

  int decoded = 0;
  int pow = 0;

  for (int i = encoded.length - 1; i >= 0; i--) {
    final String char = encoded[i];
    final int index = charList.indexOf(char);
    decoded += index * pow;
    pow *= base;
  }

  return decoded;
}