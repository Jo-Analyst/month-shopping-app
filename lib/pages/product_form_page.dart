import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_shopping_app/components/dialog_product.dart';
import 'package:month_shopping_app/pages/category_list_page.dart';
import 'package:month_shopping_app/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  List<Map<String, dynamic>> items = [];
  final categoryController = TextEditingController();
  String category = "";

  void saveProducts() async {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    //  productProvider.save(category, productId, products)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: category.trim().isEmpty || items.isEmpty
                  ? null
                  : () => saveProducts,
              icon: const Icon(
                Icons.check,
                size: 35,
              ),
            ),
          ],
          leading: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_left,
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final categorySelected =
                                await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const CategoryListPage(),
                              ),
                            );

                            if (categorySelected != null) {
                              category = categorySelected["type_category"];
                              categoryController.text = category;
                            }
                          },
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
                            items.add({
                              "id": 0,
                              "name": name,
                            });
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Produtos",
                            style: TextStyle(fontSize: 18),
                          ),
                          Icon(
                            Icons.add,
                            size: 35,
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).primaryColor,
                    ),
                    Column(
                      children: items
                          .map(
                            (item) => Slidable(
                              endActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) {
                                      setState(() {
                                        items.removeWhere(
                                          (i) => i["id"] == item["id"],
                                        );
                                      });
                                    },
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,                                   
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
                                    title: Text(item["name"]),
                                  ),
                                  Divider(
                                    height: 2,
                                    color: Theme.of(context).primaryColor,
                                  )
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
