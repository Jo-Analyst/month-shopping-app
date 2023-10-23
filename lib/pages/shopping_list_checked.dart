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
  List<Map<String, dynamic>> shoppingListChecked = [];

  void loadingShoppingChecked() async {
    final shoppingProvider =
        Provider.of<ShoppingListProvider>(context, listen: false);
    await shoppingProvider.loadShoppingIsChecked();
    setState(() {
      shoppingListChecked = shoppingProvider.itemsChecked;
    });
  }

  @override
  void initState() {
    super.initState();
    loadingShoppingChecked();
  }

  Future<void> deleteShoppingChecked() async {
    final shoppingListProvider =
        Provider.of<ShoppingListProvider>(context, listen: false);
    final confirmAction = await showDialogDelete(context,
        "Ao confirmar você excluirá todos os itens. Deseja mesmo excluir?");

    if (confirmAction == true) {
      for (var shoppe in shoppingListChecked) {
        await shoppingListProvider.delete(shoppe["shoppe_list_id"]);
      }
      closeScreen();
    }
  }

  void closeScreen() {
    Navigator.of(context).pop();
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
        title: const Text("Minhas compras"),
        actions: [
          IconButton(
            onPressed: () async {
              await deleteShoppingChecked();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Compras checadas",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.displayLarge!.fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(
              height: 10,
              // thickness: 2,
              color: Colors.black,
            ),
            Consumer<ShoppingListProvider>(
              builder: (context, shoppingListProvider, _) {
                shoppingListChecked = shoppingListProvider.itemsChecked;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: shoppingListChecked.length,
                  itemBuilder: (_, index) {
                    final shoppe = shoppingListChecked[index];
                    return Dismissible(
                      key: Key(shoppe["shoppe_list_id"].toString()),
                      background: Container(
                        color: Colors.orange,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 10),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) async {
                        await shoppingListProvider.unverifyList(shoppe);
                        if (shoppingListProvider.itemsChecked.isEmpty) {
                          closeScreen();
                        }
                      },
                      child: Container(
                        color: (index % 2 == 0)
                            ? const Color.fromARGB(25, 73, 133, 206)
                            : Colors.white,
                        padding: const EdgeInsets.all(12),
                        child: ListTile(
                          leading: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 30,
                            color: Colors.black,
                          ),
                          title: Text(
                            "${shoppe["quantity"]} ${shoppe["unit"]} de ${shoppe["name"]}",
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .fontSize,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.check,
                            size: 30,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
