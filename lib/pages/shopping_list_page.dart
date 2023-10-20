import 'package:flutter/material.dart';
import 'package:month_shopping_app/pages/list_purchases_page.dart';
import 'package:month_shopping_app/providers/shopping_list_provider.dart';
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
    for (int i = 0; i < shopping.length; i++) {
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

  List<Map<String, dynamic>> shopping = [];

  @override
  void initState() {
    super.initState();
    loadShopping();
  }

  void loadShopping() async {
    final shoppingProvider =
        Provider.of<ShoppingListProvider>(context, listen: false);
    await shoppingProvider.loadShopping();
    setState(() {
      shoppingList = shoppingProvider.items;
      shopping = getUniqueCategories(shoppingList);
      setListCardTriggered();
    });
  }

  List<Map<String, dynamic>> getUniqueCategories(
      List<Map<String, dynamic>> productList) {
    Map<String, Map<String, dynamic>> uniqueCategoryMap = {};

    for (var product in productList) {
      String typeCategory = product["type_category"];
      int categoryId = product["category_id"];

      if (!uniqueCategoryMap.containsKey(typeCategory)) {
        uniqueCategoryMap[typeCategory] = {
          "type_category": typeCategory,
          "category_id": categoryId,
        };
      }
    }

    return uniqueCategoryMap.values.toList();
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
          child: shopping.isNotEmpty
              ? Consumer<ShoppingListProvider>(
                  builder: (context, shoppingProvider, __) {
                    shoppingList = shoppingProvider.items;

                    shopping = getUniqueCategories(shoppingList);
                    cardTriggeredList.add(false);

                    return ListView.builder(
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
                                  shopping[index]["type_category"],
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
                                categoryId: shopping[index]["category_id"],
                                isExpanded: cardTriggeredList[index],
                                shoppingList: shoppingList,
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: shopping.length,
                    );
                  },
                )
              : const Center(
                  child: Text("Você ainda não listou os produtos para compra."),
                ),
        ),
      ],
    );
  }
}
