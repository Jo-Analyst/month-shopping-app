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

  Future<void> load() async {
    _items.clear();
    final products = await ProductModel.findAll();
    for (var product in products) {
      _items.add(product);
    }
  }

  Future<void> delete(int id) async {
    await ProductModel.delete(id);
    _deleteItemById(id);
    notifyListeners();
  }

  void _deleteItemById(int id) {
    _items.removeWhere((items) => items["id"] == id);
  }

  void deleteItemByCategoryId(int categoryId) {
    _items.removeWhere((item) => item["category_id"] == categoryId);
    notifyListeners();
  }

  Future<void> save(
      List<Map<String, dynamic>> products, int categoryId, String type) async {
    for (var product in products) {
      int productId = await ProductModel.save(product, categoryId);
      if (product["id"] > 0) {
        _deleteItemById(product["id"]);
      }
      _items.add({
        "id": product["id"] > 0 ? product["id"] : productId,
        "name": product["name"],
        "unit": product["unit"],
        "type_category": type,
        "category_id": categoryId
      });
    }
    notifyListeners();
  }
}
