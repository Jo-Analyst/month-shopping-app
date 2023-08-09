import 'package:flutter/material.dart';

class ProductsList extends StatelessWidget {
  final int? sheveId;
  final bool isExpanded;
  const ProductsList({this.sheveId, super.key, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        "name": "Arroz",
        "quantity": 1,
        "unit": "ML",
        "isChecked": false,
        "shelve_id": 2
      },
      {
        "name": "Feijão",
        "quantity": 3,
        "unit": "kg",
        "isChecked": false,
        "shelve_id": 2
      },
      {
        "name": "Macarrão",
        "quantity": 1,
        "unit": "PC",
        "isChecked": false,
        "shelve_id": 2
      },
      {
        "name": "Óleo",
        "quantity": 3,
        "unit": "PET",
        "isChecked": false,
        "shelve_id": 2
      },
      {
        "name": "Sal",
        "quantity": 1,
        "unit": "PC",
        "isChecked": false,
        "shelve_id": 2
      },
      {
        "name": "Açucar",
        "quantity": 1,
        "unit": "ML",
        "isChecked": false,
        "shelve_id": 2
      },
      {
        "name": "Farinha de Mandioca",
        "quantity": 1,
        "unit": "PC",
        "isChecked": false,
        "shelve_id": 2
      },
      {
        "name": "Farinha de milho",
        "quantity": 1,
        "unit": "PC",
        "isChecked": false,
        "shelve_id": 2
      },
      {
        "name": "Colorau",
        "quantity": 1,
        "unit": "PC",
        "isChecked": false,
        "shelve_id": 2
      },
      {
        "name": "Biscoito",
        "quantity": 1,
        "unit": "PC",
        "isChecked": false,
        "shelve_id": 3
      },
      {
        "name": "Leite integral",
        "quantity": 1,
        "unit": "CX",
        "isChecked": false,
        "shelve_id": 9
      },
    ];

    return Container(
      color: const Color.fromARGB(255, 240, 232, 232),
      child: Column(
        children:
            products.where((e) => e["shelve_id"] == sheveId).map((product) {
          return Visibility(
            visible: isExpanded,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.black54,
                    maxRadius: 20,
                    child: Icon(
                      product["isChecked"]
                          ? Icons.check
                          : Icons.shopping_bag_outlined,
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
