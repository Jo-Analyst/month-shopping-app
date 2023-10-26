import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 23),
    displayLarge: TextStyle(fontSize: 18, color: Colors.white),
    titleLarge: TextStyle(color: Colors.grey),
  ),
  primaryColor: const Color.fromARGB(113, 141, 137, 137),
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(113, 141, 137, 137),
    toolbarHeight: 80,
    titleTextStyle: TextStyle(fontSize: 20),
  ),
  iconTheme: const IconThemeData(
    size: 35,
    color: Color.fromARGB(255, 73, 133, 206),
  ),
  scaffoldBackgroundColor: Colors.black87,
  cardTheme: const CardTheme(
    color: Color.fromARGB(113, 141, 137, 137),
  ),
  listTileTheme: const ListTileThemeData(
    titleTextStyle: TextStyle(color: Colors.white),
    subtitleTextStyle: TextStyle(color: Colors.white),
    leadingAndTrailingTextStyle: TextStyle(color: Colors.white),
    iconColor: Colors.white,
  ),
);
