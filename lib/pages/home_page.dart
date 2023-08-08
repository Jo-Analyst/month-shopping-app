import 'package:flutter/material.dart';
import 'package:shopping_list_app/pages/product_page.dart';
import 'package:shopping_list_app/template/shopping_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool screenShoppingListActived = true;
  List<Map<String, dynamic>> menuActived = [
    {"name": "list", "isActive": true},
    {"name": "shopp", "isActive": false},
  ];
  Color color(bool isActive) {
    return isActive ? const Color.fromARGB(255, 94, 31, 202) : Colors.white;
  }

  changeActiveMenu(int index) {
    setState(() {
      for (var menu in menuActived) {
        menu["isActive"] = false;
      }
      menuActived[index]["isActive"] = true;
      screenShoppingListActived = !screenShoppingListActived;
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
            ? const ShoppingList()
            : const ProductPage(),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
        child: const Icon(
          Icons.shopping_cart_outlined,
          size: 35,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        shape: const CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Padding(
            padding: const EdgeInsets.all(10),
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
                        color: color(menuActived[0]["isActive"]),
                      ),
                    ),
                    Text(
                      "Minha Lista",
                      style: TextStyle(
                        color: color(menuActived[0]["isActive"]),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
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
                        color: color(menuActived[1]["isActive"]),
                      ),
                    ),
                    Text(
                      "Produtos",
                      style: TextStyle(
                        color: color(menuActived[1]["isActive"]),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
