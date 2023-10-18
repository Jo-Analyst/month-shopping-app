import 'package:flutter/material.dart';

String name = "";
final globalkey = GlobalKey<FormState>();
final nameController = TextEditingController();

void addProduct(BuildContext context) {
  if (globalkey.currentState!.validate()) {
    Navigator.of(context).pop(name.trim());
  }
}

Future<String?> showDialogProductForm(
    BuildContext context, String? name) async {
  nameController.text = name ?? "";
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
              controller: nameController,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: "Produto",
              ),
              onChanged: (value) => name = value,
              onFieldSubmitted: (_) => addProduct(context),
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
              onPressed: () => addProduct(context),
            ),
          ),
        ],
      );
    },
  );
}
