import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/parts/color_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
    _menuCategoriesList = List();
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
        onPressed: () => _showAddDialog(),
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

  // [コールバック：FABをタップ時]
  _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        var currentColor;
        var newCategoryController = TextEditingController();
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('新規カテゴリ追加'),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: Text('カテゴリ名：', textAlign: TextAlign.left),
                    ),
                    TextField(
                      controller: newCategoryController,
                      decoration: InputDecoration(hintText: 'カテゴリ名を入力'),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text('カテゴリカラー：', textAlign: TextAlign.left),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                          color: currentColor ?? Color(0xffffffff),
                        ),
                        child: FlatButton(
                          child: Text('タップしてカラーを選択'),
                          textColor: useWhiteForeground(
                                  currentColor ?? Color(0xffffffff))
                              ? const Color(0xffffffff)
                              : const Color(0xff000000),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (_) {
                              return ColorPickerDialog(
                                  currentColor ?? Color(0xffffffff));
                            },
                          ).then(
                            (newColor) {
                              print(newColor);
                              setState(() => currentColor = newColor);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
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
                    // 未入力チェック
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
                      // 重複時のエラーメッセージ
                      Toast.show('カテゴリ名が重複しています。', context);
                      print('メニューカテゴリ名の重複：$e');
                      return;
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    ).then(
      (_) => _reloadMenuCategories(),
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
