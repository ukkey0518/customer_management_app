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
        return _menuEditDialog(menuCategory);
      },
    ).then((_) => _reloadMenusByCategoriesList());
  }

  // [コールバック：メニューリストパネルタップ時]
  _showEditMenuDialog(MenuCategory menuCategory, Menu menu) {
    showDialog(
      context: context,
      builder: (_) {
        return _menuEditDialog(menuCategory, menu);
      },
    ).then((_) => _reloadMenusByCategoriesList());
  }

  // [コールバック：メニューリストパネル長押し時]
  _deleteMenuTile(Menu menu) async {
    await database.deleteMenu(menu);
    _reloadMenusByCategoriesList();
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
              Divider(height: 1),
              ListTile(
                title: Text(menus[index].name),
                subtitle: Text(menus[index].price.toString()),
                onTap: () => _showEditMenuDialog(
                  menusByCategory.menuCategory,
                  menus[index],
                ),
                onLongPress: () => _deleteMenuTile(menus[index]),
              ),
            ],
          );
        },
      ),
    );

    // リスト末尾に付く、メニュー追加用リストタイルを追加
    menuTilesList.add(
      Column(
        children: <Widget>[
          Divider(height: 1),
          ListTile(
            title: const Text('メニューを追加'),
            leading: Icon(Icons.add),
            onTap: () => _showAddMenuDialog(
                menusByCategory.menuCategory), //TODO メニュー追加処理(引数にカテゴリ)
          ),
        ],
      ),
    );

    return menuTilesList;
  }

  // [ウィジェット：メニュー編集ダイアログ]
  Widget _menuEditDialog(MenuCategory menuCategory, [Menu menu]) {
    var titleText;
    var nameController = TextEditingController();
    var priceController = TextEditingController();
    var positiveButtonPressed;

    if (menu == null) {
      titleText = 'メニューの追加';
      nameController.text = '';
      priceController.text = '';
      positiveButtonPressed = () async {
        // 未入力チェック
        if (nameController.text.isEmpty || priceController.text.isEmpty) {
          Toast.show('未入力項目があります', context);
          return;
        }
        // 数値チェック
        try {
          int.parse(priceController.text);
        } on FormatException catch (e) {
          Toast.show('価格は数字のみ入力可能です。', context);
          print(e);
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
      };
    } else {
      titleText = 'メニューの編集';
      nameController.text = menu.name;
      priceController.text = menu.price.toString();
      positiveButtonPressed = () async {
        // 未入力チェック
        if (nameController.text.isEmpty || priceController.text.isEmpty) {
          Toast.show('未入力項目があります', context);
          return;
        }
        // 数値チェック
        try {
          int.parse(priceController.text);
        } on FormatException catch (e) {
          Toast.show('価格は数字のみ入力可能です。', context);
          print(e);
          return;
        }
        var newMenu = Menu(
          id: menu.id,
          menuCategoryId: menuCategory.id,
          name: nameController.text,
          price: int.parse(priceController.text),
        );
        await database.updateMenu(newMenu);
        Navigator.of(context).pop();
      };
    }

    return AlertDialog(
      title: Text(titleText),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('カテゴリ：'),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: TextField(
                controller: TextEditingController(text: menuCategory.name),
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.category,
                    color: Color(menuCategory.color),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text('メニュー名：'),
            Container(
              padding: EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'メニュー名を入力',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => nameController.text = '',
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text('価格：'),
            Container(
              padding: EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '価格を入力',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => priceController.text = '',
                  ),
                ),
              ),
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
          onPressed: positiveButtonPressed,
        ),
      ],
    );
  }
}
