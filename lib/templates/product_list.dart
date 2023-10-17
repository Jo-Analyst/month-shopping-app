import 'package:flutter/material.dart';

class ProductsList extends StatelessWidget {
  final int? sheveId;
  final bool isExpanded;
  final List<Map<String, dynamic>> shoppingList;
  const ProductsList({
    required this.shoppingList,
    this.sheveId,
    required this.isExpanded,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> products = shoppingList;
    // List<Map<String, dynamic>> products = [
    // {
    //   "name": "Arroz",
    //   "quantity": 1,
    //   "unit": "ML",
    //   "isChecked": false,
    //   "category_id": 2
    // },
    // {
    //   "name": "Feijão",
    //   "quantity": 3,
    //   "unit": "kg",
    //   "isChecked": false,
    //   "category_id": 2
    // },
    // {
    //   "name": "Macarrão",
    //   "quantity": 1,
    //   "unit": "PC",
    //   "isChecked": false,
    //   "category_id": 2
    // },
    // {
    //   "name": "Óleo",
    //   "quantity": 3,
    //   "unit": "PET",
    //   "isChecked": false,
    //   "category_id": 2
    // },
    // {
    //   "name": "Sal",
    //   "quantity": 1,
    //   "unit": "PC",
    //   "isChecked": false,
    //   "category_id": 2
    // },
    // {
    //   "name": "Açucar",
    //   "quantity": 1,
    //   "unit": "ML",
    //   "isChecked": false,
    //   "category_id": 2
    // },
    // {
    //   "name": "Farinha de Mandioca",
    //   "quantity": 1,
    //   "unit": "PC",
    //   "isChecked": false,
    //   "category_id": 2
    // },
    // {
    //   "name": "Farinha de milho",
    //   "quantity": 1,
    //   "unit": "PC",
    //   "isChecked": false,
    //   "category_id": 2
    // },
    // {
    //   "name": "Colorau",
    //   "quantity": 1,
    //   "unit": "PC",
    //   "isChecked": false,
    //   "category_id": 2
    // },
    // {
    //   "name": "Biscoito",
    //   "quantity": 1,
    //   "unit": "PC",
    //   "isChecked": false,
    //   "category_id": 3
    // },
    // {
    //   "name": "Leite integral",
    //   "quantity": 1,
    //   "unit": "CX",
    //   "isChecked": false,
    //   "category_id": 9
    // },
    // {
    //   "name": "Leite condesado",
    //   "quantity": 2,
    //   "unit": "CX",
    //   "isChecked": false,
    //   "category_id": 9
    // },
    // {
    //   "name": "Leite em pó",
    //   "quantity": 2,
    //   "unit": "CX",
    //   "isChecked": false,
    //   "category_id": 9
    // },
    // {
    //   "name": "Sabonete lafrore",
    //   "quantity": 3,
    //   "unit": "CX",
    //   "isChecked": false,
    //   "category_id": 10
    // },
    // ];

    return Container(
      color: const Color.fromARGB(25, 73, 133, 206),
      child: Column(
        children:
            products.where((e) => e["category_id"] == sheveId).map((product) {
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
                  // leading: CircleAvatar(
                  //   backgroundColor: Colors.black54,
                  //   maxRadius: 20,
                  //   child: Icon(
                  //     product["isChecked"]
                  //         ? Icons.check
                  //         : Icons.shopping_bag_outlined,
                  //     color: Colors.white,
                  //   ),
                  // ),
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
