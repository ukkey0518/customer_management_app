import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions.dart';
import 'package:customermanagementapp/view/components/dialogs/menu_category_edit_dialog.dart';
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

  final dao = MyDao(database);

  @override
  void initState() {
    super.initState();
    _menuCategoriesList = List();
    _reloadMenuCategories();
  }

  // [更新：DBからメニューカテゴリを取得してリストに反映する処理]
  _reloadMenuCategories() async {
    _menuCategoriesList = await dao.allMenuCategories;
    _menus = await dao.allMenus;
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
      body: Column(
        children: <Widget>[
          // カテゴリーリスト部分
          Expanded(
            child: ListView.builder(
              itemCount: _menuCategoriesList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Divider(height: 1),
                    ListTile(
                      title: Text(
                        '${_menuCategoriesList[index].name}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(
                        Icons.category,
                        color: Color(_menuCategoriesList[index].color),
                      ),
                      onTap: () => _showEditDialog(_menuCategoriesList[index]),
                      onLongPress: () => _deleteMenuCategory(index),
                    ),
                    Divider(height: 1),
                  ],
                );
              },
            ),
          ),
        ],
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
          await dao.addMenuCategory(category);
          _reloadMenuCategories();
        }
      },
    );
  }

  // [コールバック：リストアイテム長押し時]
  _deleteMenuCategory(int index) async {
    var deleteMenuCategory = _menuCategoriesList[index];
    // カテゴリ内にメニューがある場合は削除できない
    if (_menus.any((menu) =>
        menu.menuCategoryJson.toMenuCategory().id == deleteMenuCategory.id)) {
      Toast.show('カテゴリ内にメニューが存在するため削除できません。', context);
    } else {
      await dao.deleteMenuCategory(deleteMenuCategory);
      Toast.show('削除しました', context);
    }
    _reloadMenuCategories();
  }
}
