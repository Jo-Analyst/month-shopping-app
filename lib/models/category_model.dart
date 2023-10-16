import 'package:sqflite/sqflite.dart';

class CategoryModel {
  final String type;
  final int productId;

  CategoryModel({
    required this.type,
    required this.productId,
  });

  Future<void> save(Transaction txn) async {
    await txn
        .insert("categories", {"type_category": type, "product_id": productId});
  }
}
