import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  List<Map<String, dynamic>> items = [
    {"id": 1, "name": "Arroz"},
    {"id": 2, "name": "Feijão"},
    {"id": 3, "name": "Óleo"},
    {"id": 4, "name": "Açucar"},
  ];
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
                      "Prateleira",
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
                            textInputAction: TextInputAction.none,
                            decoration:
                                const InputDecoration(labelText: "Categoria"),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_box_rounded,
                              size: 50,
                              color: Theme.of(context).primaryColor,
                            ))
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
                      onTap: () => print("oi"),
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
                          .map((item) => Dismissible(
                                key: Key(item["name"]),
                                onDismissed: (direction) {
                                  items.removeWhere(
                                      (i) => i["id"] == item["id"]);
                                },
                                background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                direction: DismissDirection.endToStart,
                                child: ListTile(
                                  leading: const Icon(FontAwesomeIcons.box),
                                  title: Text(item["name"]),
                                ),
                              ))
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
