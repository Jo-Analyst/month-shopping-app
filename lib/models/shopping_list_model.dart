import 'package:month_shopping_app/config/db.dart';

class ShoppingListModel {
  final int id;
  final int quantity;
  final int productId;
  final String unit;

  ShoppingListModel({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.unit,
  });

  Future<int> save() async {
    int lastId = id;
    final db = await DB.openDatabase();
    if (id == 0) {
      lastId = await db.insert("shopping_list", {
        "unit": unit,
        "quantity": quantity,
        "product_id": productId,
      });
    } else {
      await db.update("shopping_list",
          {"unit": unit, "quantity": quantity, "product_id": productId},
          where: "id = ?", whereArgs: [id]);
    }

    return lastId;
  }

  static Future<void> delete(int id) async {
    final db = await DB.openDatabase();
    await db.delete("shopping_list", where: "id = ?", whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> findAllIsNotChecked() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT s.id AS shoppe_list_id, c.type_category, s.unit, s.quantity, p.id AS product_id, p.name, p.category_id  FROM  shopping_list AS s INNER JOIN products AS p  ON p.id = s.product_id INNER JOIN categories AS c ON c.id = P.category_id WHERE list_is_ckecked = 0");
  }

  static Future<List<Map<String, dynamic>>> findAllIsChecked() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT s.id AS shoppe_list_id, c.type_category, s.unit, s.quantity, s.date_shoppe, p.id AS product_id, p.name, p.category_id  FROM  shopping_list AS s INNER JOIN products AS p  ON p.id = s.product_id INNER JOIN categories AS c ON c.id = P.category_id WHERE list_is_ckecked = 1");
  }

  static Future<void> checkList(int shoppingListId, String dateShoppe) async {
    final db = await DB.openDatabase();
    await db.update(
        "shopping_list",
        {
          "list_is_ckecked": true,
          "date_shoppe": dateShoppe,
        },
        where: "id = ?",
        whereArgs: [shoppingListId]);
  }

  static Future<void> unverifyList(int shoppingListId) async {
    final db = await DB.openDatabase();
    await db.update(
        "shopping_list", {"list_is_ckecked": false, "date_shoppe": null},
        where: "id = ?", whereArgs: [shoppingListId]);
  }
}
