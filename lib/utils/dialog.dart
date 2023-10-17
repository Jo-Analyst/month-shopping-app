import 'package:flutter/material.dart';

Future<bool?> showDialogDelete(BuildContext context, String content) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          "Excluir",
        ),
        content: Text(content),
        actions: [
          TextButton(
            child: const Text(
              'Cancelar',
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          ElevatedButton(
            child: const Text(
              "Excluir",
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
