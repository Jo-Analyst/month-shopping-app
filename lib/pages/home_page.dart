import 'package:flutter/material.dart';
import 'package:shopping_list_app/template/shopping_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> menuActived = [
    {"name": "list", "isActive": true},
    {"name": "shopp", "isActive": false},
  ];
  changeActiveMenu(int index) {
    setState(() {
      for (var menu in menuActived) {
        menu["isActive"] = false;
      }
      menuActived[index]["isActive"] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          "Minha lista",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const ShoppingList(),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
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
                IconButton(
                  onPressed: () {
                    changeActiveMenu(0);
                  },
                  icon: Icon(
                    Icons.list,
                    size: 40,
                    color: menuActived[0]["isActive"]
                        ? const Color.fromARGB(255, 130, 78, 220)
                        : Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    changeActiveMenu(1);
                  },
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    size: 40,
                    color: menuActived[1]["isActive"]
                        ? const Color.fromARGB(255, 130, 78, 220)
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
