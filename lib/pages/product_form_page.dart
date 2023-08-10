import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Produtos"),
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: 100,
        ),
        body: const Center(
          child: Text("Produto formulário"),
        ));
  }
}
