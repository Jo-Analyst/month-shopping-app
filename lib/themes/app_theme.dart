import 'package:flutter/material.dart';
import 'package:month_shopping_app/models/theme_model.dart';
import 'package:month_shopping_app/themes/dark.dart';
import 'package:month_shopping_app/themes/light.dart';

class AppTheme extends ChangeNotifier {
  static AppTheme? _instance;
  bool isDarkTheme = false;

  static AppTheme get instance =>
      _instance == null ? _instance = AppTheme() : _instance!;

  ThemeMode get themeMode => isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() async {
    isDarkTheme = !isDarkTheme;
    await ThemeModel.toggleTheme(isDarkTheme ? 1 : 0);
    notifyListeners();
  }

  ThemeData get dark => darkTheme;
  ThemeData get light => lightTheme;
}
