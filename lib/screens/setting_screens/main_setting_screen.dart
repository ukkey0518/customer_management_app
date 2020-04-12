import 'package:customermanagementapp/parts/my_drawer.dart';
import 'package:customermanagementapp/screens/setting_screens/menu_category_setting_screen.dart';
import 'package:flutter/material.dart';

class MainSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('各種設定画面'),
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: <Widget>[
          Divider(height: 1),
          _settingListItemBuilder(
            title: 'メニューカテゴリ管理',
            onTap: () => _startSettingScreen(
              context,
              MenuCategorySettingScreen(),
            ),
          ),
          Divider(height: 1),
          _settingListItemBuilder(title: 'メニュー管理', onTap: null),
          Divider(height: 1),
          _settingListItemBuilder(title: 'スタッフ管理', onTap: null),
        ],
      ),
    );
  }

  // [ウィジェットビルダー：リストアイテムのビルダー]
  Widget _settingListItemBuilder(
      {@required String title, @required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 8),
      leading: Icon(Icons.settings),
      trailing: Icon(Icons.chevron_right),
      title: Text(title),
      onTap: onTap,
    );
  }

  _startSettingScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
