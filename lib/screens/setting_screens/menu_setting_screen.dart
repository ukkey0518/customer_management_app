import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/screens/setting_screens/menu_category_setting_screen.dart';
import 'package:customermanagementapp/src/inter_converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                  InterConverter.jsonToMenuCategory(menu.menuCategoryJson).id ==
                  category.id)
              .toList(),
          isExpanded: list.isEmpty ? false : list.single.isExpanded,
        );
      },
    ).toList();

    _menusByCategories = newMenusByCategoriesList;
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _startMenuCategorySettingScreen(),
        icon: Icon(Icons.category),
        label: const Text('カテゴリの編集'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
          canTapOnHeader: true,
        );
      }).toList(),
    );
  }

  // [ウィジェット：カテゴリタイトル部分]
  Widget _titleCategoryPart(MenuCategory menuCategory) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListTile(
        title: Text(
          menuCategory.name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: Icon(
          Icons.category,
          color: Color(menuCategory.color),
        ),
      ),
    );
  }

  // [ウィジェット：カテゴリ内のメニューリスト]
  List<Widget> _menuTilesList(MenusByCategory menusByCategory) {
    // メニューリスト
    var menus = menusByCategory.menus;

    // カテゴリ別メニュータイルのリスト
    var menuTilesList = List<Widget>();

    // 数値を金額文字列に変換するメソッド
    var intToPriceString = (int price) {
      final formatter = NumberFormat('#,###,###');
      return formatter.format(price);
    };

    // メインコンテンツであるメニューリストを追加
    menuTilesList.addAll(
      List.generate(
        menus.length,
        (index) {
          return Column(
            children: <Widget>[
              Divider(height: 1),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          menus[index].name,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        '\¥${intToPriceString(menus[index].price)}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
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
            onTap: () => _showAddMenuDialog(menusByCategory.menuCategory),
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
          menuCategoryJson: InterConverter.menuCategoryToJson(menuCategory),
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
          menuCategoryJson: InterConverter.menuCategoryToJson(menuCategory),
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
                    onPressed: () =>
                        WidgetsBinding.instance.addPostFrameCallback(
                      (_) => nameController.clear(),
                    ),
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
                    onPressed: () =>
                        WidgetsBinding.instance.addPostFrameCallback(
                      (_) => priceController.clear(),
                    ),
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
