import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:month_shopping_app/shopping_list_app.dart';

void main() async {
  initializeDateFormatting('pt_BR', null);
  runApp(const ShoppingListApp());
}
