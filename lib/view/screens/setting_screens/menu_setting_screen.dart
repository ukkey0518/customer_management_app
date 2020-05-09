import 'package:customermanagementapp/db/dao/menu_category_dao.dart';
import 'package:customermanagementapp/db/dao/menu_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/view/components/dialogs/menu_edit_dialog.dart';
import 'package:customermanagementapp/view/components/menu_expansion_panel_list.dart';
import 'package:customermanagementapp/view/screens/setting_screens/menu_category_setting_screen.dart';
import 'package:customermanagementapp/util/extensions/convert_from_string.dart';

import 'package:flutter/cupertino.dart';
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

  final menuCategoryDao = MenuCategoryDao(database);
  final menuDao = MenuDao(database);

  @override
  void initState() {
    super.initState();
    _reloadMenusByCategoriesList();
  }

  // [更新：カテゴリ別メニュー達のリストを更新]
  _reloadMenusByCategoriesList() async {
    // DBからメニューカテゴリをすべて取得
    var menuCategoriesList = await menuCategoryDao.allMenuCategories;
    // DBからメニューをすべて取得
    var menusList = await menuDao.allMenus;
    // メニューカテゴリ別にメニューをまとめてリスト化
    var newMenusByCategoriesList = menuCategoriesList.map<MenusByCategory>(
      (category) {
        var list = _menusByCategories
            .where(
                (menusByCategory) => menusByCategory.menuCategory == category)
            .toList();
        return MenusByCategory(
          menuCategory: category,
          menus: menusList
              .where((menu) =>
                  menu.menuCategoryJson.toMenuCategory().id == category.id)
              .toList(),
          isExpanded: list.isEmpty ? false : list.single.isExpanded,
        );
      },
    ).toList();

    _menusByCategories = newMenusByCategoriesList;
    // 画面を更新
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メニュー管理'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _startMenuCategorySettingScreen(),
        icon: Icon(Icons.category),
        label: const Text('カテゴリの編集'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Container(
          child: MenuExpansionPanelList(
            menuByCategories: _menusByCategories,
            expansionCallback: (index, isExpanded) {
              setState(() {
                _menusByCategories[index].isExpanded = !isExpanded;
              });
            },
            onItemPanelTap: (category, menu) =>
                _showEditMenuDialog(category, menu),
            onItemPanelLongPress: (menu) => _deleteMenuTile(menu),
            onAddPanelTap: (category) => _showEditMenuDialog(category),
          ),
        ),
      ),
    );
  }

  // [コールバック：メニューリストパネルタップ時]
  _showEditMenuDialog(MenuCategory category, [Menu menu]) {
    showDialog(
      context: context,
      builder: (_) {
        return MenuEditDialog(
          category: category,
          menu: menu,
        );
      },
    ).then(
      (menu) async {
        if (menu != null) {
          await menuDao.addMenu(menu);
        }
        _reloadMenusByCategoriesList();
      },
    );
  }

  // [コールバック：メニューリストパネル長押し時]
  _deleteMenuTile(Menu menu) async {
    await menuDao.deleteMenu(menu);
    _reloadMenusByCategoriesList();
  }

  // [コールバック：FABタップ時]
  // ・カテゴリ編集画面へ遷移する
  _startMenuCategorySettingScreen() {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => MenuCategorySettingScreen(),
            fullscreenDialog: true,
          ),
        )
        .then(
          (_) => _reloadMenusByCategoriesList(),
        );
  }
}
