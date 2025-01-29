import 'package:chat_app/themes/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeData _themeData = darkMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = isDarkMode ? lightMode : darkMode;
    notifyListeners();
  }

}