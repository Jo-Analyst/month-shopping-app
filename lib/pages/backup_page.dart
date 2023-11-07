import 'package:month_shopping_app/config/backup.dart';
// import 'package:app_kayke_barbearia/app/utils/content_message.dart';
import 'package:flutter/material.dart';
import 'package:month_shopping_app/utils/content_message.dart';
import 'package:month_shopping_app/utils/loading.dart';
import 'package:month_shopping_app/utils/permission_use_app.dart';
import 'package:month_shopping_app/utils/snackbar.dart';
import 'package:permission_handler/permission_handler.dart';

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

  Future<void> performAction(Function() action, String? actionName) async {
    if (!await isGrantedRequestPermissionStorage()) {
      openAppSettings();
      return;
    }
    if (actionName == null) {
      isLoadingBackup = true;
    } else {
      isLoadingRestore = true;
    }
    setState(() {});
    final response = await action();
    if (actionName == null) {
      isLoadingBackup = false;
    } else {
      isLoadingRestore = false;
    }
    setState(() {});

    if (response != null) {
      showMessage(
        ContentMessage(
          title: actionName == null
              ? "Houve um problema ao realizar o backup. Tente novamente. Caso o problema persista, acione o suporte."
              : "Houve um problema ao realizar a restauração. Verifique se há arquivo de backup no caminho predefinido pelo app e tente novamente. Caso o problema persista, acione o suporte.",
          icon: Icons.error,
        ),
        Colors.orange,
      );

      return;
    }

    showMessage(
      ContentMessage(
        title: actionName != null
            ? "A restauração foi realizada com sucesso."
            : "O backup foi realizado com sucesso. O arquivo de backup encontra no armazenamento interno do seu dispostivo. Url: /App Kayke Barbearia/appkaykebarbearia.db",
        icon: Icons.info,
      ),
      null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Backup e restauração"),
          leading: IconButton(
            icon: const Icon(Icons.keyboard_arrow_left, size: 35),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    await performAction(Backup.toGenerate, null);
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
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    await performAction(Backup.restore, "restauração");
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: isLoadingRestore
                        ? loadingFourRotatingDots(context, 20)
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.restore),
                              SizedBox(width: 10),
                              Text(
                                "Restauração",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
