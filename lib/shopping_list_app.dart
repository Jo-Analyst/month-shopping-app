import 'package:flutter/material.dart';

import 'pages/screen_app_page.dart';

class ShoppingListApp extends StatelessWidget {
  const ShoppingListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping List',
      theme: ThemeData(
        textTheme: const TextTheme(bodyLarge: TextStyle(fontSize: 23)),
        primaryColor: const Color.fromARGB(255, 73, 133, 206),
        appBarTheme: const AppBarTheme(
          toolbarHeight: 80,
          titleTextStyle: TextStyle(fontSize: 20),
        ),

        // colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 130, 78, 220)),
        // useMaterial3: true,
      ),
      home: const ScreenAppPage(),
    );
  }
}
