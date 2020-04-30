import 'package:customermanagementapp/view/components/my_drawer.dart';
import 'package:customermanagementapp/view/components/setting_screen_list_item.dart';
import 'package:customermanagementapp/view/screens/setting_screens/employee_setting_screen.dart';
import 'package:flutter/material.dart';

import 'setting_screens/menu_setting_screen.dart';

class MainSettingScreen extends StatelessWidget {
  final Map<String, Widget> settingMenus = {
    'メニュー管理': MenuSettingScreen(),
    'スタッフ管理': EmployeeSettingScreen(),
  };

  @override
  Widget build(BuildContext context) {
    final menuEntriesList = settingMenus.entries.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('各種設定'),
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: List.generate(menuEntriesList.length, (index) {
          final menu = menuEntriesList[index];
          return SettingListItem(
            title: menu.key,
            screen: menu.value,
          );
        }),
      ),
    );
  }
}
