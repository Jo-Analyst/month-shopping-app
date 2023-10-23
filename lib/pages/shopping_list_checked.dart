import 'package:flutter/material.dart';
import 'package:month_shopping_app/providers/shopping_list_provider.dart';
import 'package:month_shopping_app/utils/dialog.dart';
import 'package:provider/provider.dart';

class ShoppingListChecked extends StatefulWidget {
  const ShoppingListChecked({super.key});

  @override
  State<ShoppingListChecked> createState() => _ShoppingListCheckedState();
}

class _ShoppingListCheckedState extends State<ShoppingListChecked> {
  List<Map<String, dynamic>> productsChecked = [];

  void loadingShoppingChecked() async {
    final shoppingProvider =
        Provider.of<ShoppingListProvider>(context, listen: false);
    await shoppingProvider.loadShoppingIsChecked();
    setState(() {
      productsChecked = shoppingProvider.items;
    });
  }

  @override
  void initState() {
    super.initState();
    loadingShoppingChecked();
  }

  Future<bool> deleteShoppingChecked() async {
    bool isDeleted = false;
    final shoppingListProvider =
        Provider.of<ShoppingListProvider>(context, listen: false);
    final confirmAction = await showDialogDelete(context,
        "Ao confirmar você excluirá todos os itens. Deseja mesmo excluir?");

    if (confirmAction == true) {
      for (var product in productsChecked) {
        await shoppingListProvider.delete(product["shoppe_list_id"]);
      }
      isDeleted = true;
    }

    return isDeleted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.keyboard_arrow_left,
            size: 35,
          ),
        ),
        title: const Text("Compras checadas"),
        actions: [
          IconButton(
            onPressed: () async {
              bool isDeleted = await deleteShoppingChecked();
              if (isDeleted) {
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(
              Icons.delete_rounded,
              size: 28,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: ListView.separated(
          itemCount: productsChecked.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (_, index) {
            final product = productsChecked[index];
            return ListTile(
              leading: const Icon(
                Icons.shopping_bag_outlined,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                "${product["quantity"]} ${product["unit"]} de ${product["name"]}",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.displayLarge!.fontSize,
                ),
              ),
              trailing: const Icon(
                Icons.check,
                size: 30,
                color: Colors.green,
              ),
            );
          },
        ),
      ),
    );
  }
}
