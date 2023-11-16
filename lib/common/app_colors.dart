import 'package:flutter/material.dart';

class AppColor {
  static const Color blackWithOpacity = Color(0x33000000);

  static const Color primary = Color(0xFF0F64FF);
  static const Color secondary = Color(0xFFFF5103);
  static const Color primaryDark = Color(0xFF074EBF);
  static const Color secondaryDark = Color(0xFFFF3B00);
  static const Color accent = Color(0xFF3BC4FF);
  static const Color cardprimary = Color(0xFFEEEEEE);
  static const Color background = Color(0xFFF5F5F5);
  static const Color scaffoldBackground = Colors.white;
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFEBEBEB);
  static const Color error = Color(0xFFB00020);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color shadow = Color(0xFF000000);
  static const Color grey = Colors.grey;

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    colorScheme: const ColorScheme.light(primary: primary, secondary: accent),
    scaffoldBackgroundColor: scaffoldBackground,
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryDark,
    colorScheme: const ColorScheme.dark(
        primary: primaryDark, secondary: accent, background: Colors.black),
    scaffoldBackgroundColor: Colors.black,
  );
}
