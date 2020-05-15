import 'package:customermanagementapp/db/dao/menu_category_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class MenuCategoryRepository extends ChangeNotifier {
  MenuCategoryRepository({dao}) : _dao = dao;

  final MenuCategoryDao _dao;

  List<MenuCategory> _menuCategories = List();

  List<MenuCategory> get menuCategories => _menuCategories;

  // [取得：すべて]
  getMenuCategories() async {
    print('[Rep: MenuCategory] getMenuCategories');

    _menuCategories = await _dao.allMenuCategories;
    notifyListeners();
  }

  // [追加：１件]
  addMenuCategory(
    MenuCategory menuCategory,
  ) async {
    print('[Rep: MenuCategory] addMenuCategory');

    _menuCategories = await _dao.addAndGetAllMenuCategories(menuCategory);
    notifyListeners();
  }

  // [追加：複数]
  addAllMenuCategories(
    List<MenuCategory> menuCategoryList,
  ) async {
    print('[Rep: MenuCategory] addAllMenuCategories');

    _menuCategories =
        await _dao.addAllAndGetAllMenuCategories(menuCategoryList);
    notifyListeners();
  }

  // [削除：１件]
  deleteMenuCategory(
    MenuCategory menuCategory,
  ) async {
    print('[Rep: MenuCategory] deleteMenuCategory');

    _menuCategories = await _dao.deleteAndGetAllMenuCategory(menuCategory);
    notifyListeners();
  }
}
