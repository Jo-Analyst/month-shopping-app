import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_shopping_app/components/icon_button_leading_app_bar.dart';

class ProductListShoppingPage extends StatefulWidget {
  const ProductListShoppingPage({super.key});

  @override
  State<ProductListShoppingPage> createState() =>
      _ProductListShoppingPageState();
}

class _ProductListShoppingPageState extends State<ProductListShoppingPage> {
  final List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Arroz",
      "category_id": 2,
      "category": "Alimentos",
    },
    {
      "id": 2,
      "name": "Feijão",
      "category_id": 2,
      "category": "Alimentos",
    },
    {
      "id": 3,
      "name": "Macarrão",
      "category_id": 2,
      "category": "Alimentos",
    },
    {
      "id": 4,
      "name": "Óleo",
      "category_id": 2,
      "category": "Alimentos",
    },
    {
      "id": 5,
      "name": "Sal",
      "category_id": 2,
      "category": "Alimentos",
    },
    {
      "id": 6,
      "name": "Alho",
      "category_id": 2,
      "category": "Alimentos",
    },
    {
      "id": 7,
      "name": "Açucar",
      "category_id": 2,
      "category": "Alimentos",
    },
    {
      "id": 8,
      "name": "Farinha",
      "category_id": 2,
      "category": "Alimentos",
    },
    {
      "id": 9,
      "name": "Fubá",
      "category_id": 2,
      "category": "Alimentos",
    },
    {
      "id": 10,
      "name": "Leite em pó",
      "category_id": 9,
      "category": "Laticinios",
    },
    {
      "id": 11,
      "name": "Uva",
      "category_id": 8,
      "category": "Frutas",
    },
    {
      "id": 12,
      "name": "Yorgute",
      "category_id": 9,
      "category": "laticionios",
    },
    {
      "id": 13,
      "name": "Leite condesado",
      "category_id": 9,
      "category": "laticionios",
    },
    {
      "id": 14,
      "name": "Queijo",
      "category_id": 9,
      "category": "laticionios",
    },
    {
      "id": 15,
      "name": "Papel Higiênico",
      "category_id": 10,
      "category": "higiene",
    },
  ];

  List<Map<String, dynamic>> productsSelected = [];

  void selectProducts(Map<String, dynamic> dataProduct) {
    final result = productsSelected.any(
      (product) => product["name"] == dataProduct["name"],
    );

    setState(() {
      !result
          ? productsSelected.add({
              "product_id": dataProduct["id"],
              "name": dataProduct["name"],
              "category_id": dataProduct["category_id"],
              "quantity": 1,
              "unit": "UND",
            })
          : productsSelected.removeWhere(
              (product) => product["name"] == dataProduct["name"],
            );
    });
  }

  void selectAllProducts() {
    setState(() {
      if (productsSelected.length == products.length) {
        productsSelected.clear();
        return;
      }

      productsSelected.clear();
      for (var product in products) {
        productsSelected.add({
          "product_id": product["id"],
          "name": product["name"],
          "category_id": product["category_id"],
          "quantity": 1,
          "unit": "UND",
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonLeadingAppBar(),
        actions: [
          Visibility(
            visible: productsSelected.isNotEmpty,
            child: IconButton(
              onPressed: () => selectAllProducts(),
              icon: const Icon(
                Icons.select_all,
                size: 30,
              ),
            ),
          ),
          Visibility(
            visible: productsSelected.isNotEmpty,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(productsSelected),
              icon: const Icon(
                Icons.check,
                size: 30,
              ),
            ),
          ),
        ],
        title: Text(
          "Produtos",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 25,
            ),
            height: MediaQuery.of(context).size.height * 0.89,
            child: products.isEmpty
                ? const Center(
                    child: Text(
                      "Não há produtos cadastrado.",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView(
                    children: products
                        .map(
                          (product) => Card(
                            elevation: 8,
                            child: ListTile(
                              onLongPress: () => selectProducts(product),
                              onTap: () {
                                if (productsSelected.isNotEmpty) {
                                  selectProducts(product);
                                  return;
                                }

                                Navigator.of(context).pop([
                                  {
                                    "product_id": product["id"],
                                    "name": product["name"],
                                    "quantity": 1,
                                    "unit": "UND",
                                  }
                                ]);
                              },
                              selected: productsSelected.any((productSelect) =>
                                  productSelect["product_id"] == product["id"]),
                              selectedTileColor: Theme.of(context).primaryColor,
                              selectedColor: Colors.white,
                              minLeadingWidth: 0,
                              leading: const Icon(
                                FontAwesomeIcons.box,
                                size: 25,
                              ),
                              title: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  product["name"],
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .fontSize,
                                  ),
                                ),
                              ),
                              subtitle: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  product["category"],
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList()),
          ),
        ],
      ),
    );
  }
}
