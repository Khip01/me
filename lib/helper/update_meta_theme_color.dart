import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

void updateMetaThemeColor(bool isDarkMode) {
  if (!kIsWeb) return;

  final String color = isDarkMode ? '#212121' : '#ffffff';

  final meta = web.document.querySelector('meta[name="theme-color"]');
  if (meta != null) {
    meta.setAttribute('content', color);
  }

  final root = web.document.documentElement;
  if (root != null) {
    if (isDarkMode) {
      root.classList.add('dark');
      root.classList.remove('light');
    } else {
      root.classList.add('light');
      root.classList.remove('dark');
    }
  }
}
