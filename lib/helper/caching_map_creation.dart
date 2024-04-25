import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void setCreationMap(Map<String, dynamic> creationMap) async {
  final prefs = await SharedPreferences.getInstance();
  // Encode Map First before save to Sharedpreferences
  String encodedMap = json.encode(creationMap);
  prefs.setString("creationMap", encodedMap);
}

Future<Map<String, dynamic>> getCreationsMap() async {
  final prefs = await SharedPreferences.getInstance();
  String? encodedMap = prefs.getString("creationMap");
  if (encodedMap == null) {
    return <String, dynamic>{};
  } else {
    // decode the String to map
    return json.decode(encodedMap);
  }
}
