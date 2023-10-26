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
          style: TextStyle(color: Colors.black),
        ),
        content: Form(
          key: globalkey,
          child: TextFormField(
            controller: typeCategoryController,
            textCapitalization: TextCapitalization.sentences,
            autofocus: true,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              labelText: "Categoria",
              floatingLabelStyle: TextStyle(color: Colors.black),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).textTheme.bodyLarge!.color,
              ),
              child: Text(
                "Salvar",
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.displayLarge!.fontSize),
              ),
              onPressed: () => addCategory(context),
            ),
          ),
        ],
      );
    },
  );
}
