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
        builder: (_) => const CategoriesListPage(isScreenProducts: false),
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

    categoryId = widget.item["category_id"];
    typeCategory = widget.item["type_category"];
    categoryController.text = typeCategory;
    products.add({
      "id": widget.item["id"],
      "name": widget.item["name"],
      "unit": widget.item["unit"],
      "category_id": categoryId
    });
  }

  void receiveProduct(String? nameProduct, String? unitProduct) async {
    final product =
        await showDialogProductForm(context, nameProduct, unitProduct);

    if (product != null) {
      setState(() {
        if (widget.item.isEmpty) {
          products.add({
            "id": widget.item.isEmpty ? 0 : widget.item["id"],
            "name": product["name"],
            "unit": product["unit"],
            "category_id": categoryId
          });
          return;
        }

        // Ao atualizar  executa a linha abaixo
        products[0]["name"] = product["name"];
        products[0]["unit"] = product["unit"];
        products[0]["category_id"] = categoryId;
      });
    }
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
        ),
        body: SingleChildScrollView(
          child: Column(
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
                      Text(
                        "Categoria",
                        style: TextStyle(
                          fontSize: 18,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
                        ),
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
                                enabledBorder: UnderlineInputBorder(),
                              ),
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
                              onTap: () => openScreenCategories(),
                            ),
                          ),
                          IconButton(
                            onPressed: () => openScreenCategories(),
                            icon: Icon(
                              Icons.format_list_bulleted_add,
                              size: 35,
                              color: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .color,
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
                        onTap: widget.item.isNotEmpty
                            ? null
                            : () => receiveProduct(null, null),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.item.isEmpty ? "Produtos" : "Produto",
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color,
                              ),
                            ),
                            Visibility(
                              visible: widget.item.isEmpty,
                              child: Icon(
                                Icons.add,
                                size: 35,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .color,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2 + 76,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Container(
                              color: (index % 2 == 0)
                                  ? Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .color
                                  : Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .color,
                              child: Slidable(
                                endActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) {
                                        setState(() {
                                          if (widget.item.isEmpty) {
                                            products.removeAt(index);
                                          } else {
                                            receiveProduct(product["name"],
                                                product["unit"]);
                                          }
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
                                child: ListTile(
                                  leading: const Icon(
                                    FontAwesomeIcons.box,
                                    size: 25,
                                  ),
                                  title: Text(product["name"]),
                                  trailing: Text(
                                    product["unit"],
                                    style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .fontSize,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
