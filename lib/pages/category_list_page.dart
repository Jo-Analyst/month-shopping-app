import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:month_shopping_app/components/dialog_category.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<Map<String, dynamic>> categories = [];

  void addNewCategory() async {
    final response = await showDialogCategory(context);
    if (response != null) {
      setState(() {
        categories.add(
          {
            "id": 0,
            "type_category": response,
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categoria"),
        actions: [
          IconButton(
            onPressed: () => addNewCategory(),
            icon: const Icon(
              Icons.add,
              size: 35,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Busque a categoria aqui",
                border: OutlineInputBorder(),
              ),
            ),
            categories.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 192,
                    child: Center(
                      child: Text(
                        "Adicione uma ou mais categorias",
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .fontSize,
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height - 192,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListView(
                      children: categories.map(
                        (category) {
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) => addNewCategory(),
                                  backgroundColor: Colors.orange,
                                  icon: Icons.edit,
                                  label: "Editar",
                                  foregroundColor: Colors.white,
                                ),
                                SlidableAction(
                                  onPressed: (_) {
                                    setState(() {
                                      categories.removeWhere(
                                        (ct) => ct["id"] == category["id"],
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
                                InkWell(
                                  onTap: () =>
                                      Navigator.of(context).pop(category),
                                  child: ListTile(
                                    title: Text(
                                      category["type_category"],
                                      style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .fontSize,
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
