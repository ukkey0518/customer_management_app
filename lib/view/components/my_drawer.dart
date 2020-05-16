import 'package:customermanagementapp/data/enums/screen_display_mode.dart';
import 'package:customermanagementapp/view/screens/analysis_screen.dart';
import 'package:customermanagementapp/view/screens/customers_list_screen.dart';
import 'package:customermanagementapp/view/screens/home_screen.dart';
import 'package:customermanagementapp/view/screens/setting_screen.dart';
import 'package:customermanagementapp/view/screens/visit_history_screens/visit_history_list_screen.dart';
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
                MaterialPageRoute(
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
                MaterialPageRoute(
                  builder: (context) => CustomersListScreen(
                    displayMode: ScreenDisplayMode.EDITABLE,
                  ),
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
                MaterialPageRoute(
                  builder: (context) => VisitHistoryListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.equalizer),
            title: Text('売上分析'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AnalysisScreen(),
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
                MaterialPageRoute(
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
