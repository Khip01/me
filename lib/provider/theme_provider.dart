import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final isDarkMode = StateProvider(
//         (ref) => false,
// );

// USING CHANGE NOTIFIER TO MANAGE THE THEME STATE
class ThemeNotifier extends ChangeNotifier {
  bool value = false;

  void setThemeDark(){
    value = true;
    notifyListeners();
  }

  void setThemeLight(){
    value = false;
    notifyListeners();
  }
}

final isDarkModeProvider = ChangeNotifierProvider<ThemeNotifier>(
  (ref) => ThemeNotifier(),
);