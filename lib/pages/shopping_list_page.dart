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
  List<Map<String, dynamic>> shopping = [];
  List<Map<String, dynamic>> categories = [];

  openScreenListPurchases() async {
    final response = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LisPurchasesPage(shopping: shopping),
      ),
    );

    if (response != null) {
      shopping = response;
      categories = getUniqueCategories(shopping);
      setListCardTriggered();
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
      shopping = shoppingProvider.items;
      categories = getUniqueCategories(shopping);
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
        Consumer<ShoppingListProvider>(
          builder: (context, shoppingProvider, __) {
            shopping = shoppingProvider.items;

            categories = getUniqueCategories(shopping);
            cardTriggeredList.add(false);

            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 25,
              ),
              height: MediaQuery.of(context).size.height * 0.8,
              child: shopping.isNotEmpty
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
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: Theme.of(context).primaryColor,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    updateListCardTriggered(index);
                                  },
                                ),
                              ),
                              ProductsList(
                                categoryId: categories[index]["category_id"],
                                isExpanded: cardTriggeredList[index],
                                shopping: shopping,
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: categories.length,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/ic_launcher.png",
                          width: 100,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Olá, seja bem vindo.",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Faça a sua lista de compras de um jeito fácil e rápido.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .fontSize,
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ],
    );
  }
}
