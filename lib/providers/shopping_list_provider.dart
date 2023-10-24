import 'package:flutter/material.dart';
import 'package:month_shopping_app/models/shopping_list_model.dart';
import 'package:month_shopping_app/utils/convert_values.dart';

class ShoppingListProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> get items {
    return [
      ..._items
        ..sort(
          ((a, b) {
            final dateComparison = a["type_category"]
                .toString()
                .toLowerCase()
                .compareTo(b["type_category"].toString().toLowerCase());

            if (dateComparison != 0) {
              return dateComparison;
            } else {
              return a["name"]
                  .toString()
                  .toLowerCase()
                  .compareTo(b["name"].toString().toLowerCase());
            }
          }),
        )
    ];
  }

  final List<Map<String, dynamic>> _itemsChecked = [];
  List<Map<String, dynamic>> get itemsChecked {
    return [
      ..._itemsChecked
        ..sort(
          ((a, b) {
            final dateComparison = b["date_shoppe"]
                .toString()
                .toLowerCase()
                .compareTo(a["date_shoppe"].toString().toLowerCase());

            if (dateComparison != 0) {
              return dateComparison; // Compara as datas primeiro
            } else {
              return a["name"].toString().toLowerCase().compareTo(b["name"]
                  .toString()
                  .toLowerCase()); // Compara os nomes em caso de empate nas datas
            }
          }),
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

    itemShoppe["shoppe_list_id"] = shoppeListId;
    add(itemShoppe, false);

    notifyListeners();
    return shoppeListId;
  }

  void add(Map<String, dynamic> itemShoppe, bool isCheckedList) {
    _items.add({
      "shoppe_list_id": itemShoppe["shoppe_list_id"],
      "product_id": itemShoppe["product_id"],
      "name": itemShoppe["name"],
      "type_category": itemShoppe["type_category"],
      "category_id": itemShoppe["category_id"],
      "quantity": itemShoppe["quantity"],
      "date_shoppe": isCheckedList ? dateFormat.format(DateTime.now()) : null,
      "unit": itemShoppe["unit"]
    });
  }

  Future<void> checkList(Map<String, dynamic> itemShoppe) async {
    await ShoppingListModel.checkList(
        itemShoppe["shoppe_list_id"], itemShoppe["date_shoppe"]);
    _deleteItem(itemShoppe["shoppe_list_id"]);
    _itemsChecked.add(itemShoppe);
    notifyListeners();
  }

  Future<void> unverifyList(Map<String, dynamic> itemShoppe) async {
    await ShoppingListModel.unverifyList(itemShoppe["shoppe_list_id"]);
    _deleteItemChecked(
      itemShoppe["shoppe_list_id"],
    );
    add(itemShoppe, false);
    notifyListeners();
  }

  Future<void> delete(int id) async {
    await ShoppingListModel.delete(id);
    _deleteItem(id);
    _deleteItemChecked(id);
    notifyListeners();
  }

  void _deleteItem(int id) {
    _items.removeWhere((i) => i["shoppe_list_id"] == id);
  }

  void _deleteItemChecked(int id) {
    _itemsChecked.removeWhere((i) => i["shoppe_list_id"] == id);
  }

  Future<void> loadShoppingIsNotChecked() async {
    _items.clear();
    final shopping = await ShoppingListModel.findAllIsNotChecked();
    for (var shoppe in shopping) {
      _items.add(shoppe);
    }
  }

  Future<void> loadShoppingIsChecked() async {
    _itemsChecked.clear();
    final shopping = await ShoppingListModel.findAllIsChecked();
    for (var shoppe in shopping) {
      _itemsChecked.add(shoppe);
    }
  }
}
