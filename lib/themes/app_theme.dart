import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xffAA5C5C);
  static const Color colorFooter = Color(0xffD9D9D9);
  static const Color colorAdd = Color(0xffAA5C5C);
  static const Color colorReset = Color(0xff2A3132);
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
    ),
  );
}
