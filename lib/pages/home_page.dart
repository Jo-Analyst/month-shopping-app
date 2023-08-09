import 'package:flutter/material.dart';
import 'package:shopping_list_app/pages/product_page.dart';
import 'package:shopping_list_app/pages/shopping_list_page.dart';

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
    return isActive ? Colors.black : Colors.white;
  }

  changeActiveMenu(int index) {
    setState(() {
      for (var menu in menuActived) {
        menu["isActive"] = false;
      }
      menuActived[index]["isActive"] = true;
      screenShoppingListActived = index == 0 ? true : false;
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
            : const ProductPage(),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.black87,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
        child: const Icon(
          Icons.brightness_6_sharp,
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
                      color: color(menuActived[0]["isActive"]),
                    ),
                  ),
                  // Text(
                  //   "Minha Lista",
                  //   style: TextStyle(
                  //     color: color(menuActived[0]["isActive"]),
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // )
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
                  // Text(
                  //   "Produtos",
                  //   style: TextStyle(
                  //     color: color(menuActived[1]["isActive"]),
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
