import 'package:flutter/material.dart';

import 'components/app_bar.dart';

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarComponent(
          title: "Minha lista de compras",
          action: Container(
            margin: const EdgeInsets.only(right: 30),
            child: const Icon(
              Icons.manage_search_outlined,
              size: 50,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
