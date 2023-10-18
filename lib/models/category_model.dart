import 'package:month_shopping_app/config/db.dart';
import 'package:month_shopping_app/models/product_model.dart';

class CategoryModel {
  final int id;
  final String type;

  CategoryModel({
    required this.id,
    required this.type,
  });

  Future<int> save() async {
    final db = await DB.openDatabase();
    int lastId = 0;
    if (id == 0) {
      lastId = await db.insert("categories", {"type_category": type});
    } else {
      await db.update("categories", {"type_category": type},
          where: "id = ?", whereArgs: [id]);
    }

    return lastId;
  }

  static Future<void> delete(int id) async {
    final db = await DB.openDatabase();
    await db.transaction((txn) async {
      await txn.delete("categories", where: "id = ?", whereArgs: [id]);
      await ProductModel.deleteByCategoryId(txn, id);
    });
  }

  static Future<List<Map<String, dynamic>>> findAll() async {
    final db = await DB.openDatabase();
    return db.query("categories");
  }
}
