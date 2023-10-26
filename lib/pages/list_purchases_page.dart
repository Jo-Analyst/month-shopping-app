import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_shopping_app/components/dialog_unit.dart';
import 'package:month_shopping_app/components/icon_button_leading_app_bar.dart';
import 'package:month_shopping_app/pages/product_list_shopping_page.dart';
import 'package:month_shopping_app/providers/shopping_list_provider.dart';
import 'package:provider/provider.dart';

class LisPurchasesPage extends StatefulWidget {
  final List<Map<String, dynamic>> shopping;
  const LisPurchasesPage({
    required this.shopping,
    super.key,
  });

  @override
  State<LisPurchasesPage> createState() => _LisPurchasesPageState();
}

class _LisPurchasesPageState extends State<LisPurchasesPage> {
  final quantityController = TextEditingController();
  final unitController = TextEditingController();
  List<Map<String, dynamic>> shopping = [];
  List<Map<String, dynamic>> deletedItems = [];

  void addListShopping() async {
    final shoppingListProvider =
        Provider.of<ShoppingListProvider>(context, listen: false);

    for (var shoppe in shopping) {
      shoppe["shoppe_list_id"] = await shoppingListProvider.save(shoppe);
    }

    if (widget.shopping.isNotEmpty) {
      for (var deletedItem in deletedItems) {
        await shoppingListProvider.delete(deletedItem["shoppe_list_id"]);
      }
    }
  }

  void loadShopping() async {
    setState(() {
      final shoppingList = widget.shopping;
      for (var shoppe in shoppingList) {
        shopping.add({
          "shoppe_list_id": shoppe["shoppe_list_id"],
          "type_category": shoppe["type_category"],
          'unit': shoppe["unit"],
          'quantity': shoppe["quantity"],
          'product_id': shoppe["product_id"],
          'name': shoppe["name"],
          'category_id': shoppe["category_id"]
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadShopping();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonLeadingAppBar(),
        title: const Text("Listar compras"),
        actions: [
          Visibility(
            visible: shopping.isNotEmpty || deletedItems.isNotEmpty,
            child: IconButton(
              onPressed: () {
                addListShopping();

                Navigator.of(context).pop(shopping);
              },
              icon: const Icon(
                Icons.check,
                size: 35,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: ListView(
          children: [
            InkWell(
              onTap: () async {
                final products = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ProductListShoppingPage(),
                  ),
                );

                if (products != null) {
                  setState(() {
                    for (var product in products) {
                      // Verifique se o produto não está na lista de compras
                      bool productExistsInShopping = shopping.any((shoppe) =>
                          shoppe["product_id"] == product["product_id"]);

                      if (!productExistsInShopping) {
                        shopping.add(product);
                      }
                    }
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Listar compras",
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.displayLarge!.fontSize,
                        color: Theme.of(context).textTheme.displayLarge!.color,
                      ),
                    ),
                    Icon(
                      Icons.format_list_bulleted_add,
                      color: Theme.of(context).textTheme.titleMedium!.color,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 4,
              color: Theme.of(context).primaryColor,
            ),
            shopping.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 150,
                    child: Center(
                      child: Text(
                        "Não há produtos listados para a compra",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .fontSize,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: shopping.map(
                      (shoppe) {
                        return Column(
                          children: [
                            Slidable(
                              endActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) {
                                      setState(() {
                                        shopping.removeWhere(
                                          (shopp) =>
                                              shopp["product_id"] ==
                                              shoppe["product_id"],
                                        );
                                        if (widget.shopping.isNotEmpty) {
                                          deletedItems.add(shoppe);
                                        }
                                      });
                                    },
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.box,
                                        size: 25,
                                      ),
                                      const SizedBox(width: 5),
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          shoppe["name"],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .displayLarge!
                                                .fontSize,
                                            color: Theme.of(context)
                                                .textTheme
                                                .displayLarge!
                                                .color,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final unit =
                                              await showDialogUnit(context);
                                          if (unit != null) {
                                            setState(() {
                                              shoppe["unit"] = unit;
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 1),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              shoppe["unit"].toString(),
                                              style: TextStyle(
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .displayLarge!
                                                    .fontSize,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .displayLarge!
                                                    .color,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 40,
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                shoppe["quantity"].toString(),
                                                style: TextStyle(
                                                  fontSize: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge!
                                                      .fontSize,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge!
                                                      .color,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () => setState(() {
                                                  shoppe["quantity"]++;
                                                }),
                                                child: const Icon(
                                                  Icons.keyboard_arrow_up,
                                                  size: 28,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => setState(() {
                                                  if (shoppe["quantity"] > 1) {
                                                    shoppe["quantity"]--;
                                                  }
                                                }),
                                                child: const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  size: 28,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Theme.of(context).primaryColor,
                              height: 2,
                            )
                          ],
                        );
                      },
                    ).toList(),
                  )
          ],
        ),
      ),
    );
  }
}
