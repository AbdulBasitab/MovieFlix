import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.blue.shade800,
      brightness: Brightness.dark,
    );
  }
}
