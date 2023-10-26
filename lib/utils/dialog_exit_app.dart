import 'package:flutter/material.dart';

Future<String?> showDialogApp(BuildContext context, String content) async {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          "Sair",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        content: Text(
          content,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            child: const Text(
              'Cancelar',
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            child: const Text(
              'Não',
            ),
            onPressed: () {
              Navigator.of(context).pop("Sair");
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            child: const Text(
              "Sim",
            ),
            onPressed: () {
              Navigator.of(context).pop("Sair e gerar backup");
            },
          ),
        ],
      );
    },
  );
}
