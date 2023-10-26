import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 23),
    displayLarge: TextStyle(fontSize: 18, color: Colors.white),
    displaySmall: TextStyle(color: Color.fromARGB(194, 13, 23, 37)),
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
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white, // Cor da borda quando o campo está desabilitado
      ),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.red, // Define a cor do cursor
      selectionHandleColor: Colors.green, // Define a cor do handle de seleção
      selectionColor: Colors.amber),
  listTileTheme: const ListTileThemeData(
    titleTextStyle: TextStyle(color: Colors.white),
    subtitleTextStyle: TextStyle(color: Colors.white),
    leadingAndTrailingTextStyle: TextStyle(color: Colors.white),
    iconColor: Colors.white,
  ),
);
