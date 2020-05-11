import 'package:customermanagementapp/data/data_classes/menus_by_category.dart';
import 'package:customermanagementapp/db/dao/menu_category_dao.dart';
import 'package:customermanagementapp/db/dao/menu_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/convert_from_string.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/menu_expansion_panel_list.dart';
import 'package:customermanagementapp/view/components/selected_menu_list.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../../../../main.dart';

class MenuSelectScreen extends StatefulWidget {
  MenuSelectScreen({this.selectedMenus});

  final List<Menu> selectedMenus;

  @override
  _MenuSelectScreenState createState() => _MenuSelectScreenState();
}

class _MenuSelectScreenState extends State<MenuSelectScreen> {
  List<MenusByCategory> _menusByCategories = List();
  List<Menu> _selectedMenus = List();
  List<MenuCategory> _categories = List();

  final menuCategoryDao = MenuCategoryDao(database);
  final menuDao = MenuDao(database);

  @override
  void initState() {
    super.initState();
    _reloadMenusByCategoriesList();
    _selectedMenus.addAll(widget.selectedMenus);
  }

  // [更新：カテゴリ別メニュー達のリストを更新]
  _reloadMenusByCategoriesList() async {
    // DBからメニューカテゴリをすべて取得
    _categories = await menuCategoryDao.allMenuCategories;
    // DBからメニューをすべて取得
    var menusList = await menuDao.allMenus;
    // メニューカテゴリ別にメニューをまとめてリスト化
    var newMenusByCategoriesList = _categories.map<MenusByCategory>(
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
    _selectedMenus.sort((a, b) {
      var aCategory = a.menuCategoryJson.toMenuCategory();
      var bCategory = b.menuCategoryJson.toMenuCategory();
      return aCategory.id - bCategory.id;
    });
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
            child: SelectedMenuList(
              selectedMenus: _selectedMenus,
              onItemTap: (menu) => _onItemSelect(menu),
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            flex: 7,
            child: SingleChildScrollView(
              child: Container(
                child: MenuExpansionPanelList(
//                  menuByCategories: viewModel.mbcList,
//                  expansionCallback: (index, isExpanded) =>
//                      _setExpended(context, index, isExpanded),
//                  onItemPanelTap: (category, menu) =>
//                      _showEditMenuDialog(context, category, menu),
//                  onItemPanelLongPress: (menu) => _deleteMenuTile(context, menu),
//                  onAddPanelTap: (category) =>
//                      _showEditMenuDialog(context, category),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
