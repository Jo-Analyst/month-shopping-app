import 'package:flutter/material.dart';
import 'package:shopping_list_app/pages/shopping_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 130, 78, 220)),
        useMaterial3: true,
      ),
      home: const ShoppingListAppPage(),
    );
  }
}

