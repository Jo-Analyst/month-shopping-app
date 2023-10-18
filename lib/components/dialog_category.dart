import 'package:flutter/material.dart';

String description = "";
final globalkey = GlobalKey<FormState>();
final typeCategoryController = TextEditingController();

void addCategory(BuildContext context) {
  if (globalkey.currentState!.validate()) {
    Navigator.of(context).pop(description.trim());
  }
}

Future<String?> showDialogCategory(
    BuildContext context, String? typeCategory) async {
  description = typeCategory ?? "";
  typeCategoryController.text = description;
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
            controller: typeCategoryController,
            textCapitalization: TextCapitalization.sentences,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: "Categoria",
            ),
            onChanged: (value) => description = value,
            onFieldSubmitted: (value) => addCategory(context),
            validator: (value) {
              if (value.toString().trim().isEmpty) {
                return "Informe a categoria";
              }

              return null;
            },
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text(
                "Salvar",
              ),
              onPressed: () => addCategory(context),
            ),
          ),
        ],
      );
    },
  );
}
