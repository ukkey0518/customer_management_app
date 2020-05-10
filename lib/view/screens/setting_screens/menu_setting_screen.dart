import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/dialogs/menu_edit_dialog.dart';
import 'package:customermanagementapp/view/components/menu_expansion_panel_list.dart';
import 'package:customermanagementapp/view/screens/setting_screens/menu_category_setting_screen.dart';
import 'package:customermanagementapp/viewmodel/menu_setting_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//class MenuSettingScreen extends StatefulWidget {
//  @override
//  _MenuSettingScreenState createState() => _MenuSettingScreenState();
//}
//
//class _MenuSettingScreenState extends State<MenuSettingScreen> {
//  List<MenusByCategory> _menusByCategories = List();
//
//  final menuCategoryDao = MenuCategoryDao(database);
//  final menuDao = MenuDao(database);
//
//  @override
//  void initState() {
//    super.initState();
//    _reloadMenusByCategoriesList();
//  }
//
//  // [更新：カテゴリ別メニュー達のリストを更新]
//  _reloadMenusByCategoriesList() async {
//    // DBからメニューカテゴリをすべて取得
//    var menuCategoriesList = await menuCategoryDao.allMenuCategories;
//    // DBからメニューをすべて取得
//    var menusList = await menuDao.allMenus;
//    // メニューカテゴリ別にメニューをまとめてリスト化
//    var newMenusByCategoriesList = menuCategoriesList.map<MenusByCategory>(
//      (category) {
//        var list = _menusByCategories
//            .where(
//                (menusByCategory) => menusByCategory.menuCategory == category)
//            .toList();
//        return MenusByCategory(
//          menuCategory: category,
//          menus: menusList
//              .where((menu) =>
//                  menu.menuCategoryJson.toMenuCategory().id == category.id)
//              .toList(),
//          isExpanded: list.isEmpty ? false : list.single.isExpanded,
//        );
//      },
//    ).toList();
//
//    _menusByCategories = newMenusByCategoriesList;
//    // 画面を更新
//    setState(() {});
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('メニュー管理'),
//        centerTitle: true,
//      ),
//      floatingActionButton: FloatingActionButton.extended(
//        onPressed: () => _startMenuCategorySettingScreen(),
//        icon: Icon(Icons.category),
//        label: const Text('カテゴリの編集'),
//      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//      body: SingleChildScrollView(
//        child: Container(
//          child: MenuExpansionPanelList(
//            menuByCategories: _menusByCategories,
//            expansionCallback: (index, isExpanded) {
//              setState(() {
//                _menusByCategories[index].isExpanded = !isExpanded;
//              });
//            },
//            onItemPanelTap: (category, menu) =>
//                _showEditMenuDialog(category, menu),
//            onItemPanelLongPress: (menu) => _deleteMenuTile(menu),
//            onAddPanelTap: (category) => _showEditMenuDialog(category),
//          ),
//        ),
//      ),
//    );
//  }
//
//  // [コールバック：メニューリストパネルタップ時]
//  _showEditMenuDialog(MenuCategory category, [Menu menu]) {
//    showDialog(
//      context: context,
//      builder: (_) {
//        return MenuEditDialog(
//          category: category,
//          menu: menu,
//        );
//      },
//    ).then(
//      (menu) async {
//        if (menu != null) {
//          await menuDao.addMenu(menu);
//        }
//        _reloadMenusByCategoriesList();
//      },
//    );
//  }
//
//  // [コールバック：メニューリストパネル長押し時]
//  _deleteMenuTile(Menu menu) async {
//    await menuDao.deleteMenu(menu);
//    _reloadMenusByCategoriesList();
//  }
//
//  // [コールバック：FABタップ時]
//  // ・カテゴリ編集画面へ遷移する
//  _startMenuCategorySettingScreen() {
//    Navigator.of(context)
//        .push(
//          MaterialPageRoute(
//            builder: (context) => MenuCategorySettingScreen(),
//            fullscreenDialog: true,
//          ),
//        )
//        .then(
//          (_) => _reloadMenusByCategoriesList(),
//        );
//  }
//}

class MenuSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MenuSettingViewModel>(context, listen: false);

    Future(() {
      viewModel.getMBC();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('メニュー管理'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _startMenuCategorySettingScreen(context),
        icon: Icon(Icons.category),
        label: const Text('カテゴリの編集'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Consumer<MenuSettingViewModel>(
        builder: (context, viewModel, child) {
          return SingleChildScrollView(
            child: Container(
              child: MenuExpansionPanelList(
                menuByCategories: viewModel.mbc,
                expansionCallback: (index, isExpanded) =>
                    _setExpended(context, index, isExpanded),
                onItemPanelTap: (category, menu) =>
                    _showEditMenuDialog(context, category, menu),
                onItemPanelLongPress: (menu) => _deleteMenuTile(context, menu),
                onAddPanelTap: (category) =>
                    _showEditMenuDialog(context, category),
              ),
            ),
          );
        },
      ),
    );
  }

  _setExpended(BuildContext context, int index, bool isExpanded) async {
    final viewModel = Provider.of<MenuSettingViewModel>(context, listen: false);

    await viewModel.setExpanded(index, !isExpanded);
  }

  // [コールバック：メニューリストパネルタップ時]
  _showEditMenuDialog(BuildContext context, MenuCategory category,
      [Menu menu]) {
    final viewModel = Provider.of<MenuSettingViewModel>(context, listen: false);

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
          await viewModel.addMenu(menu);
        }
      },
    );
  }

  // [コールバック：メニューリストパネル長押し時]
  _deleteMenuTile(BuildContext context, Menu menu) async {
    final viewModel = Provider.of<MenuSettingViewModel>(context, listen: false);

    await viewModel.deleteMenu(menu);
  }

  // [コールバック：FABタップ時]
  // ・カテゴリ編集画面へ遷移する
  _startMenuCategorySettingScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MenuCategorySettingScreen(),
        fullscreenDialog: true,
      ),
    );
  }
}
