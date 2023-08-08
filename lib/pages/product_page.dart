import 'package:flutter/material.dart';
import 'package:shopping_list_app/pages/components/app_bar.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        AppBarComponent(
          title: "Meus produtos",
          action: Container(
            margin: const EdgeInsets.only(right: 30),
            child: const Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
