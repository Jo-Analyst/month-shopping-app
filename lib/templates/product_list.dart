import 'package:flutter/material.dart';

class ProductsList extends StatelessWidget {
  final int? categoryId;
  final bool isExpanded;
  final List<Map<String, dynamic>> shoppingList;
  const ProductsList({
    required this.shoppingList,
    this.categoryId,
    required this.isExpanded,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> products = shoppingList;
    
    return Container(
      color: const Color.fromARGB(25, 73, 133, 206),
      child: Column(
        children: products
            .where((e) => e["category_id"] == categoryId)
            .map((product) {
          return Visibility(
            visible: isExpanded,
            child: Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.black54,
                    maxRadius: 20,
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                      "${product["quantity"]} ${product["unit"]} de ${product["name"]}"),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
