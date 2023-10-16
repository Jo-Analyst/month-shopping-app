import 'package:month_shopping_app/config/db.dart';
import 'package:month_shopping_app/models/category_model.dart';

class ProductModel {
  final int? id;
  final String name;

  ProductModel({
    this.id,
    required this.name,
  });

  static Future<List<Map<String, dynamic>>> findAll() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT * FROM products AS p INNER JOIN categories AS c ON c.product_id = p.id");
  }

  Future<int> save(List<Map<String, dynamic>> categories) async {
    final db = await DB.openDatabase();
    int lastId = 0;
    await db.transaction((txn) async {
      lastId = await txn.insert("table", {"name": name});
      for (var categorie in categories) {
        await CategoryModel(
          productId: lastId,
          type: categorie["type_category"],
        ).save(txn);
      }
    });

    return lastId;
  }
}
