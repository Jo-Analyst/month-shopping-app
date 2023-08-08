import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget {
  final String title;
  const AppBarComponent({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        title,
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize),
      ),
    );
  }
}
