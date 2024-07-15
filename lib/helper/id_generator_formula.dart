import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

import 'base62_convert.dart';

String generateShortUniqueIdFromTimestamp(int timestamp) {
  final random = Random(timestamp);
  final randomInt = (timestamp % 1000000) + random.nextInt(1000000); // timestamp + random combination
  return encodeBase62(randomInt);
}

String generateShortUniqueIdFromStrings(List<String> textList){
  // METHOD 1
  // // sum of all ASCII val
  // int sumOfCodeUnits = 0;
  // for(String value in textList){
  //   sumOfCodeUnits += value.codeUnits.reduce((value, element) => value + element,);
  // }
  //
  // final random = Random(sumOfCodeUnits);
  // final randomInt = (sumOfCodeUnits % 1000000) + random.nextInt(1000000); // a bunch of text ASCII num + random combination
  // return encodeBase62(randomInt);

  // METHOD 2 - Using SHA-256 hash
  // Concatenate all strings
  String concatenatedStrings = textList.join();

  // Generate SHA-256 (concatenated String -> list of utf8 binary -> SHA256)
  List<int> bytes = utf8.encode(concatenatedStrings);
  Digest digest = sha256.convert(bytes);

  // Use "part" of the hash to seed the random generator (list bytes values only -> sum of all bytes list)
  int seed = digest.bytes.reduce((value, element) => value + element);

  // Generated random using seed
  final Random random = Random(seed);
  final int randInt = random.nextInt(1000000);

  return encodeBase62(randInt);
}