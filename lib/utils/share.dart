import 'package:month_shopping_app/utils/path.dart';
import 'package:share/share.dart';

class ShareUtils {
  static void share() {
    Share.shareFiles(
      ["/$pathStorage/month_shopping_app.db"],
      text: "Backup concluído!",
    );
  }
}
