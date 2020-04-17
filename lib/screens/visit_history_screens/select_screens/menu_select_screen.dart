import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/screens/setting_screens/menu_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';

class MenuSelectScreen extends StatefulWidget {
  @override
  _MenuSelectScreenState createState() => _MenuSelectScreenState();
}

class _MenuSelectScreenState extends State<MenuSelectScreen> {
  List<MenusByCategory> _menusByCategories = List();
  List<Menu> _selectedMenus = List();

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
              .where((menu) => menu.menuCategoryId == category.id)
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
  _itemSelect() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メニューの選択'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Card(
              color: Colors.grey,
              child: SingleChildScrollView(
                child: Container(
                  height: 300,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            flex: 7,
            child: SingleChildScrollView(
              child: Container(
                child: _buildPanel(),
              ),
            ),
          ),
        ],
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
                onTap: () => _itemSelect(),
              ),
            ],
          );
        },
      ),
    );

    return menuTilesList;
  }
}
