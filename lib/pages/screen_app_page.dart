import 'package:flutter/material.dart';
import 'package:shopping_list_app/pages/product_form_page.dart';
import 'package:shopping_list_app/pages/product_list_page.dart';
import 'package:shopping_list_app/pages/shopping_list_page.dart';

class ScreenAppPage extends StatefulWidget {
  const ScreenAppPage({super.key});

  @override
  State<ScreenAppPage> createState() => _ScreenAppPageState();
}

class _ScreenAppPageState extends State<ScreenAppPage> {
  bool screenShoppingListActived = true;
  List<Map<String, dynamic>> menuActived = [
    {"name": "list", "isActive": true},
    {"name": "shopp", "isActive": false},
  ];
  Color changeColor(bool isActive) {
    return isActive ? Colors.black : Colors.white;
  }

  changeActiveMenu(int index) {
    setState(() {
      for (var menu in menuActived) {
        menu["isActive"] = false;
      }
      menuActived[index]["isActive"] = true;
      screenShoppingListActived = index == 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(milliseconds: 2),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: screenShoppingListActived
            ? const ShoppingListPage()
            : const ProductListPage(),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.black87,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          if (screenShoppingListActived) {
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ProductFormPage(),
              ),
            );
          }
        },
        child: Icon(
          screenShoppingListActived ? Icons.brightness_6_sharp : Icons.add,
          size: 35,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        shape: const CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      changeActiveMenu(0);
                    },
                    icon: Icon(
                      Icons.list,
                      size: 40,
                      color: changeColor(menuActived[0]["isActive"]),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      changeActiveMenu(1);
                    },
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      size: 40,
                      color: changeColor(menuActived[1]["isActive"]),
                    ),
                  ),
                  // Text(
                  //   "Produtos",
                  //   style: TextStyle(
                  //     color: changeColor(menuActived[1]["isActive"]),
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
