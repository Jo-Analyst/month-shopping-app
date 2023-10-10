import 'package:flutter/material.dart';
import 'package:shopping_list_app/pages/list_purchases_page.dart';
import 'package:shopping_list_app/templates/product_list.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  bool showInputSearch = false, isExpanded = false;
  List<bool> cardTriggeredList = [];

  openScreenListPurchases() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const LisPurchasesPage(),
      ),
    );
  }

  void setListCardTriggered() {
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        cardTriggeredList.add(false);
      });
    }
  }

  updateListCardTriggered(int index) {
    setState(() {
      cardTriggeredList[index] = !cardTriggeredList[index];
    });
  }

  // prateleiras
  final List<Map<String, dynamic>> categories = [
    {"id": 1, "name": "Congelados"},
    {"id": 2, "name": "Alimentos"},
    {"id": 3, "name": "Guloseima"},
    {"id": 4, "name": "Limpeza"},
    {"id": 5, "name": "Utensilios"},
    {"id": 6, "name": "Padaria"},
    {"id": 7, "name": "Beleza"},
    {"id": 8, "name": "Feira"},
    {"id": 9, "name": "Laticínios"},
    {"id": 10, "name": "Higiene"},
  ];

  @override
  void initState() {
    super.initState();
    setListCardTriggered();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AppBar(
          actions: [
            Container(
              margin: const EdgeInsets.only(
                right: 10,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () => openScreenListPurchases(),
              ),
            ),
          ],
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Minha lista de compras",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 25,
          ),
          height: MediaQuery.of(context).size.height * 0.8,
          child: categories.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 8,
                      color: Colors.white,
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              updateListCardTriggered(index);
                            },
                            contentPadding: const EdgeInsets.all(15),
                            title: Text(
                              categories[index]["name"],
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .fontSize,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                cardTriggeredList[index]
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_right,
                                color: Theme.of(context).primaryColor,
                                size: 30,
                              ),
                              onPressed: () {
                                updateListCardTriggered(index);
                              },
                            ),
                          ),
                          ProductsList(
                            sheveId: categories[index]["id"],
                            isExpanded: cardTriggeredList[index],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: categories.length,
                )
              : const Center(
                  child:
                      Text("Você ainda não listou os produtos para compra.")),
        ),
      ],
    );
  }
}
