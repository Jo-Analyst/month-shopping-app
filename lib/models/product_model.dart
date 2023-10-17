import 'package:month_shopping_app/config/db.dart';
import 'package:sqflite/sqflite.dart';

class ProductModel {
  final int? id;
  final String name;
  final int? categoryId;

  ProductModel({
    this.id,
    required this.name,
    this.categoryId,
  });

  static Future<List<Map<String, dynamic>>> findAll() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT * FROM products AS p INNER JOIN categories AS c ON c.product_id = p.id");
  }

  Future<int> save(Transaction txn) async {
    int lastId = await txn.insert("products", {
      "name": name,
      "category_id": categoryId,
    });

    return lastId;
  }
}
