import 'package:flutter/material.dart';

class ShoppingListAppPage extends StatefulWidget {
  const ShoppingListAppPage({super.key});

  @override
  State<ShoppingListAppPage> createState() => _ShoppingListAppPageState();
}

class _ShoppingListAppPageState extends State<ShoppingListAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.list_alt_sharp,
              color: Colors.white,
              size: 45,
            ),
            Text(
              "Lista de compras",
              style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const Center(
        child: Text("Minha lista de compras"),
      ),
    );
  }
}
