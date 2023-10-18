import 'package:flutter/material.dart';

class IconButtonLeadingAppBar extends StatelessWidget {
  const IconButtonLeadingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.keyboard_arrow_left,
        size: 35,
      ),
    );
  }
}
