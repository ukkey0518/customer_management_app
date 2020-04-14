import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:flutter/material.dart';

class MenuSettingScreen extends StatefulWidget {
  @override
  _MenuSettingScreenState createState() => _MenuSettingScreenState();
}

// [クラス：カテゴリごとのメニューをまとめたクラス]
class MenusByCategory {
  MenusByCategory({this.menuCategory, this.menus, this.isExpanded = false});
  // カテゴリ
  MenuCategory menuCategory;
  // カテゴリの全メニュー
  List<Menu> menus;
  // パネルが開いているかどうか
  bool isExpanded;

  @override
  String toString() {
    return 'menuCategory...$menuCategory, menus...$menus, isExpanded...$isExpanded';
  }
}

class _MenuSettingScreenState extends State<MenuSettingScreen> {
  List<MenusByCategory> _menusByCategories = List();

  @override
  void initState() {
    super.initState();
    _initializedLists();
  }

  // [更新：リストの更新]
  _initializedLists() async {
    var menuCategoriesList = await database.allMenuCategories;
    var menusList = await database.allMenus;
    _menusByCategories = menuCategoriesList.map<MenusByCategory>(
      (category) {
        return MenusByCategory(
          menuCategory: category,
          menus: menusList
              .where((menu) => menu.menuCategoryId == category.id)
              .toList(),
        );
      },
    ).toList();
    print(
      '''!!-- _initializedLists --!!
         local: Categories => $menuCategoriesList
         local: Menus => $menusList
         field: MenusByCategories => $_menusByCategories
         !!-----------------------!!
      ''',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メニュー管理'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _buildPanel(),
        ),
      ),
    );
  }

  // [ウィジェット：カテゴリ別メニューの展開パネルリスト]
  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: null,
      children: <ExpansionPanel>[],
    );
  }
}
