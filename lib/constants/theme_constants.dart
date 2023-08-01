import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

class AppColors {
  static final Color primaryColor = Colors.blue.shade900;
  static final Color secondaryColor = Colors.amber.shade600;
  static const Color tertiaryColor = Colors.white54;
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color transparentColor = Colors.transparent;
  static const Color greyColor = Colors.grey;
}

class AppTextStyles {
  static TextStyle selectedItemTextStyle({
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return GoogleFonts.raleway(
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.w700,
      color: textColor ?? Colors.amber.shade600,
    );
  }

  static TextStyle unselectedItemTextStyle({
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return GoogleFonts.raleway(
      color: textColor ?? Colors.white54,
      fontSize: fontSize ?? 13,
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }

  static TextStyle customTextStyle({
    Color? textColor,
    required double fontSize,
    FontWeight? fontWeight,
  }) {
    return GoogleFonts.raleway(
      fontSize: fontSize,
      color: textColor ?? Colors.white,
      fontWeight: fontWeight ?? FontWeight.w500,
    );
  }

  static TextStyle numberTextStyle({
    Color? textColor,
    required double fontSize,
    FontWeight? fontWeight,
  }) {
    return GoogleFonts.lato(
      fontSize: fontSize,
      color: textColor ?? Colors.white,
      fontWeight: fontWeight ?? FontWeight.w500,
    );
  }
}
