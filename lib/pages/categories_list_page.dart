import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:month_shopping_app/components/dialog_category.dart';
import 'package:month_shopping_app/components/icon_button_leading_app_bar.dart';
import 'package:month_shopping_app/providers/category_provider.dart';
import 'package:month_shopping_app/providers/product_provider.dart';
import 'package:month_shopping_app/utils/dialog.dart';
import 'package:month_shopping_app/utils/loading.dart';
import 'package:provider/provider.dart';

class CategoriesListPage extends StatefulWidget {
  final bool comesFromTheProductsScreen;
  const CategoriesListPage({
    required this.comesFromTheProductsScreen,
    super.key,
  });

  @override
  State<CategoriesListPage> createState() => _CategoriesListPageState();
}

class _CategoriesListPageState extends State<CategoriesListPage> {
  List<Map<String, dynamic>> categories = [];
  bool isValueInSearch = false, isLoading = true;
  String search = "";
  final searchController = TextEditingController();
  int index = 0;

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
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    bool confirmAction = await showDialogDelete(context,
            "Ao excluir a categoria, removerá produtos relacionados a ela. Deseja continuar?") ??
        false;

    if (!confirmAction) return;

    setState(() {
      categoryProvider.delete(id);
      productProvider.deleteItemByCategoryId(id);
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
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categoria"),
        leading: const IconButtonLeadingAppBar(),
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
        child: isLoading
            ? Center(
                child: loadingThreeRotatingDots(context, 50),
              )
            : Consumer<CategoryProvider>(
                builder: (context, categoryProvider, _) {
                  categories = categoryProvider.items;
                  return ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          controller: searchController,
                          decoration: InputDecoration(
                            labelText: "Busque a categoria aqui",
                            suffixIcon: IconButton(
                              onPressed: !isValueInSearch
                                  ? null
                                  : () {
                                      if (isValueInSearch) {
                                        searchController.text = "";
                                        isValueInSearch = false;
                                        loadCategories();
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
                              final categoryProvider =
                                  Provider.of<CategoryProvider>(
                                context,
                                listen: false,
                              );
                              categoryProvider.searchCategory(value);
                              isValueInSearch = value.isNotEmpty;
                            });
                          },
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                            fontSize: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .fontSize,
                          ),
                        ),
                      ),
                      categories.isEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height - 192,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.category,
                                    size: 80,
                                    color: Color.fromARGB(255, 73, 133, 206),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Adicione uma ou mais categorias",
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
                              ),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height - 192,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Card(
                                elevation: 4,
                                child: ListView(
                                  children: categories.map(
                                    (category) {
                                      index++;
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
                                            Visibility(
                                              visible: !widget
                                                  .comesFromTheProductsScreen,
                                              child: SlidableAction(
                                                onPressed: (_) =>
                                                    deleteCategory(
                                                        category["id"]),
                                                backgroundColor: Colors.red,
                                                icon: Icons.delete,
                                              ),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: widget
                                                      .comesFromTheProductsScreen
                                                  ? null
                                                  : () => Navigator.of(context)
                                                      .pop(category),
                                              child: Container(
                                                color: (index % 2 > 0)
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .displayMedium!
                                                        .color
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .titleLarge!
                                                        .color,
                                                child: ListTile(
                                                  minLeadingWidth: 0,
                                                  leading: const Icon(
                                                      Icons.category_outlined),
                                                  title: Text(
                                                    category["type_category"],
                                                    style: TextStyle(
                                                      fontSize:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .displayLarge!
                                                              .fontSize,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
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
