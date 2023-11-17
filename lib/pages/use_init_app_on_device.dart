import 'package:month_shopping_app/config/db.dart';
import 'package:month_shopping_app/config/backup.dart';
import 'package:month_shopping_app/utils/content_message.dart';
import 'package:month_shopping_app/utils/permission_use_app.dart';
import 'package:month_shopping_app/utils/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UseInitAppOnDevice extends StatefulWidget {
  const UseInitAppOnDevice({super.key});

  @override
  State<UseInitAppOnDevice> createState() => _UseInitAppOnDeviceState();
}

class _UseInitAppOnDeviceState extends State<UseInitAppOnDevice> {
  bool isLoadingRestore = false;
  void screen() {
    Navigator.of(context).pop();
  }

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color, 7000);
  }

  void restore() async {
    if (!await isGranted()) return;

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String filePath = result.files.single.path ?? '';
      int filePathLength = filePath.split(".").length;
      String extension = filePath.split(".")[filePathLength - 1];
      if (extension != "db") {
        showMessage(
          const ContentMessage(
            title: "Arquivo de backup inválido!",
            icon: Icons.error,
          ),
          Colors.red,
        );

        return;
      }

      isLoadingRestore = true;
      setState(() {});
      await DB.openDatabase();
      final response = await Backup.restore(filePath);
      isLoadingRestore = false;
      setState(() {});
      if (response != null) {
        showMessage(
          const ContentMessage(
            title:
                "Houve um problema ao realizar a restauração. Caso o problema persista, acione o suporte.",
            icon: Icons.error,
          ),
          Colors.orange,
        );

        return;
      }

      navigateToHome();
    }
  }

  void navigateToHome() async {
    final confirmExit =
        await Navigator.of(context).pushReplacementNamed('/home');

    if (confirmExit == true) {
      screen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => SystemNavigator.pop(),
            icon: const Icon(
              Icons.close,
              size: 35,
            ),
          ),
        ],
        title: const Text(
          "COMPRAS DO MÊS",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/ic_launcher.png",
                  width: 100,
                ),
                const SizedBox(height: 5),
                const Text(
                  "Olá! Seja bem vindo. Este é o aplicativo que irá te auxiliar na sua compra.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => restore(),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.restore),
                          SizedBox(width: 5),
                          Text(
                            "Restaurar",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => navigateToHome(),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Continuar",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.keyboard_arrow_right,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
