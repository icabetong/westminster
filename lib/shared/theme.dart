import 'package:flutter/material.dart';

class WestminsterTheme {
  WestminsterTheme._() {
    throw StateError("This class constructor shouldn't be invoked");
  }

  static const normalSpacing = 16.0;
  static const mediumSpacing = 24.0;
  static const normalPadding = EdgeInsets.all(16);

  static ThemeData getTheme() {
    return ThemeData.light(useMaterial3: true);
  }
}
