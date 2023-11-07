import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  bool isLoading = true, isValueInSearch = false;
  final searchController = TextEditingController();

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
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            title: Text(
              "Produtos",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
              ),
            ),
          ),
          isLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height - 160,
                  child: Center(
                    child: loadingThreeRotatingDots(context, 50),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 25,
                  ),
                  child: Consumer<ProductProvider>(
                    builder: (_, productProvider, __) {
                      products = productProvider.items;

                      return Column(
                        children: [
                          TextFormField(
                            onTapOutside: (_) =>
                                FocusScope.of(context).unfocus(),
                            controller: searchController,
                            decoration: InputDecoration(
                              labelText: "Busque o produto aqui",
                              suffixIcon: IconButton(
                                onPressed: !isValueInSearch
                                    ? null
                                    : () {
                                        if (isValueInSearch) {
                                          searchController.text = "";
                                          isValueInSearch = false;
                                          loadProducts();
                                        }
                                      },
                                icon: Icon(
                                  isValueInSearch ? Icons.close : Icons.search,
                                  color:
                                      const Color.fromARGB(255, 111, 111, 111),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                final productProvider =
                                    Provider.of<ProductProvider>(
                                  context,
                                  listen: false,
                                );
                                productProvider.searchProduct(value);
                                isValueInSearch = value.isNotEmpty;
                              });
                            },
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .fontSize,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            height: MediaQuery.of(context).size.height - 280,
                            child: products.isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.box,
                                        size: 80,
                                        color:
                                            Color.fromARGB(255, 73, 133, 206),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Adicione um ou mais produtos.",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .color,
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .fontSize,
                                        ),
                                      ),
                                    ],
                                  )
                                : SingleChildScrollView(
                                    child: Column(
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
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (_) =>
                                                                ProductFormPage(
                                                              item: product,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      backgroundColor:
                                                          Colors.orange,
                                                      icon: Icons.edit,
                                                      foregroundColor:
                                                          Colors.white,
                                                    ),
                                                    SlidableAction(
                                                      onPressed: (_) async {
                                                        final confirmAction =
                                                            await showDialogDelete(
                                                                    context,
                                                                    "Deseja mesmo excluir o produto?") ??
                                                                false;

                                                        if (confirmAction) {
                                                          await productProvider
                                                              .delete(product[
                                                                  "id"]);
                                                        }
                                                      },
                                                      backgroundColor:
                                                          Colors.red,
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
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      product["name"],
                                                      style: TextStyle(
                                                        fontSize:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .fontSize,
                                                      ),
                                                    ),
                                                  ),
                                                  subtitle: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        product[
                                                            "type_category"],
                                                        style: TextStyle(
                                                          fontSize:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displayLarge!
                                                                  .fontSize,
                                                          color: Colors.grey,
                                                        )),
                                                  ),
                                                  trailing: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    alignment:
                                                        Alignment.centerLeft,
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
                                    ),
                                  ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
