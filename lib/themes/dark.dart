import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 23, color: Colors.black),
    displayLarge: TextStyle(fontSize: 18, color: Colors.white),
    displaySmall: TextStyle(color: Color.fromARGB(194, 13, 23, 37)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 98, 97, 97)),
    titleMedium: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 98, 97, 97))
  ),
  primaryColor: const Color.fromARGB(113, 141, 137, 137),
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(113, 141, 137, 137),
    toolbarHeight: 80,
    titleTextStyle: TextStyle(fontSize: 20),
  ),
  iconTheme: const IconThemeData(
    size: 35,
    color: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.black87,
  cardTheme: const CardTheme(
    color: Color.fromARGB(113, 141, 137, 137),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white, // Cor da borda quando o campo está desabilitado
      ),
    ),
  ),
  // textSelectionTheme: const TextSelectionThemeData(
  //   cursorColor: Colors.red, // Define a cor do cursor
  //   selectionHandleColor: Colors.green, // Define a cor do handle de seleção
  //   selectionColor: Colors.amber,
  // ),
  listTileTheme: const ListTileThemeData(
    titleTextStyle: TextStyle(color: Colors.white),
    subtitleTextStyle: TextStyle(color: Colors.white),
    leadingAndTrailingTextStyle: TextStyle(color: Colors.white),
    iconColor: Colors.white,
  ),
);
