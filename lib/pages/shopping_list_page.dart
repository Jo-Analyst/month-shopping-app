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
        centerTitle: true,
        title: const Text("Lista de compras", style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 130, 78, 220),
      ),
      body: const Center(
        child: Text("Minha lista de compras"),
      ),
    );
  }
}
