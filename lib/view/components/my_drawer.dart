import 'package:customermanagementapp/view/screens/customers_list_screens/customers_list_screen.dart';
import 'package:customermanagementapp/view/screens/home_screen.dart';
import 'package:customermanagementapp/view/screens/setting_screens/main_setting_screen.dart';
import 'package:customermanagementapp/view/screens/visit_history_screens/visit_history_list_screen.dart';
import 'package:customermanagementapp/util/my_custom_route.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('ヘッダー'),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('ホーム'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MyCustomRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('顧客リスト'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MyCustomRoute(
                  builder: (context) => CustomersListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('来店履歴リスト'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MyCustomRoute(
                  builder: (context) => VisitHistoryListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('各種設定'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MyCustomRoute(
                  builder: (context) => MainSettingScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}