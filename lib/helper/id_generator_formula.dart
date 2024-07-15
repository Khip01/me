import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'base62_convert.dart';

String generateShortUniqueIdFromTimestamp(int timestamp) {
  final random = Random(timestamp);
  final randomInt = (timestamp % 1000000) + random.nextInt(1000000); // timestamp + random combination
  return encodeBase62(randomInt);
}

String generateShortUniqueIdFromStrings(List<String> textList){
  // sum of all ASCII val
  int sumOfCodeUnits = 0;
  for(String value in textList){
    sumOfCodeUnits += value.codeUnits.reduce((value, element) => value + element,);
  }

  final random = Random(sumOfCodeUnits);
  final randomInt = (sumOfCodeUnits % 1000000) + random.nextInt(1000000); // a bunch of text ASCII num + random combination
  return encodeBase62(randomInt);x
}