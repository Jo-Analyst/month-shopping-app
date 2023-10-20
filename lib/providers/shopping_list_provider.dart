import 'package:flutter/material.dart';
import 'package:month_shopping_app/models/shopping_list_model.dart';

class ShoppingListProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> get items {
    return [
      ..._items
        ..sort(((a, b) => a["name"].toString().toLowerCase().compareTo(
              b["name"].toString().toLowerCase(),
            )),)
    ];
  }

  Future<void> save(List<Map<String, dynamic>> itemsShoppe) async {
    for (var item in itemsShoppe) {
      await ShoppingListModel(
        productId: item["product_id"],
        quantity: item["quantity"],
        unit: item["unit"],
      ).save();

      _items.add({
        "product_id": item["product_id"],
        "name": item["name"],
        "type_category": item["type_category"],
        "category_id": item["category_id"],
        "quantity": item["quantity"],
        "unit": item["unit"]
      });
    }
    notifyListeners();
  }

  Future<void> loadShopping() async {
    _items.clear();
    final shopping = await ShoppingListModel.findAll();
    for (var shoppe in shopping) {
      _items.add(shoppe);
    }
  }
}
