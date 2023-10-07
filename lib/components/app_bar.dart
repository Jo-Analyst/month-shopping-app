import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget {
  final String title;
  final Widget? action;
  const AppBarComponent({required this.title, this.action, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [action!],
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        title,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
        ),
      ),
    );
  }
}
