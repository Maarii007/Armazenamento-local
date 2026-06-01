import 'package:flutter/material.dart';

class AppTheme {
  static const _seed = Color(0xFF1F6FEB);

  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seed,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F6FEB),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seed,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0D1117),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
    );
  }
}