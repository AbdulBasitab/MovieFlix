import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.blue.shade900,
      brightness: Brightness.dark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.blue.shade900,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white54,
        unselectedLabelStyle: const TextStyle(
          color: Colors.white54,
        ),
      ),
    );
  }
}
