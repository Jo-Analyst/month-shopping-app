import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 23,
      color: Color.fromARGB(255, 73, 133, 206),
    ),
    displayLarge: TextStyle(fontSize: 18, color: Colors.black),
    displaySmall: TextStyle(color: Color.fromARGB(25, 73, 133, 206)),
    displayMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.grey),
  ),
  primaryColor: const Color.fromARGB(255, 73, 133, 206),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(),
    floatingLabelStyle: TextStyle(color: Colors.black),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
  ),
  appBarTheme: const AppBarTheme(
    toolbarHeight: 80,
    titleTextStyle: TextStyle(fontSize: 20),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black,
  ),
  iconTheme: const IconThemeData(size: 35),
);
