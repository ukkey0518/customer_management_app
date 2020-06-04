import 'package:customermanagementapp/data/enums/screen_display_mode.dart';
import 'package:customermanagementapp/data/enums/screen_tag.dart';
import 'package:customermanagementapp/view/screens/analysis_screen.dart';
import 'package:customermanagementapp/view/screens/customers_list_screen.dart';
import 'package:customermanagementapp/view/screens/home_screen.dart';
import 'package:customermanagementapp/view/screens/setting_screen.dart';
import 'package:customermanagementapp/view/screens/visit_history_screens/visit_history_list_screen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({
    @required this.currentScreen,
  });

  final ScreenTag currentScreen;

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
            leading: Icon(
              Icons.home,
              color: currentScreen == ScreenTag.SCREEN_HOME
                  ? Theme.of(context).primaryColor
                  : null,
            ),
            title: Text(
              'ホーム',
              style: TextStyle(
                fontSize: currentScreen == ScreenTag.SCREEN_HOME ? 18 : 14,
                color: currentScreen == ScreenTag.SCREEN_HOME
                    ? Theme.of(context).primaryColor
                    : null,
                fontWeight: currentScreen == ScreenTag.SCREEN_HOME
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
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
            leading: Icon(
              Icons.account_circle,
              color: currentScreen == ScreenTag.SCREEN_CUSTOMER_LIST
                  ? Theme.of(context).primaryColor
                  : null,
            ),
            title: Text(
              '顧客リスト',
              style: TextStyle(
                fontSize:
                    currentScreen == ScreenTag.SCREEN_CUSTOMER_LIST ? 18 : 14,
                color: currentScreen == ScreenTag.SCREEN_CUSTOMER_LIST
                    ? Theme.of(context).primaryColor
                    : null,
                fontWeight: currentScreen == ScreenTag.SCREEN_CUSTOMER_LIST
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
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
            leading: Icon(
              Icons.shopping_cart,
              color: currentScreen == ScreenTag.SCREEN_VISIT_HISTORY_LIST
                  ? Theme.of(context).primaryColor
                  : null,
            ),
            title: Text(
              '来店履歴リスト',
              style: TextStyle(
                fontSize: currentScreen == ScreenTag.SCREEN_VISIT_HISTORY_LIST
                    ? 18
                    : 14,
                color: currentScreen == ScreenTag.SCREEN_VISIT_HISTORY_LIST
                    ? Theme.of(context).primaryColor
                    : null,
                fontWeight: currentScreen == ScreenTag.SCREEN_VISIT_HISTORY_LIST
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
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
            leading: Icon(
              Icons.equalizer,
              color: currentScreen == ScreenTag.SCREEN_ANALYSIS
                  ? Theme.of(context).primaryColor
                  : null,
            ),
            title: Text(
              '売上分析',
              style: TextStyle(
                fontSize: currentScreen == ScreenTag.SCREEN_ANALYSIS ? 18 : 14,
                color: currentScreen == ScreenTag.SCREEN_ANALYSIS
                    ? Theme.of(context).primaryColor
                    : null,
                fontWeight: currentScreen == ScreenTag.SCREEN_ANALYSIS
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
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
            leading: Icon(
              Icons.settings,
              color: currentScreen == ScreenTag.SCREEN_SETTING
                  ? Theme.of(context).primaryColor
                  : null,
            ),
            title: Text(
              '各種設定',
              style: TextStyle(
                fontSize: currentScreen == ScreenTag.SCREEN_SETTING ? 18 : 14,
                color: currentScreen == ScreenTag.SCREEN_SETTING
                    ? Theme.of(context).primaryColor
                    : null,
                fontWeight: currentScreen == ScreenTag.SCREEN_SETTING
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
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
