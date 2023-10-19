import 'package:flutter/material.dart';
import 'package:month_shopping_app/pages/list_purchases_page.dart';
import 'package:month_shopping_app/providers/category_provider.dart';
import 'package:month_shopping_app/templates/product_list.dart';
import 'package:provider/provider.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  bool showInputSearch = false, isExpanded = false;
  List<bool> cardTriggeredList = [];
  List<Map<String, dynamic>> shoppingList = [];

  openScreenListPurchases() async {
    final response = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const LisPurchasesPage(),
      ),
    );

    if (response != null) {
      shoppingList = response;
    }
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

  List<Map<String, dynamic>> categories = [
    // {"id": 1, "type_category": "Congelados"},
    // {"id": 2, "type_category": "Alimentos"},
    // {"id": 3, "type_category": "Guloseima"},
    // {"id": 4, "type_category": "Limpeza"},
    // {"id": 5, "type_category": "Utensilios"},
    // {"id": 6, "type_category": "Padaria"},
    // {"id": 7, "type_category": "Beleza"},
    // {"id": 8, "type_category": "Feira"},
    // {"id": 9, "type_category": "Laticínios"},
    // {"id": 10, "type_category": "Higiene"},
  ];

  @override
  void initState() {
    super.initState();
    setListCardTriggered();
    // loadCategory();
  }

  void loadCategory() async {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    await categoryProvider.loadCategories();
    setState(() {
      categories = categoryProvider.items;
    });
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
                  Icons.add_shopping_cart_outlined,
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
                              categories[index]["type_category"],
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
                              shoppingList: shoppingList),
                        ],
                      ),
                    );
                  },
                  itemCount: categories.length,
                )
              : const Center(
                  child: Text("Você ainda não listou os produtos para compra."),
                ),
        ),
      ],
    );
  }
}
