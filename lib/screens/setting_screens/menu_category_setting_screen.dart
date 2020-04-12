import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';
import 'package:moor_ffi/database.dart';
import 'package:toast/toast.dart';

import '../../main.dart';

class MenuCategorySettingScreen extends StatefulWidget {
  @override
  _MenuCategorySettingScreenState createState() =>
      _MenuCategorySettingScreenState();
}

class _MenuCategorySettingScreenState extends State<MenuCategorySettingScreen> {
  List<MenuCategory> _menuCategoriesList;

  @override
  void initState() {
    super.initState();
    _reloadMenuCategories();
  }

  // [更新：DBからメニューカテゴリを取得してリストに反映する処理]
  _reloadMenuCategories() async {
    _menuCategoriesList = await database.allMenuCategories;
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
        onPressed: () => showDialog(
                context: context, builder: (_) => _menuCategoryAddDialog())
            .then((_) => _reloadMenuCategories()),
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
                      title: Text('${_menuCategoriesList[index].name}'),
                      leading: Icon(Icons.category),
                      onTap: null,
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

  // [ウィジェット：カテゴリ追加ダイアログ]
  Widget _menuCategoryAddDialog() {
    var newCategoryController = TextEditingController();
    return AlertDialog(
      title: Text('新規カテゴリ追加'),
      content: Container(
        child: TextField(
          controller: newCategoryController,
          decoration: InputDecoration(hintText: '追加するカテゴリ名を入力'),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('キャンセル'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('追加'),
          onPressed: () async {
            if (newCategoryController.text.isEmpty) {
              Toast.show('カテゴリ名が未入力です', context);
              return;
            }
            var menuCategory = MenuCategory(
              name: newCategoryController.text,
            );
            try {
              await database.addMenuCategory(menuCategory);
            } on SqliteException catch (e) {
              Toast.show('カテゴリ名が重複しています。', context);
              print('メニューカテゴリ名の重複：$e');
              return;
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  // [コールバック：リストアイテム長押し時]
  _deleteMenuCategory(int index) async {
    var deleteMenuCategory = _menuCategoriesList[index];
    await database.deleteMenuCategory(deleteMenuCategory);
    _reloadMenuCategories();
    Toast.show('削除しました', context);
  }
}
