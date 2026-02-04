
import 'dart:convert';

import 'package:flutter/services.dart';

Future<Map<String, dynamic>> getDataCreationsJson() async {
  final String dataString = await rootBundle.loadString('assets/data/khip01-portfolio-default-rtdb-export.json');
  final dataMap = await json.decode(dataString);
  // setState(() {
  //   _creationsData = dataMap['creations'];
  // });
  return dataMap['creations'];
}