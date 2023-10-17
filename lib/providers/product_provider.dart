import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:month_shopping_app/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> get items {
    return [
      ..._items
        ..sort(((a, b) => a["name"].toString().toLowerCase().compareTo(
              b["name"].toString().toLowerCase(),
            )))
    ];
  }

  void load() async {
    final products = await ProductModel.findAll();
    for (var product in products) {
      _items.add(product);
    }
  }

  void save(
      String type, int productId, List<Map<String, dynamic>> products) async {
    // final productIds = await CategoryModel(type: type).save(products);

    // for (int i = 0; i < products.length; i++) {
    //   _items.add({
    //     "id": productIds[i],
    //     "name": products[i]["name"],
    //     "type_category": type,
    //   });
    // }

    notifyListeners();
  }
}
