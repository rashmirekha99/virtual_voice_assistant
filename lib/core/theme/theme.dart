import 'package:flutter/material.dart';
import 'package:voice_assistant/core/theme/color_palette.dart';

class AppTheme {
  static final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: ColorPalette.primaryWhite,
      appBarTheme: const AppBarTheme(
          
          backgroundColor: ColorPalette.primaryWhite,
          foregroundColor: ColorPalette.primaryBlue),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(ColorPalette.primaryBlue),
        ),
      ),
      primaryTextTheme: const TextTheme(
          displayMedium: TextStyle(color: ColorPalette.primaryBlack)));
}
