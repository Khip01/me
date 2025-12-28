import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Manages the app's dark/light theme state using ChangeNotifier pattern.
class ThemeNotifier extends ChangeNotifier {
  bool value = false;

  void setThemeDark() {
    value = true;
    notifyListeners();
  }

  void setThemeLight() {
    value = false;
    notifyListeners();
  }
}

final isDarkModeProvider = ChangeNotifierProvider<ThemeNotifier>(
  (ref) => ThemeNotifier(),
);
