import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';
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
    _getMenuCategories();
  }

  // [更新：DBからメニューカテゴリを取得してリストに反映する処理]
  _getMenuCategories() async {
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
            .then((_) => _getMenuCategories()),
      ),
      body: Column(
        children: <Widget>[
          // カテゴリーリスト部分
          Expanded(
            child: ListView(),
          ),
        ],
      ),
    );
  }

  _menuCategoryAddDialog() {
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
          onPressed: () {
            if (newCategoryController.text.isEmpty) {
              Toast.show('カテゴリ名が未入力です', context);
              return;
            }
            var menuCategory = MenuCategory(
              id: null,
              name: newCategoryController.text,
            );
            database.addMenuCategory(menuCategory);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
