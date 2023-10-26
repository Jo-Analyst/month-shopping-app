import 'package:flutter/material.dart';
import 'package:month_shopping_app/providers/shopping_list_provider.dart';
import 'package:month_shopping_app/utils/convert_values.dart';
import 'package:provider/provider.dart';

class ProductsList extends StatelessWidget {
  final int? categoryId;
  final bool isExpanded;
  final List<Map<String, dynamic>> shopping;
  const ProductsList({
    required this.shopping,
    this.categoryId,
    required this.isExpanded,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> products = shopping;
    int index = 0;
    return Column(
      children:
          products.where((e) => e["category_id"] == categoryId).map((product) {
        index++;
        return Visibility(
          visible: isExpanded,
          child: Column(
            children: [
              Dismissible(
                key: Key(product["shoppe_list_id"].toString()),
                background: Container(
                  color: Theme.of(context).primaryColor,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 10),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) async {
                  final shoppingListProvider =
                      Provider.of<ShoppingListProvider>(context, listen: false);

                  await shoppingListProvider.checkList({
                    "shoppe_list_id": product["shoppe_list_id"],
                    "type_category": product["type_category"],
                    "unit": product["unit"],
                    "quantity": product["quantity"],
                    "product_id": product["product_id"],
                    "name": product["name"],
                    "category_id": product["category_id"],
                    "date_shoppe": dateFormat.format(DateTime.now()),
                  });
                },
                child: Container(
                  color: (index % 2 > 0)
                      ? const Color.fromARGB(25, 73, 133, 206)
                      : Colors.grey,
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.black54,
                      maxRadius: 20,
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "${product["quantity"]} ${product["unit"]} de ${product["name"]}",
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.displayLarge!.fontSize,
                      ),
                    ),
                  ),
                ),
              ),
              // Divider(
              //   color: Theme.of(context).primaryColor,
              // ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
