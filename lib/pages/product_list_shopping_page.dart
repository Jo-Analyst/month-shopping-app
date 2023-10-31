import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_shopping_app/components/icon_button_leading_app_bar.dart';
import 'package:month_shopping_app/pages/product_form_page.dart';
import 'package:month_shopping_app/providers/product_provider.dart';
import 'package:month_shopping_app/utils/loading.dart';
import 'package:provider/provider.dart';

class ProductListShoppingPage extends StatefulWidget {
  const ProductListShoppingPage({super.key});

  @override
  State<ProductListShoppingPage> createState() =>
      _ProductListShoppingPageState();
}

class _ProductListShoppingPageState extends State<ProductListShoppingPage> {
  List<Map<String, dynamic>> products = [], productsSelected = [];
  bool isLoading = true, isValueInSearch = false;
  final searchController = TextEditingController();

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
              "type_category": dataProduct["type_category"],
              "quantity": 1,
              "unit": dataProduct["unit"],
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
          "type_category": product["type_category"],
          "quantity": 1,
          "unit": product["unit"],
        });
      }
    });
  }

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
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ProductFormPage(item: {}),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              size: 30,
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
      body: isLoading
          ? Center(
              child: loadingThreeRotatingDots(context, 50),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
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
                            color: const Color.fromARGB(255, 111, 111, 111),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          final productProvider = Provider.of<ProductProvider>(
                            context,
                            listen: false,
                          );
                          productProvider.searchProduct(value);
                          isValueInSearch = value.isNotEmpty;
                        });
                      },
                      style: TextStyle(
                        color: Theme.of(context).textTheme.displayLarge!.color,
                        fontSize:
                            Theme.of(context).textTheme.displayLarge!.fontSize,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 25,
                      ),
                      height: MediaQuery.of(context).size.height - 188,
                      child: Consumer<ProductProvider>(
                        builder: (context, productProvider, _) {
                          products = productProvider.items;
                          return products.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.box,
                                      size: 80,
                                      color: Color.fromARGB(255, 73, 133, 206),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Adicione um ou mais produtos.",
                                      style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .fontSize,
                                          color: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .color),
                                    ),
                                  ],
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                      children: products
                                          .map(
                                            (product) => Card(
                                              elevation: 8,
                                              child: ListTile(
                                                onLongPress: () =>
                                                    selectProducts(product),
                                                onTap: () {
                                                  if (productsSelected
                                                      .isNotEmpty) {
                                                    selectProducts(product);
                                                    return;
                                                  }

                                                  Navigator.of(context).pop([
                                                    {
                                                      "product_id":
                                                          product["id"],
                                                      "name": product["name"],
                                                      "category_id": product[
                                                          "category_id"],
                                                      "type_category": product[
                                                          "type_category"],
                                                      "quantity": 1,
                                                      "unit": product["unit"],
                                                    }
                                                  ]);
                                                },
                                                selected: productsSelected.any(
                                                    (productSelect) =>
                                                        productSelect[
                                                            "product_id"] ==
                                                        product["id"]),
                                                selectedTileColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                selectedColor: Colors.white,
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
                                                    product["type_category"],
                                                    style: TextStyle(
                                                        fontSize:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .displayLarge!
                                                                .fontSize,
                                                        color: Colors.grey),
                                                  ),
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
                                          )
                                          .toList()),
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
