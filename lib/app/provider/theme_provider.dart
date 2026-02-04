import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDark = false;

  bool get value => _isDark;
  set value(bool v) {
    if (_isDark != v) {
      _isDark = v;
      notifyListeners();
    }
  }

  void toggle() {
    value = !_isDark;
  }

  void setThemeDark() {
    value = true;
  }

  void setThemeLight() {
    value = false;
  }
}

final isDarkModeProvider = ChangeNotifierProvider<ThemeNotifier>(
  (ref) => ThemeNotifier(),
);
