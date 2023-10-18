import 'package:flutter/material.dart';
import 'package:month_shopping_app/models/category_model.dart';
import 'package:month_shopping_app/utils/search_list.dart';

class CategoryProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> itemsFiltered = [];
  List<Map<String, dynamic>> get items {
    return [
      ..._items
        ..sort(((a, b) => a["type_category"].toString().toLowerCase().compareTo(
              b["type_category"].toString().toLowerCase(),
            )))
    ];
  }

  Future<void> save(Map<String, dynamic> data) async {
    final categoryId =
        await CategoryModel(id: data["id"], type: data["type_category"]).save();
    if (data["id"] != 0) {
      deleteItem(data["id"]);
    }

    data["id"] = data["id"] == 0 ? categoryId : data["id"];

    _items.add(data);
    itemsFiltered.add(data);
    notifyListeners();
  }

  Future<void> loadCategories() async {
    clear();
    final categories = await CategoryModel.findAll();
    for (var category in categories) {
      _items.add(category);
    }
    itemsFiltered.addAll(categories);
  }

  void clear() {
    _items.clear();
    itemsFiltered.clear();
  }

  void delete(int id) async {
    await CategoryModel.delete(id);
    deleteItem(id);
    notifyListeners();
  }

  void deleteItem(int id) {
    _items.removeWhere((i) => i["id"] == id);
    itemsFiltered.removeWhere((i) => i["id"] == id);
  }

  Future<void> searchCategory(String type) async {
    _items.clear();
    _items = searchItems(type, itemsFiltered, "type_category");
    notifyListeners();
  }
}
