import 'package:flutter/material.dart';
import 'package:month_shopping_app/utils/uppercase.dart';

String unit = "";
final globalkey = GlobalKey<FormState>();

Future<String?> showDialogUnit(BuildContext context) async {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Form(
          key: globalkey,
          child: TextFormField(
            inputFormatters: [UpperCaseTextFormatter()],
            textCapitalization: TextCapitalization.characters,
            autofocus: true,
            maxLength: 5,
            decoration: const InputDecoration(
              labelText: "Unidade",
            ),
            onChanged: (value) => unit = value.toUpperCase().trim(),
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
                  Navigator.of(context).pop(unit);
                }
              },
            ),
          ),
        ],
      );
    },
  );
}
