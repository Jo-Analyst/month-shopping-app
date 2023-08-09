import 'package:flutter/material.dart';

import '../components/app_bar.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  bool showInputSearch = false;

  toggleShowInputSearch() {
    setState(() {
      showInputSearch = !showInputSearch;
    });
  }

  final List<Map<String, dynamic>> products = [
    {"name": "Arroz", "quantity": 1, "unit": "ML", "isChecked": false},
    {"name": "Feijão", "quantity": 3, "unit": "kg", "isChecked": false},
    {"name": "Macarrão", "quantity": 1, "unit": "PC", "isChecked": false},
    {"name": "Óleo", "quantity": 3, "unit": "PET", "isChecked": false},
    {"name": "Sal", "quantity": 1, "unit": "PC", "isChecked": false},
    {"name": "Açucar", "quantity": 1, "unit": "ML", "isChecked": false},
    {
      "name": "Farinha de Mandioca",
      "quantity": 1,
      "unit": "PC",
      "isChecked": false
    },
    {
      "name": "Farinha de milho",
      "quantity": 1,
      "unit": "PC",
      "isChecked": false
    },
    {"name": "Colorau", "quantity": 1, "unit": "PC", "isChecked": false},
    {"name": "Biscoito", "quantity": 1, "unit": "PC", "isChecked": false},
  ];

  final _searchProduct = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: const Icon(
                  Icons.manage_search_outlined,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () => toggleShowInputSearch(),
              ),
            ),
          ],
          toolbarHeight: 100,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Minha lista de compras",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            children: [
              Visibility(
                visible: showInputSearch,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _searchProduct,
                  decoration: const InputDecoration(
                    label: Text("Produto"),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: showInputSearch
                    ? MediaQuery.of(context).size.height - 350
                    : MediaQuery.of(context).size.height - 290,
                child: Card(
                  elevation: 5,
                  child: products.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: products.map((product) {
                              return Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.black54,
                                      maxRadius: 20,
                                      child: Icon(
                                        product["isChecked"]
                                            ? Icons.check
                                            : Icons.shopping_bag_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text(
                                        "${product["quantity"]} ${product["unit"]} de ${product["name"]}"),
                                  ),
                                  const Divider(),
                                ],
                              );
                            }).toList(),
                          ),
                        )
                      : const Center(
                          child: Text(
                              "Não há produtos selecionados para a compra"),
                        ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
