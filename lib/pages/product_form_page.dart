import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_shopping_app/components/dialog_product.dart';
import 'package:month_shopping_app/components/icon_button_leading_app_bar.dart';
import 'package:month_shopping_app/pages/categories_list_page.dart';
import 'package:month_shopping_app/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductFormPage extends StatefulWidget {
  final Map<String, dynamic> item;
  const ProductFormPage({
    required this.item,
    super.key,
  });

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  List<Map<String, dynamic>> products = [];
  final categoryController = TextEditingController();
  int categoryId = 0;
  String typeCategory = "";

  void saveProducts() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    await productProvider.save(products, categoryId, typeCategory);
  }

  void openScreenCategories() async {
    final categorySelected = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CategoriesListPage(),
      ),
    );
    if (categorySelected != null) {
      typeCategory = categorySelected["type_category"];
      categoryController.text = typeCategory;
      categoryId = categorySelected["id"];
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.item.isEmpty) return;

    categoryId = widget.item["id"];
    typeCategory = widget.item["type_category"];
    categoryController.text = typeCategory;
    products.add({
      "id": widget.item["id"],
      "name": widget.item["name"],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: typeCategory.trim().isEmpty || products.isEmpty
                  ? null
                  : () {
                      saveProducts();
                      Navigator.of(context).pop();
                    },
              icon: const Icon(
                Icons.check,
                size: 35,
              ),
            ),
          ],
          leading: const IconButtonLeadingAppBar(),
          title: const Text("Produto"),
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: 80,
        ),
        body: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Categoria",
                      style: TextStyle(fontSize: 18),
                    ),
                    Divider(
                      color: Theme.of(context).primaryColor,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .8 - 15,
                          child: TextFormField(
                            controller: categoryController,
                            readOnly: true,
                            textInputAction: TextInputAction.none,
                            decoration: const InputDecoration(
                              labelText: "Tipo",
                            ),
                            onTap: () => openScreenCategories(),
                          ),
                        ),
                        IconButton(
                          onPressed: () => openScreenCategories(),
                          icon: Icon(
                            Icons.format_list_bulleted_add,
                            size: 35,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        final name = await showDialogProductForm(context);

                        if (name != null) {
                          setState(() {
                            products.add({
                              "id": 0,
                              "name": name,
                            });
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.item.isEmpty ? "Produtos" : "Produto",
                            style: const TextStyle(fontSize: 18),
                          ),
                          Visibility(
                            visible: widget.item.isEmpty,
                            child: Icon(
                              Icons.add,
                              size: 35,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).primaryColor,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (_) {
                                  setState(() {
                                    if (widget.item.isEmpty) {
                                      products.removeAt(index);
                                    } else {}
                                  });
                                },
                                backgroundColor: widget.item.isEmpty
                                    ? Colors.red
                                    : Colors.orange,
                                foregroundColor: Colors.white,
                                icon: widget.item.isEmpty
                                    ? Icons.delete
                                    : Icons.edit,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(
                                  FontAwesomeIcons.box,
                                  size: 25,
                                ),
                                title: Text(product["name"]),
                              ),
                              Divider(
                                height: 2,
                                color: Theme.of(context).primaryColor,
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
