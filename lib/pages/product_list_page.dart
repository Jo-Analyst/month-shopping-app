import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_shopping_app/pages/categories_list_page.dart';
import 'package:month_shopping_app/pages/product_form_page.dart';
import 'package:month_shopping_app/providers/product_provider.dart';
import 'package:month_shopping_app/utils/dialog.dart';
import 'package:month_shopping_app/utils/loading.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Map<String, dynamic>> products = [];
  bool isLoading = true;

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
      isLoading = false;
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
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const CategoriesListPage(
                    isScreenProducts: true,
                  ),
                ),
              ),
              icon: const Icon(Icons.category_outlined),
            ),
          ],
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

              return isLoading
                  ? Center(
                      child: loadingThreeRotatingDots(context, 50),
                    )
                  : products.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              FontAwesomeIcons.box,
                              size: 80,
                              color: Colors.black87,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Adicione um ou mais produtos.",
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .fontSize),
                            ),
                          ],
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
                                          onPressed: (_) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => ProductFormPage(
                                                  item: product,
                                                ),
                                              ),
                                            );
                                          },
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
                                      trailing: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          product["unit"],
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
