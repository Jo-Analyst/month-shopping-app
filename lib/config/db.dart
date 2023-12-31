import 'dart:io';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DB {
  static Future<sql.Database> openDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, "month_shopping_app.db"),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE products (id INTEGER PRIMARY KEY, name TEXT NOT NULL, unit TEXT NOT NULL, category_id INTEGER, FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE)",
        );

        await db.execute(
          "CREATE TABLE categories (id INTEGER PRIMARY KEY, type_category TEXT NOT NULL)",
        );

        await db.execute(
            "CREATE TABLE shopping_list (id INTEGER PRIMARY KEY, quantity INTEGER, unit TEXT, list_is_ckecked BLOB DEFAULT 0, date_shoppe TEXT, product_id INTEGER NOT NULL, FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE)");

        await db.execute("CREATE TABLE theme (is_dark  BLOB)");

        await db.insert("theme", {"is_dark": 0});
      },
      version: 1,
    );
  }

  static bool existsDB() {
    File file = File(
        '/data/user/0/com.example.month_shopping_app/databases/month_shopping_app.db');

    return file.existsSync();
  }
}
