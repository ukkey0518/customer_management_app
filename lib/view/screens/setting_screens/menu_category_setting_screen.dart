import 'package:customermanagementapp/db/dao/menu_category_dao.dart';
import 'package:customermanagementapp/db/dao/menu_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions.dart';
import 'package:customermanagementapp/view/components/dialogs/menu_category_edit_dialog.dart';
import 'package:customermanagementapp/view/components/list_items/menu_category_list_item.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../../../main.dart';

class MenuCategorySettingScreen extends StatefulWidget {
  @override
  _MenuCategorySettingScreenState createState() =>
      _MenuCategorySettingScreenState();
}

class _MenuCategorySettingScreenState extends State<MenuCategorySettingScreen> {
  List<MenuCategory> _menuCategoriesList;
  List<Menu> _menus;

  final menuCategoryDao = MenuCategoryDao(database);
  final menuDao = MenuDao(database);

  @override
  void initState() {
    super.initState();
    _menuCategoriesList = List();
    _reloadMenuCategories();
  }

  // [更新：DBからメニューカテゴリを取得してリストに反映する処理]
  _reloadMenuCategories() async {
    _menuCategoriesList = await menuCategoryDao.allMenuCategories;
    _menuCategoriesList.forEach(
      (category) => print('${category.id} : ${category.name}'),
    );
    print('');
    _menus = await menuDao.allMenus;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メニューカテゴリ管理'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showEditDialog(),
      ),
      body: ListView.builder(
        itemCount: _menuCategoriesList.length,
        itemBuilder: (context, index) {
          return MenuCategoryListItem(
            menuCategory: _menuCategoriesList[index],
            onTap: (category) => _showEditDialog(category),
            onLongPress: (category) => _deleteMenuCategory(index),
          );
        },
      ),
    );
  }

  // [コールバック：リストアイテムをタップ時]
  _showEditDialog([MenuCategory menuCategory]) {
    showDialog(
      context: context,
      builder: (context) => MenuCategoryEditDialog(category: menuCategory),
    ).then(
      (category) async {
        if (category != null) {
          await menuCategoryDao.addMenuCategory(category);
          _reloadMenuCategories();
        }
      },
    );
  }

  // [コールバック：リストアイテム長押し時]
  _deleteMenuCategory(int index) async {
    var deleteMenuCategory = _menuCategoriesList[index];
    print('delete: ${deleteMenuCategory.id} : ${deleteMenuCategory.name}');
    // カテゴリ内にメニューがある場合は削除できない
    if (_menus.any((menu) =>
        menu.menuCategoryJson.toMenuCategory().id == deleteMenuCategory.id)) {
      Toast.show('カテゴリ内にメニューが存在するため削除できません。', context);
    } else {
      await menuCategoryDao.deleteMenuCategory(deleteMenuCategory);
      Toast.show('削除しました', context);
    }
    _reloadMenuCategories();
  }
}
