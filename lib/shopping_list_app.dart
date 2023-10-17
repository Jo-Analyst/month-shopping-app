import 'package:flutter/material.dart';
import 'package:month_shopping_app/providers/category_provider.dart';
import 'package:month_shopping_app/providers/product_provider.dart';
import 'package:provider/provider.dart';

import 'pages/screen_app_page.dart';

class ShoppingListApp extends StatelessWidget {
  const ShoppingListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping List',
        theme: ThemeData(
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
        ),
        home: const ScreenAppPage(),
      ),
    );
  }
}
