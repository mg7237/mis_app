import 'package:flutter/material.dart';
import 'package:mis_app/util/globals.dart' as globals;
import 'package:mis_app/util/preference_connector.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    colorScheme: ColorScheme(
        onPrimary: Colors.black,
        primary: Colors.black,
        primaryVariant: Colors.black,
        background: Color(0xFF212121),
        onBackground: Color(0xFF212121),
        secondary: Colors.grey,
        secondaryVariant: Colors.grey,
        onSecondary: Colors.grey,
        error: Colors.red,
        onError: Colors.red,
        brightness: Brightness.dark,
        surface: Colors.black,
        onSurface: Colors.black),
    dividerColor: Colors.black12,
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    colorScheme: ColorScheme(
        onPrimary: Colors.blue,
        primary: Colors.blue,
        primaryVariant: Colors.blue,
        background: Colors.white,
        onBackground: Colors.white,
        onSurface: Colors.black,
        secondary: Colors.white,
        secondaryVariant: Colors.white,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.red,
        brightness: Brightness.light,
        surface: Colors.white),
    dividerColor: Colors.white54,
  );

  late ThemeData _themeData;

  ThemeData getTheme() => _themeData;

  //ThemeData getTheme() =&gt; _themeData;

  ThemeNotifier() {
    if (globals.theme == 'DARK') {
      print('setting dark theme');
      _themeData = darkTheme;
    } else {
      print('setting light theme');
      _themeData = lightTheme;
    }
    notifyListeners();
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    globals.theme = "DARK";
    PreferenceConnector().setString(PreferenceConnector.THEME_SELECTED, "DARK");
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    globals.theme = "LIGHT";
    PreferenceConnector()
        .setString(PreferenceConnector.THEME_SELECTED, "LIGHT");
    notifyListeners();
  }
}
