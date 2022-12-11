import 'package:flutter/material.dart';

class WestminsterTheme {
  WestminsterTheme._() {
    throw StateError("This class constructor shouldn't be invoked");
  }

  static const normalSpacing = 16.0;
  static const mediumSpacing = 24.0;
  static const normalPadding = EdgeInsets.all(16);

  static const primary = Color(0xffD0BCFF);
  static const onPrimary = Color(0xff381E72);
  static const primaryContainer = Color(0xff4F378B);
  static const onPrimaryContainer = Color(0xffEADDFF);
  static const secondary = Color(0xffCCC2DC);
  static const onSecondary = Color(0xff332D41);
  static const tertiary = Color(0xffEFB8C8);
  static const onTertiary = Color(0xff492532);
  static const tertiaryContainer = Color(0xff633B48);
  static const onTertiaryContainer = Color(0xffFFD8E4);
  static const error = Color(0xffF2B8B5);
  static const onError = Color(0xff601410);
  static const background = Color(0xff1C1B1F);
  static const onBackground = Color(0xffE6E1E5);
  static const surface = Color(0xff1C1B1F);
  static const onSurface = Color(0xffE6E1E5);

  static ThemeData getTheme() {
    return ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        error: error,
        onError: onError,
        background: background,
        onBackground: onBackground,
        surface: surface,
        onSurface: onSurface,
      ),
      textTheme: const TextTheme(
        titleSmall: TextStyle(color: onPrimaryContainer),
        bodySmall: TextStyle(color: onTertiaryContainer),
      ),
      dialogBackgroundColor: surface,
    );
  }
}
