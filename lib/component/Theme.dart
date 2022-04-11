// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum MyTheme { light, dark }

// notes status bar
// Brightness.light > bg white & text black
// Brightness.dark > bg black & text white

class ThemeNotifier with ChangeNotifier {
  static List<ThemeData> themes = [
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.red,
      backgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Colors.red,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      fontFamily: 'Nunito',
    ),
    ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.red,
      fontFamily: 'Nunito',
    ),
  ];

  MyTheme _current = MyTheme.light;
  ThemeData _currentTheme = themes[0];

  void switchTheme() => currentTheme == MyTheme.light
      ? currentTheme = MyTheme.dark
      : currentTheme = MyTheme.light;

  set currentTheme(theme) {
    if (theme != null) {
      _current = theme;
      _currentTheme = _current == MyTheme.light ? themes[0] : themes[1];

      notifyListeners();
    }
  }

  get currentTheme => _current;
  get currentThemeData => _currentTheme;
}
