import 'package:flutter/material.dart';
import 'color_schemes.g.dart';

class WestminsterTheme {
  WestminsterTheme._() {
    throw StateError("This class constructor shouldn't be invoked");
  }

  static const normalSpacing = 16.0;
  static const mediumSpacing = 24.0;
  static const normalPadding = EdgeInsets.all(16);

  static ThemeData getTheme() {
    return ThemeData(
      fontFamily: 'Karla',
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: darkColorScheme,
      textTheme: TextTheme(
        titleSmall: TextStyle(color: darkColorScheme.onTertiaryContainer),
        bodySmall: TextStyle(color: darkColorScheme.secondaryContainer),
      ),
      scaffoldBackgroundColor: darkColorScheme.background,
      dialogBackgroundColor: darkColorScheme.background,
    );
  }
}
