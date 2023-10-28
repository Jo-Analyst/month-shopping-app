import 'package:flutter/material.dart';
import 'package:month_shopping_app/utils/uppercase.dart';

String unit = "";
final globalkey = GlobalKey<FormState>();
void updateUnit(BuildContext context) {
  if (globalkey.currentState!.validate()) {
    Navigator.of(context).pop(unit);
  }
}

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
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              floatingLabelStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            onChanged: (value) => unit = value.toUpperCase().trim(),
            onFieldSubmitted: (_) => updateUnit(context),
            style: const TextStyle(color: Colors.black),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).textTheme.bodyLarge!.color,
              ),
              child: const Text(
                "Alterar",
              ),
              onPressed: () => updateUnit(context),
            ),
          ),
        ],
      );
    },
  );
}
