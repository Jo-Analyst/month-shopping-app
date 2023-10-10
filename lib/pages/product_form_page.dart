import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_list_app/components/dialog_product.dart';
import 'package:shopping_list_app/pages/category_list_page.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  List<Map<String, dynamic>> items = [];
  final categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                              labelText: "descrição",
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final category = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const CategoryListPage(),
                              ),
                            );

                            if (category != null) {
                              categoryController.text = category["description"];
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
                                    label: "Excluir",
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: const Icon(FontAwesomeIcons.box),
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
