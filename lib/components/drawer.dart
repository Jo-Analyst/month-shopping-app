import 'package:flutter/material.dart';
import 'package:month_shopping_app/pages/backup_page.dart';
import 'package:month_shopping_app/pages/categories_list_page.dart';

class DrawerComponet extends StatelessWidget {
  const DrawerComponet({super.key});

  @override
  Widget build(BuildContext context) {
    void openScreen(dynamic page) {
      Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => page,
        ),
      );
    }

    return Drawer(
      elevation: 8,
      backgroundColor: Theme.of(context).textTheme.bodyMedium!.color,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountEmail: null,
            accountName: const Text(
              "Compras do Mês",
              style: TextStyle(fontSize: 20),
            ),
            currentAccountPicture: ClipOval(
              child: Image.asset(
                "assets/images/ic_launcher.png",
              ),
            ),
            currentAccountPictureSize: const Size.square(79),
          ),
          ListTile(
            leading: Icon(
              Icons.category,
              color: Theme.of(context).textTheme.displayLarge!.color,
            ),
            title: Text(
              "Categoria",
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).textTheme.displayLarge!.color,
              ),
            ),
            onTap: () => openScreen(
              const CategoriesListPage(comesFromTheProductsScreen: false),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.backup,
              color: Theme.of(context).textTheme.displayLarge!.color,
            ),
            title: Text(
              "Backup",
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).textTheme.displayLarge!.color,
              ),
            ),
            onTap: () => openScreen(const BackupPage()),
          ),
        ],
      ),
    );
  }
}
