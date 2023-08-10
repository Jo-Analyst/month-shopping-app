import 'package:flutter/material.dart';
import 'package:shopping_list_app/pages/product_form_page.dart';

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
      {"name": "Leite em pó", "id": 13, "shelve": "laticionius"},
      {"name": "Sabonete lafrore", "id": 14, "shelve": "higiene"},
    ];

    return Column(
      children: [
        AppBar(
          title: Text(
            "Produtos",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize),
          ),
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 30),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProductFormPage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 40,
                    color: Colors.white,
                  ),
                )),
          ],
          toolbarHeight: 100,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height * 0.7,
          child: products.isEmpty
              ? const Center(
                  child: Text(
                    "Não há produtos cadastrado.",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      elevation: 8,
                      child: ListTile(
                        title: Text(
                          products[index]["name"],
                          style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.bodyLarge!.fontSize,
                          ),
                        ),
                        subtitle: Text(
                          products[index]["shelve"],
                          style: const TextStyle(
                            fontSize: 18,
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
                    );
                  },
                ),
        ),
      ],
    );
  }
}
