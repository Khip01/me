import 'package:flutter/material.dart';

Future<ColorScheme> getColorFromImage(ImageProvider provider, bool isDarkMode) async {
  final ColorScheme colorScheme = await ColorScheme.fromImageProvider(
      provider: provider,
      brightness: isDarkMode ? Brightness.dark : Brightness.light);
  return colorScheme;
}