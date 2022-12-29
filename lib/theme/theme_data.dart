import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData appLightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
    );
  }

  static ThemeData appDarkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
    );
  }
}
