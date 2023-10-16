import 'package:flutter/material.dart';
import 'package:month_shopping_app/utils/uppercase.dart';

String description = "";
final globalkey = GlobalKey<FormState>();
final unitController = TextEditingController();

Future<String?> showDialogUnit(BuildContext context, String unit) async {
  unitController.text = unit.toUpperCase();
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Form(
          key: globalkey,
          child: TextFormField(
            inputFormatters: [UpperCaseTextFormatter()],
            controller: unitController,
            textCapitalization: TextCapitalization.characters,
            autofocus: true,
            maxLength: 5,
            decoration: const InputDecoration(
              labelText: "Unidade",
            ),
            onChanged: (value) => description = value.toUpperCase().trim(),
            validator: (value) {
              if (value.toString().trim().isEmpty) {
                return "Informe a unidade";
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
                "Alterar",
              ),
              onPressed: () {
                if (globalkey.currentState!.validate()) {
                  Navigator.of(context).pop(description);
                }
              },
            ),
          ),
        ],
      );
    },
  );
}
