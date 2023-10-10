import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_list_app/components/dialog_unit.dart';

class LisPurchasesPage extends StatefulWidget {
  const LisPurchasesPage({super.key});

  @override
  State<LisPurchasesPage> createState() => _LisPurchasesPageState();
}

class _LisPurchasesPageState extends State<LisPurchasesPage> {
  final quantityController = TextEditingController();
  final unitController = TextEditingController();
  List<Map<String, dynamic>> shopping = [
    {"id": 1, "quantity": 1, "unit": "UND", "product_id": 1, "name": "Arroz"},
    {"id": 2, "quantity": 1, "unit": "UND", "product_id": 2, "name": "Feijão"},
    {
      "id": 3,
      "quantity": 1,
      "unit": "UND",
      "product_id": 3,
      "name": "Macarrão"
    },
    {"id": 4, "quantity": 1, "unit": "UND", "product_id": 4, "name": "Óleo"},
    {"id": 5, "quantity": 1, "unit": "UND", "product_id": 5, "name": "Sal"},
    {"id": 6, "quantity": 1, "unit": "UND", "product_id": 6, "name": "Alho"},
    {"id": 7, "quantity": 1, "unit": "UND", "product_id": 7, "name": "Açucar"},
    {"id": 8, "quantity": 1, "unit": "UND", "product_id": 8, "name": "Farinha"},
    {"id": 9, "quantity": 1, "unit": "UND", "product_id": 9, "name": "Fubá"},
    {
      "id": 10,
      "quantity": 1,
      "unit": "UND",
      "product_id": 10,
      "name": "Leite em pó"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listar compras"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check,
              size: 35,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView(
          children: [
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Listar compras",
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.displayLarge!.fontSize,
                      ),
                    ),
                    const Icon(Icons.list),
                  ],
                ),
              ),
            ),
            Divider(
              height: 4,
              color: Theme.of(context).primaryColor,
            ),
            shopping.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 150,
                    child: Center(
                      child: Text(
                        "Não há produtos listados para a compra",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .fontSize),
                      ),
                    ),
                  )
                : Column(
                    children: shopping.map(
                      (shoppe) {
                        return Column(
                          children: [
                            Slidable(
                              endActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) {
                                      setState(() {
                                        shopping.removeWhere(
                                          (shopp) =>
                                              shopp["id"] == shoppe["id"],
                                        );
                                      });
                                    },
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.box,
                                        size: 25,
                                      ),
                                      const SizedBox(width: 5),
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          shoppe["name"],
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final unit = await showDialogUnit(
                                              context, shoppe["unit"]);
                                          if (unit != null) {
                                            setState(() {
                                              shoppe["unit"] = unit;
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 1),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              shoppe["unit"].toString(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Row(
                                        children: [
                                          Text(shoppe["quantity"].toString()),
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: const Icon(
                                                  Icons.keyboard_arrow_up,
                                                  size: 28,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  size: 28,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Theme.of(context).primaryColor,
                              height: 2,
                            )
                          ],
                        );
                      },
                    ).toList(),
                  )
          ],
        ),
      ),
    );
  }
}
