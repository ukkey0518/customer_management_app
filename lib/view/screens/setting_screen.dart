import 'package:customermanagementapp/data/enums/screen_tag.dart';
import 'package:customermanagementapp/view/components/custom_list_tiles/setting_screen_list_tile.dart';
import 'package:customermanagementapp/view/components/drowers/my_drawer.dart';
import 'package:customermanagementapp/view/screens/setting_screens/employee_setting_screen.dart';
import 'package:flutter/material.dart';

import 'setting_screens/menu_setting_screen.dart';

class MainSettingScreen extends StatelessWidget {
  final Map<String, Widget> settingMenuItems = {
    'メニュー管理': MenuSettingScreen(),
    'スタッフ管理': EmployeeSettingScreen(),
  };

  @override
  Widget build(BuildContext context) {
    final entriesList = settingMenuItems.entries.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('各種設定'),
      ),
      drawer: MyDrawer(currentScreen: ScreenTag.SCREEN_SETTING),
      body: ListView(
        children: List.generate(entriesList.length, (index) {
          final entry = entriesList[index];
          return SettingListTile(
            text: entry.key,
            screen: entry.value,
          );
        }),
      ),
    );
  }
}
