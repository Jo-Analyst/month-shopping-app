import 'package:flutter/material.dart';
import 'package:month_shopping_app/models/shopping_list_model.dart';

class ShoppingListProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> get items {
    return [
      ..._items
        ..sort(
          ((a, b) => a["name"].toString().toLowerCase().compareTo(
                b["name"].toString().toLowerCase(),
              )),
        )
    ];
  }

  Future<int> save(Map<String, dynamic> itemShoppe) async {
    int shoppingListId = itemShoppe["shoppe_list_id"] ?? 0;
    int shoppeListId = await ShoppingListModel(
      id: shoppingListId,
      productId: itemShoppe["product_id"],
      quantity: itemShoppe["quantity"],
      unit: itemShoppe["unit"],
    ).save();

    if (shoppeListId > 0) {
      _deleteItem(shoppingListId);
    }

    _items.add({
      "shoppe_list_id": shoppeListId,
      "product_id": itemShoppe["product_id"],
      "name": itemShoppe["name"],
      "type_category": itemShoppe["type_category"],
      "category_id": itemShoppe["category_id"],
      "quantity": itemShoppe["quantity"],
      "unit": itemShoppe["unit"]
    });
    notifyListeners();
    return shoppeListId;
  }

  Future<void> checkList(int shoppingListId) async {
    await ShoppingListModel.checkList(shoppingListId);
    _deleteItem(shoppingListId);
    notifyListeners();
  }

  Future<void> delete(int id) async {
    await ShoppingListModel.delete(id);
    _deleteItem(id);
    notifyListeners();
  }

  void _deleteItem(int id) {
    _items.removeWhere((i) => i["shoppe_list_id"] == id);
  }

  Future<void> loadShoppingIsNotChecked() async {
    _items.clear();
    final shopping = await ShoppingListModel.findAllIsNotChecked();
    for (var shoppe in shopping) {
      _items.add(shoppe);
    }
  }

  Future<void> loadShoppingIsChecked() async {
    _items.clear();
    final shopping = await ShoppingListModel.findAllIsChecked();
    for (var shoppe in shopping) {
      _items.add(shoppe);
    }
  }
}
