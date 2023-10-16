import 'package:flutter/material.dart';
import 'package:month_shopping_app/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _items = [];
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
}
