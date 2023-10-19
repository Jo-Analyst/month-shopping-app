import 'package:month_shopping_app/config/db.dart';

class ShoppingListModel {
  final int quantity;
  final int productId;
  final String unit;

  ShoppingListModel({
    required this.productId,
    required this.quantity,
    required this.unit,
  });

  void save() async {
    final db = await DB.openDatabase();
    await db.insert("shopping_list", {
      "unit": unit,
      "quantity": quantity,
      "product_id": productId,
    });
  }

  static void delete(int id) async {
    final db = await DB.openDatabase();
    await db.delete("shopping_list", where: "id = ?", whereArgs: ["id"]);
  }

  static Future<List<Map<String, dynamic>>> findAll() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT c.type_category, s.unit, s.quantity,  FROM  shopping_list AS s INNER JOIN products AS p  ON p.id = s.product_id INNER JOIN categories AS c ON c.id = P.category_id");
  }
}
