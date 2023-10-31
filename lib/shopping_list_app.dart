import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:month_shopping_app/intro_screen.dart';
import 'package:month_shopping_app/models/theme_model.dart';
import 'package:month_shopping_app/providers/category_provider.dart';
import 'package:month_shopping_app/providers/product_provider.dart';
import 'package:month_shopping_app/providers/shopping_list_provider.dart';
import 'package:month_shopping_app/themes/app_theme.dart';
import 'package:month_shopping_app/themes/dark.dart';
import 'package:month_shopping_app/themes/light.dart';
import 'package:provider/provider.dart';

import 'pages/screen_app_page.dart';

class ShoppingListApp extends StatefulWidget {
  const ShoppingListApp({super.key});

  @override
  State<ShoppingListApp> createState() => _ShoppingListAppState();
}

class _ShoppingListAppState extends State<ShoppingListApp> {
  @override
  void initState() {
    super.initState();
    toggleTheme();
    AppTheme.instance.addListener(() {
      setState(() {});
    });
  }

  void toggleTheme() async {
    final theme = await ThemeModel.find();
    if (theme.isNotEmpty) {
      AppTheme.instance.isDarkTheme = theme[0]["is_dark"] == 0 ? false : true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ShoppingListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping List',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: AppTheme.instance.themeMode,
        home: const IntroScreen(),
        routes: {"/home": (context) => const ScreenAppPage()},
      ),
    );
  }
}
