import 'package:month_shopping_app/config/db.dart';

class ProductModel {
  static Future<List<Map<String, dynamic>>> findAll() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT p.id, p.name, c.type_category FROM products AS p INNER JOIN categories AS c ON c.id = p.category_id");
  }

  static Future<int> save(Map<String, dynamic> products, int categoryId) async {
    final db = await DB.openDatabase();
    int lastId = 0;
    await db.transaction((txn) async {
      if (products["id"] > 0) {
        await txn.update(
            "products",
            {
              "name": products["name"],
              "category_id": categoryId,
            },
            where: "id = ?",
            whereArgs: [products["id"]]);
        return;
      }

      lastId = await txn.insert("products", {
        "name": products["name"],
        "category_id": categoryId,
      });
    });

    return lastId;
  }

  static Future<void> delete(int id) async {
    final db = await DB.openDatabase();
    await db.delete("products", where: "id = ?", whereArgs: [id]);
  }
}
