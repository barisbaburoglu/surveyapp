import 'package:flutter/material.dart';
import 'package:surveyapp/constant.dart';

class MyTheme with ChangeNotifier {
  ThemeMode currentTheme() {
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
