import 'package:month_shopping_app/config/backup.dart';
import 'package:month_shopping_app/utils/content_message.dart';
import 'package:month_shopping_app/utils/loading.dart';
import 'package:month_shopping_app/utils/permission_use_app.dart';
import 'package:month_shopping_app/utils/share.dart';
import 'package:month_shopping_app/utils/snackbar.dart';
import 'package:flutter/material.dart';

class BackupPage extends StatefulWidget {
  const BackupPage({super.key});

  @override
  State<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  bool isLoadingBackup = false, isLoadingRestore = false;
  final selectedDirectory = TextEditingController();

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color, 7000);
  }

  Future<void> toGenerateBackup() async {
    if (!await isGranted()) return;

    isLoadingBackup = true;

    setState(() {});
    final response = await Backup.toGenerate();
    isLoadingBackup = false;
    setState(() {});

    if (response != null) {
      showMessage(
        const ContentMessage(
          title:
              "Houve um problema ao realizar o backup. Tente novamente. Caso o problema persista, acione o suporte.",
          icon: Icons.error,
        ),
        Colors.orange,
      );

      return;
    }

    showMessage(
      const ContentMessage(
        title: "Backup foi realizado com sucesso.",
        icon: Icons.info,
      ),
      null,
    );

    ShareUtils.share();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Backup"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.backup,
                size: 100,
                color: Theme.of(context).textTheme.bodySmall!.color,
              ),
              Text(
                "Para a segurança do seu sistema, gere o backup para uma futura restauração.",
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodySmall!.color,
                ),
                textAlign: TextAlign.justify,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    await toGenerateBackup();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: isLoadingBackup
                        ? loadingFourRotatingDots(context, 20)
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.backup),
                              SizedBox(width: 10),
                              Text(
                                "Backup",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                  ),
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.symmetric(vertical: 10),
              //   child: ElevatedButton(
              //     onPressed: () => {},
              //     child: Container(
              //       width: double.infinity,
              //       alignment: Alignment.center,
              //       padding: const EdgeInsets.all(10),
              //       child: isLoadingRestore
              //           ? loadingFourRotatingDots(context, 20)
              //           : const Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Icon(Icons.restore),
              //                 SizedBox(width: 10),
              //                 Text(
              //                   "Restauração",
              //                   style: TextStyle(fontSize: 20),
              //                 )
              //               ],
              //             ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
