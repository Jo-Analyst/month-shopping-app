import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_shopping_app/providers/product_provider.dart';
import 'package:month_shopping_app/utils/dialog.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Map<String, dynamic>> products = [
    // {"name": "Arroz", "id": 1, "type_category": "Alimentos"},
    // {"name": "Feijão", "id": 2, "type_category": "Alimentos"},
    // {"name": "Macarrão", "id": 3, "type_category": "Alimentos"},
    // {"name": "Óleo", "id": 4, "type_category": "Alimentos"},
    // {"name": "Sal", "id": 5, "type_category": "Alimentos"},
    // {"name": "Açucar", "id": 6, "type_category": "Alimentos"},
    // {"name": "Farinha de Mandioca", "id": 7, "type_category": "Alimentos"},
    // {"name": "Farinha de milho", "id": 8, "type_category": "Alimentos"},
    // {"name": "Colorau", "id": 9, "type_category": "Alimentos"},
    // {"name": "Biscoito", "id": 10, "type_category": "Guloseima"},
    // {"name": "Leite integral", "id": 11, "type_category": "laticionius"},
    // {"name": "Leite condensado", "id": 12, "type_category": "laticionius"},
    // {"name": "Leite em pó", "id": 13, "type_category": "laticionios"},
    // {"name": "Sabonete lafrore", "id": 14, "type_category": "higiene"},
  ];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    await productProvider.load();
    setState(() {
      products = productProvider.items;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          child: Consumer<ProductProvider>(
            builder: (_, productProvider, __) {
              products = productProvider.items;

              return products.isEmpty
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
                              child: Slidable(
                                endActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) {},
                                      backgroundColor: Colors.orange,
                                      icon: Icons.edit,
                                      foregroundColor: Colors.white,
                                    ),
                                    SlidableAction(
                                      onPressed: (_) async {
                                        final confirmAction =
                                            await showDialogDelete(context,
                                                    "Deseja mesmo excluir o produto?") ??
                                                false;

                                        if (confirmAction) {
                                          await productProvider
                                              .delete(product["id"]);
                                        }
                                      },
                                      backgroundColor: Colors.red,
                                      icon: Icons.delete,
                                    ),
                                  ],
                                ),
                                child: ListTile(
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
                                      product["type_category"],
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
            },
          ),
        ),
      ],
    );
  }
}
