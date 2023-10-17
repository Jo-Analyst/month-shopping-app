import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:month_shopping_app/components/dialog_category.dart';
import 'package:month_shopping_app/providers/category_provider.dart';
import 'package:month_shopping_app/utils/dialog.dart';
import 'package:provider/provider.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<Map<String, dynamic>> categories = [];

  void saveNewCategory(Map<String, dynamic> category) async {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    final response = await showDialogCategory(
        context, category.isEmpty ? null : category["type_category"]);
    if (response != null) {
      await categoryProvider.save({
        "id": category.isEmpty ? 0 : category["id"],
        "type_category": response,
      });
    }
  }

  void deleteCategory(int id) async {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    bool confirmAction = await showDialogDelete(
            context, "Deseja mesmo excluir esta categoria?") ??
        false;

    if (!confirmAction) return;

    setState(() {
      categoryProvider.delete(id);
    });
  }

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  void loadCategories() async {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    await categoryProvider.loadCategories();
    setState(() {
      categories = categoryProvider.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categoria"),
        actions: [
          IconButton(
            onPressed: () => saveNewCategory({}),
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
        child: Consumer<CategoryProvider>(
          builder: (context, categoryProvider, _) {
            categories = categoryProvider.items;
            return ListView(
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
                                      onPressed: (_) =>
                                          saveNewCategory(category),
                                      backgroundColor: Colors.orange,
                                      icon: Icons.edit,
                                      foregroundColor: Colors.white,
                                    ),
                                    SlidableAction(
                                      onPressed: (_) =>
                                          deleteCategory(category["id"]),
                                      backgroundColor: Colors.red,
                                      icon: Icons.delete,
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
            );
          },
        ),
      ),
    );
  }
}
