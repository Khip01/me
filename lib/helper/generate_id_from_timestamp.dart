import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'base62_convert.dart';

String generateShortUniqueIdFromTimestamp(int timestamp) {
  final random = Random(timestamp);
  final randomInt = (timestamp % 1000000) + random.nextInt(1000000); // timestamp + random combination
  return encodeBase62(randomInt);
}