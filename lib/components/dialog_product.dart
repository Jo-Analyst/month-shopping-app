import 'package:flutter/material.dart';
import 'package:month_shopping_app/utils/uppercase.dart';

String name = "", unit = "";
final globalkey = GlobalKey<FormState>();
final nameController = TextEditingController();
final unitController = TextEditingController();

void addProduct(BuildContext context) {
  if (globalkey.currentState!.validate()) {
    Map<String, dynamic> data = {"name": name.trim(), "unit": unit.trim()};
    Navigator.of(context).pop(data);
  }
}

Future<Map<String, dynamic>?> showDialogProductForm(
    BuildContext context, String? nameEditing, String? unitEditing) async {
  name = nameEditing ?? "";
  unit = unitEditing ?? "";
  nameController.text = name;
  unitController.text = unit;

  return showDialog<Map<String, dynamic>>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          nameEditing == null ? "Novo" : "Alteração",
          style: const TextStyle(color: Colors.black),
        ),
        content: Form(
            key: globalkey,
            child: SizedBox(
              height: 172,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: "Produto",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      floatingLabelStyle: TextStyle(color: Colors.black),
                    ),
                    style: const TextStyle(color: Colors.black),
                    onChanged: (value) => name = value,
                    onFieldSubmitted: (_) => addProduct(context),
                    validator: (value) {
                      if (value.toString().trim().isEmpty || value == null) {
                        return "Informe o produto";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: unitController,
                    inputFormatters: [UpperCaseTextFormatter()],
                    maxLength: 5,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: "Unidade de medida",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      floatingLabelStyle: TextStyle(color: Colors.black),
                    ),
                    style: const TextStyle(color: Colors.black),
                    onChanged: (value) => unit = value,
                    onFieldSubmitted: (_) => addProduct(context),
                    validator: (value) {
                      if (value.toString().trim().isEmpty || value == null) {
                        return "Informe a unidade de medida";
                      }

                      return null;
                    },
                  ),
                ],
              ),
            )),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).textTheme.bodyLarge!.color,
              ),
              child: Text(
                nameEditing == null ? "Adicionar" : "Alterar",
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.displayLarge!.fontSize),
              ),
              onPressed: () => addProduct(context),
            ),
          ),
        ],
      );
    },
  );
}
