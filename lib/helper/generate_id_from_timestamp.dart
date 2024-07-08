import 'package:me/helper/base62_convert.dart';

String generateShortUniqueIdFromTimestamp(int timestamp){
  final randomInt = (timestamp % 1000000) + 100000;
  return encodeBase62(randomInt) ?? "";
}