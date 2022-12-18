import 'package:flutter/material.dart';

class WestminsterTheme {
  WestminsterTheme._() {
    throw StateError("This class constructor shouldn't be invoked");
  }

  static const normalSpacing = 16.0;
  static const mediumSpacing = 24.0;
  static const normalPadding = EdgeInsets.all(16);

  static const primary = Color(0xfffdc921);
  static const onPrimary = Color(0xff000000);
  static const secondary = Color(0xfffdd85d);
  static const onSecondary = Color(0xff000000);
  static const tertiary = Color(0xff6798c0);
  static const onTertiary = Color(0xff000000);
  static const error = Color(0xffe64a19);
  static const onError = Color(0xff000000);
  static const surface = Color(0xffffffff);
  static const onSurface = Color(0xff000000);
  static const background = Color(0xfffffdf7);

  static ThemeData getTheme() {
    return ThemeData(
      fontFamily: 'Karla',
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        tertiary: tertiary,
        onTertiary: onTertiary,
        error: error,
        onError: onError,
        surface: surface,
        onSurface: onSurface,
        background: background,
        onBackground: onSurface,
      ),
      scaffoldBackgroundColor: background,
      dialogBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        elevation: 8,
        centerTitle: true,
      ),
      cardTheme: const CardTheme(color: secondary),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: onSurface,
          side: const BorderSide(color: secondary),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondary,
          foregroundColor: onSecondary,
          textStyle: const TextStyle(
            color: onSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
