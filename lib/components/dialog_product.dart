import 'package:flutter/material.dart';

String name = "";
final globalkey = GlobalKey<FormState>();

Future<String?> showDialogProductForm(BuildContext context) async {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          "Novo",
        ),
        content: Form(
            key: globalkey,
            child: TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Produto",
              ),
              onChanged: (value) => name = value,
              validator: (value) {
                if (value.toString().trim().isEmpty) {
                  return "Informe o produto";
                }

                return null;
              },
            )),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text(
                "Adicionar",
              ),
              onPressed: () {
                if (globalkey.currentState!.validate()) {
                  Navigator.of(context).pop(name);
                }
              },
            ),
          ),
        ],
      );
    },
  );
}
