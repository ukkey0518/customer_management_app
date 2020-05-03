import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/view/components/dialogs/menu_edit_dialog.dart';
import 'package:customermanagementapp/view/screens/setting_screens/menu_category_setting_screen.dart';
import 'package:customermanagementapp/util/extensions.dart';
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

  final dao = MyDao(database);

  @override
  void initState() {
    super.initState();
    _reloadMenusByCategoriesList();
  }

  // [更新：カテゴリ別メニュー達のリストを更新]
  _reloadMenusByCategoriesList() async {
    // DBからメニューカテゴリをすべて取得
    var menuCategoriesList = await dao.allMenuCategories;
    // DBからメニューをすべて取得
    var menusList = await dao.allMenus;
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
          await dao.addMenu(menu);
        }
        _reloadMenusByCategoriesList();
      },
    );
  }

  // [コールバック：メニューリストパネル長押し時]
  _deleteMenuTile(Menu menu) async {
    await dao.deleteMenu(menu);
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
                        '${menus[index].price.toPriceString()}',
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
            onTap: () => _showEditMenuDialog(menusByCategory.menuCategory),
          ),
        ],
      ),
    );

    return menuTilesList;
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
