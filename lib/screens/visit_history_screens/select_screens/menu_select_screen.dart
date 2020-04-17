import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/screens/setting_screens/menu_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import '../../../main.dart';

class MenuSelectScreen extends StatefulWidget {
  @override
  _MenuSelectScreenState createState() => _MenuSelectScreenState();
}

class _MenuSelectScreenState extends State<MenuSelectScreen> {
  List<MenusByCategory> _menusByCategories = List();
  List<Menu> _selectedMenus = List();
  Map<int, int> _categoryColorPairs = {};

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
    // カテゴリカラーMapを初期化
    menuCategoriesList.forEach((menuCategory) =>
        _categoryColorPairs[menuCategory.id] = menuCategory.color);
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
  _onItemSelect(Menu menu) {
    // 選択中のアイテムリストに含まれている場合は選択中リストから削除
    if (_selectedMenus.contains(menu)) {
      _selectedMenus.remove(menu);
      Toast.show('リストから削除しました。', context);
    } else {
      _selectedMenus.add(menu);
      Toast.show('リストに追加しました。', context);
    }
    // カテゴリ順にソート
    _selectedMenus.sort((a, b) => a.menuCategoryId - b.menuCategoryId);
    // 画面を更新
    setState(() {});
  }

  // [コールバック：保存ボタンタップ時]
  _saveMenuListsAndFinish() {
    // 選択中のメニューリストを返す
    Navigator.of(context).pop(_selectedMenus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メニューの選択'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => _saveMenuListsAndFinish(),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: _selectedMenusPart(),
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

  // [ウィジェット：選択中メニュー表示部分]
  Widget _selectedMenusPart() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              _selectedMenuListHeader(),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: _selectedMenus.length,
                  itemBuilder: (context, index) {
                    return _selectedMenuListItem(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // [ウィジェット：選択中リストヘッダー部分]
  Widget _selectedMenuListHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          '選択中：${_selectedMenus.length}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          _selectedMenus.isEmpty
              ? '\¥0'
              : '合計：\¥${_intToPriceString(_selectedMenus.reduce(
                    (a, b) => Menu(
                        id: null,
                        name: null,
                        price: a.price + b.price,
                        menuCategoryId: null),
                  ).price)}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // [ウィジェット：選択中リストアイテム部分]
  Widget _selectedMenuListItem(int index) {
    return InkWell(
      onTap: () => _onItemSelect(_selectedMenus[index]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.import_contacts,
              color: Color(
                  _categoryColorPairs[_selectedMenus[index].menuCategoryId]),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                _selectedMenus[index].name,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              '\¥${_intToPriceString(_selectedMenus[index].price)}',
              style: TextStyle(
                fontSize: 16,
              ),
            )
          ],
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
          // 選択中メニューリストにアイテムが存在する場合は文字色をプライマリカラーに設定
          var style = TextStyle(fontSize: 16);
          if (_selectedMenus.contains(menus[index])) {
            style = style.merge(
              TextStyle(color: Theme.of(context).primaryColor),
            );
          }
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
                          style: style,
                        ),
                      ),
                      Text(
                        '\¥${_intToPriceString(menus[index].price)}',
                        style: style,
                      )
                    ],
                  ),
                ),
                onTap: () => _onItemSelect(menus[index]),
              ),
            ],
          );
        },
      ),
    );

    return menuTilesList;
  }

  // [ツール：数値を金額文字列に変換するメソッド]
  String _intToPriceString(int price) {
    final formatter = NumberFormat('#,###,###');
    return formatter.format(price);
  }
}
