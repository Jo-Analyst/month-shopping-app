import 'package:flutter/material.dart';
import 'package:shopping_list_app/templates/product_list.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  bool showInputSearch = false, isExpanded = false;
  List<bool> cardTriggeredList = [];

  toggleShowInputSearch() {
    setState(() {
      showInputSearch = !showInputSearch;
    });
  }

  void setListCardTriggered() {
    for (int i = 0; i < shelves.length; i++) {
      setState(() {
        cardTriggeredList.add(false);
      });
    }
  }

  updateListCardTriggered(int index, bool expanded) {
    setState(() {
      cardTriggeredList[index] = expanded;
    });
  }

  // prateleiras
  final List<Map<String, dynamic>> shelves = [
    {"id": 1, "name": "Congelados"},
    {"id": 2, "name": "Alimentos"},
    {"id": 3, "name": "Guloseima"},
    {"id": 4, "name": "Limpeza"},
    {"id": 5, "name": "Utensilios"},
    {"id": 6, "name": "Padaria"},
    {"id": 7, "name": "Beleza"},
    {"id": 8, "name": "Feira"},
    {"id": 9, "name": "Laticínios"},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setListCardTriggered();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          actions: [
            Container(
              margin: EdgeInsets.only(
                right: 0.05 * MediaQuery.of(context).size.width,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: 0.08 * MediaQuery.of(context).size.width,
                  color: Colors.white,
                ),
                onPressed: () => toggleShowInputSearch(),
              ),
            ),
          ],
          toolbarHeight: 0.1 * MediaQuery.of(context).size.height,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Minha lista de compras",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 8,
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(15),
                      title: Text(
                        shelves[index]["name"],
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge!.fontSize,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                        onPressed: () {
                          isExpanded = !isExpanded;
                          updateListCardTriggered(index, isExpanded);
                        },
                      ),
                    ),
                    ProductsList(
                      sheveId: shelves[index]["id"],
                      isExpanded: isExpanded,
                    ),
                  ],
                ),
              );
            },
            itemCount: shelves.length,
          ),
        ),
      ],
    );
  }
}
