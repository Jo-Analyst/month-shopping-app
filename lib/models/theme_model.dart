import 'package:month_shopping_app/config/db.dart';

class ThemeModel {
  static void insert() async {
    final db = await DB.openDatabase();
    await db.insert("theme", {"is_dark": false});
  }

  static Future<void> toggleTheme(int isDarkMode) async {
    final db = await DB.openDatabase();
    await db.update("theme", {"is_dark": isDarkMode});
  }

  static Future<List<Map<String, dynamic>>> find() async {
    final db = await DB.openDatabase();
    return db.rawQuery("SELECT * FROM theme");
  }
}
