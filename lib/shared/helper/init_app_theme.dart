import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:me/app/provider/theme_provider.dart';
// I use universal_html because I'm afraid the dart:html package will conflict
// with the firebase package's js.
// import 'package:universal_html/html.dart';
// IMPORTANT!
// I disabled universal_html and tried replacing it with web/web.dart.
import 'package:web/web.dart';


const String key = "isDarkMode";

void initAppTheme(BuildContext context, WidgetRef ref){
  // get available user cookie
  String? cookieStr = document.cookie;

  // auto init device theme if whole cookie isEmpty/null
  if(cookieStr.isEmpty) {
    initDeviceTheme(context, ref);
    return;
  }

  Map<String, String> cookieMap = getCookieAsMap(cookieStr);

  String? isDarkModeCookie = getCookieValueFromKey(cookieMap, key);

  // auto init device theme if searched cookie key isEmpty/null
  if(isDarkModeCookie == null){
    initDeviceTheme(context, ref);
    return;
  }

  // set init theme according to cookie
  bool isDarkModeBool = bool.parse(isDarkModeCookie, caseSensitive: false);
  isDarkModeBool ? ref.read(isDarkModeProvider.notifier).setThemeDark() : ref.read(isDarkModeProvider.notifier).setThemeLight();
  return;
}

// init with user device theme preferences
void initDeviceTheme(BuildContext context, WidgetRef ref){
  final Brightness brightness = MediaQuery.platformBrightnessOf(context);
  brightness == Brightness.dark ? ref.read(isDarkModeProvider.notifier).setThemeDark() : ref.read(isDarkModeProvider.notifier).setThemeLight();
}

// cookie String -> Map (splitted String key, value)
Map<String, String> getCookieAsMap(String cookieStr) {
  // Split value by ';'
  List<String> cookieList = cookieStr.split(';');
  // Create map from split cookieList result
  Map<String, String> cookieMap = Map.fromEntries(
    cookieList.map((cookieElement) {
      final List<String> cookiePair = cookieElement.split("=");
      return MapEntry(cookiePair[0].trim(), cookiePair[1].trim());
    }),
  );
  return cookieMap;
}

// get cookie value from map key
String? getCookieValueFromKey(Map<String, String> cookieMap, String cookieKey) {
  for (String key in cookieMap.keys) {
    if (key == cookieKey) return cookieMap[key];
  }
  return null;
}



// update isDarkMode cookie value
void changeCookieValue(String newValue){
  // get available user cookie
  String? cookieStr = document.cookie;

  // add new cookie if whole cookie isEmpty/null
  if(cookieStr.isEmpty) {
    document.cookie = "$key=$newValue";
    return;
  }

  Map<String, String> cookieMap = getCookieAsMap(cookieStr);

  // validation for cookie availability
  String? isDarkModeCookie = getCookieValueFromKey(cookieMap, key);
  // add new cookie according to key and new value
  // if searched cookie key isEmpty/null
  if(isDarkModeCookie == null){
    document.cookie = "$key=$newValue";
    return;
  }

  cookieMap = setCookieValueFromKey(key, newValue, cookieMap);

  // save the value change of the key cookie that have been changed to cookie
  document.cookie = getCookieFromMapToString(cookieMap);
}

// set cookie value
Map<String, String> setCookieValueFromKey(
    String cookiekey,
    String cookieValue,
    Map<String, String> cookieMap,
    ) {
  cookieMap[cookiekey] = cookieValue;
  return cookieMap;
}

// get cookie (Map -> String)
String getCookieFromMapToString(Map<String, String> cookieMap) {
  String cookieStr = "";
  for (String key in cookieMap.keys) {
    cookieStr += "$key=${cookieMap[key]}; ";
  }
  return cookieStr;
}