import 'package:flutter/material.dart';
import 'package:month_shopping_app/config/db.dart';
import 'package:month_shopping_app/shopping_list_app.dart';

void main() async {
  runApp(const ShoppingListApp());
  final db = await DB.openDatabase();
  await db.delete("shopping_list");
}
