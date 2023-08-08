import 'package:flutter/material.dart';
import 'package:shopping_list_app/pages/components/app_bar.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Column(
      children: [
      AppBarComponent(title: "Meus produtos", )
      ],
    );
  }
}
