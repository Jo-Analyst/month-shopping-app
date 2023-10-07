import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {"name": "Arroz", "id": 1, "shelve": "Alimentos"},
      {"name": "Feijão", "id": 2, "shelve": "Alimentos"},
      {"name": "Macarrão", "id": 3, "shelve": "Alimentos"},
      {"name": "Óleo", "id": 4, "shelve": "Alimentos"},
      {"name": "Sal", "id": 5, "shelve": "Alimentos"},
      {"name": "Açucar", "id": 6, "shelve": "Alimentos"},
      {"name": "Farinha de Mandioca", "id": 7, "shelve": "Alimentos"},
      {"name": "Farinha de milho", "id": 8, "shelve": "Alimentos"},
      {"name": "Colorau", "id": 9, "shelve": "Alimentos"},
      {"name": "Biscoito", "id": 10, "shelve": "Guloseima"},
      {"name": "Leite integral", "id": 11, "shelve": "laticionius"},
      {"name": "Leite condensado", "id": 12, "shelve": "laticionius"},
      {"name": "Leite em pó", "id": 13, "shelve": "laticionios"},
      {"name": "Sabonete lafrore", "id": 14, "shelve": "higiene"},
    ];

    return ListView(
      children: [
        AppBar(
          title: Text(
            "Produtos",
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
                                product["shelve"],
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit,
                                      color: Theme.of(context).primaryColor,
                                      size: 25,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList()),
        ),
      ],
    );
  }
}
