import 'package:customermanagementapp/db/dao/menu_category_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class MenuCategoryRepository extends ChangeNotifier {
  MenuCategoryRepository({dao}) : _dao = dao;

  final MenuCategoryDao _dao;

  // [フィールド：読み込みステータス]
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // [フィールド：メニューカテゴリリスト]
  List<MenuCategory> _menuCategories = List();
  List<MenuCategory> get menuCategories => _menuCategories;

  // [取得：すべてのメニューカテゴリデータを取得]
  getMenuCategories() async {
    print('MenuCategoryRepository.getMenuCategories :');

    _isLoading = true;
    notifyListeners();

    _menuCategories = await _dao.allMenuCategories;

    _isLoading = false;
    notifyListeners();
  }

  // [追加：１件のメニューカテゴリデータを追加]
  addMenuCategory(MenuCategory menuCategory) async {
    print('MenuCategoryRepository.addMenuCategory :');

    _isLoading = true;
    notifyListeners();

    _menuCategories = await _dao.addAndGetAllMenuCategories(menuCategory);

    _isLoading = false;
    notifyListeners();
  }

  // [追加：複数のメニューカテゴリデータを追加]
  addAllMenuCategories(List<MenuCategory> menuCategoryList) async {
    print('MenuCategoryRepository.addAllMenuCategories :');

    _isLoading = true;
    notifyListeners();

    _menuCategories =
        await _dao.addAllAndGetAllMenuCategories(menuCategoryList);

    _isLoading = false;
    notifyListeners();
  }

  // [削除：１件のメニューカテゴリデータを削除]
  deleteMenuCategory(MenuCategory menuCategory) async {
    print('MenuCategoryRepository.deleteMenuCategory :');

    _isLoading = true;
    notifyListeners();

    _menuCategories = await _dao.deleteAndGetAllMenuCategory(menuCategory);

    _isLoading = false;
    notifyListeners();
  }
}
