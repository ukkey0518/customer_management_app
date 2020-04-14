import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

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
    _reloadMenusByCategoriesList();
  }

  // [更新：カテゴリ別メニュー達のリストを更新]
  _reloadMenusByCategoriesList() async {
    // DBからメニューカテゴリをすべて取得
    var menuCategoriesList = await database.allMenuCategories;
    // DBからメニューをすべて取得
    var menusList = await database.allMenus;
    // メニューカテゴリ別にメニューをまとめてリスト化
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

    // デバッグ用：コンソール出力
    print(
      '''!!-- _initializedLists --!!
         local: Categories => $menuCategoriesList
         local: Menus => $menusList
         field: MenusByCategories => $_menusByCategories
         !!-----------------------!!
      ''',
    );
    // 画面を更新
    setState(() {});
  }

  // [コールバック：メニュー追加パネルタップ時]
  _showAddMenuDialog(MenuCategory menuCategory) {
    showDialog(
      context: context,
      builder: (_) {
        return _addMenuDialog(menuCategory);
      },
    ).then((_) => _reloadMenusByCategoriesList());
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
      // 展開ボタンが押されたときのコールバック
      expansionCallback: (index, isExpanded) {
        setState(() {
          _menusByCategories[index].isExpanded = !isExpanded;
        });
      },
      children: _menusByCategories.map<ExpansionPanel>((menusByCategory) {
        return ExpansionPanel(
          // カテゴリタイトル部分の生成
          headerBuilder: (BuildContext context, bool isExpanded) =>
              _titleCategoryPart(menusByCategory.menuCategory),
          // メニュー部分の生成
          body: SingleChildScrollView(
            child: Column(
              children: _menuTilesList(menusByCategory),
            ),
          ),
          // 展開ステータスの設定
          isExpanded: menusByCategory.isExpanded,
        );
      }).toList(),
    );
  }

  // [ウィジェット：カテゴリタイトル部分]
  Widget _titleCategoryPart(MenuCategory menuCategory) {
    return ListTile(
      title: Text(menuCategory.name),
      leading: Icon(
        Icons.category,
        color: Color(menuCategory.color),
      ),
    );
  }

  // [ウィジェット：カテゴリ内のメニューリスト]
  List<Widget> _menuTilesList(MenusByCategory menusByCategory) {
    // メニューリスト
    var menus = menusByCategory.menus;

    // カテゴリ別メニュータイルのリスト
    var menuTilesList = List<Widget>();

    // メインコンテンツであるメニューリストを追加
    menuTilesList.addAll(
      List.generate(
        menus.length,
        (index) {
          return Column(
            children: <Widget>[
              Divider(),
              ListTile(
                title: Text(menus[index].name),
                subtitle: Text(menus[index].price.toString()),
                onTap: null, //TODO メニューの編集
              ),
              Divider(),
            ],
          );
        },
      ),
    );

    // リスト末尾に付く、メニュー追加用リストタイルを追加
    menuTilesList.add(
      ListTile(
        title: const Text('メニューを追加'),
        leading: Icon(Icons.add),
        onTap: () => _showAddMenuDialog(
            menusByCategory.menuCategory), //TODO メニュー追加処理(引数にカテゴリ)
      ),
    );

    return menuTilesList;
  }

  // [ウィジェット：メニュー追加用ダイアログ]
  Widget _addMenuDialog(MenuCategory menuCategory) {
    var nameController = TextEditingController();
    var priceController = TextEditingController();
    return AlertDialog(
      title: const Text('メニューの追加'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('カテゴリ：'),
            Text(menuCategory.name),
            Text('メニュー名：'),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 30),
            Text('価格：'),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('キャンセル'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: const Text('追加'),
          onPressed: () async {
            // 未入力チェック
            if (nameController.text.isEmpty || priceController.text.isEmpty) {
              Toast.show('未入力項目があります', context);
              return;
            }
            var newMenu = Menu(
              id: null,
              menuCategoryId: menuCategory.id,
              name: nameController.text,
              price: int.parse(priceController.text),
            );
            await database.addMenu(newMenu);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
