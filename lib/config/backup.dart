import 'dart:io';

import 'package:share/share.dart';

class Backup {
  static String pathStorage = '/storage/emulated/0/.month-shopping-app';
  static String pathDB =
      '/data/user/0/com.example.month_shopping_app/databases/month_shopping_app.db';

  static Future<String?> toGenerate() async {
    try {
      File ourDbFile = File(pathDB);

      Directory? folderPathForDbFile = Directory(pathStorage);
      await folderPathForDbFile.create();
      await ourDbFile.copy("$pathStorage/month_shopping_app.db");
      Share.shareFiles(["$pathStorage/month_shopping_app.db"],
          text: "Backup concluído!");
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  static Future<String?> restore() async {
    try {
      File saveDBFile = File("$pathStorage/month_shopping_app.db");

      await saveDBFile.copy(pathDB);
    } catch (e) {
      return e.toString();
    }
    return null;
  }
}
