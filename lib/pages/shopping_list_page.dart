import 'package:flutter/material.dart';

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
              margin: EdgeInsets.only(
                  right: 0.05 * MediaQuery.of(context).size.width),
              child: IconButton(
                icon: Icon(
                  Icons.manage_search_outlined,
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
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            children: [
              SizedBox(
                height: showInputSearch
                    ? 0.62 * MediaQuery.of(context).size.height
                    : 0.685 * MediaQuery.of(context).size.height,
                child: Card(
                  elevation: 5,
                  child: products.isNotEmpty
                      ? SingleChildScrollView(
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
                              SizedBox(
                                  height: 0.02 *
                                      MediaQuery.of(context).size.height),
                              Column(
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
                            ],
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
