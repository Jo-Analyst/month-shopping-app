import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 23),
    displayLarge: TextStyle(fontSize: 18),
  ),
  primaryColor: const Color.fromARGB(255, 73, 133, 206),
  appBarTheme: const AppBarTheme(
    toolbarHeight: 80,
    titleTextStyle: TextStyle(fontSize: 20),
  ),
  iconTheme: const IconThemeData(size: 35),
);
