import 'package:flutter/material.dart';
import 'package:month_shopping_app/models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
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
        await CategoryModel(id: data["id"] ?? 0, type: data["type_category"])
            .save();

    data["id"] = categoryId;
    _items.add(data);
    notifyListeners();
  }

  Future<void> loadCategories() async {
    _items.clear();
    final categories = await CategoryModel.findAll();
    for (var category in categories) {
      _items.add(category);
    }
  }
}
