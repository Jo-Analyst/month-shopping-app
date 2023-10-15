import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DB {
  static Future<sql.Database> openDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, "appShoppingList.db"),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE products (id INTEGER PRIMARY KEY, name TEXT NOT NULL)",
        );

        db.execute(
          "CREATE TABLE categories (id INTEGER PRIMARY KEY, type_category TEXT NOT NULL, product_id INTEGER, FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE)",
        );

        db.execute(
            "CREATE TABLE shopping_list (id INTEGER PRIMARY KEY, quantity INTEGER, unit TEXT, product_id INTEGER NOT NULL, FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE )");
      },
      version: 1,
    );
  }
}
