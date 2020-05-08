import 'package:customermanagementapp/db/dao/menu_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class MenuRepository extends ChangeNotifier {
  MenuRepository({dao}) : _dao = dao;

  final MenuDao _dao;

  // [フィールド：読み込みステータス]
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // [フィールド：メニューカテゴリリスト]
  List<Menu> _menus = List();
  List<Menu> get menus => _menus;

  // [取得：すべてのメニューデータを取得]
  getMenus() async {
    print('MenuRepository.getMenus :');

    _isLoading = true;
    notifyListeners();

    _menus = await _dao.allMenus;

    _isLoading = false;
    notifyListeners();
  }

  // [追加：１件のメニューデータを追加]
  addMenu(Menu menu) async {
    print('MenuRepository.addMenu :');

    _isLoading = true;
    notifyListeners();

    _menus = await _dao.addAndGetAllMenus(menu);

    _isLoading = false;
    notifyListeners();
  }

  // [追加：複数のメニューデータを追加]
  addAllMenus(List<Menu> menuList) async {
    print('MenuRepository.addAllMenus :');

    _isLoading = true;
    notifyListeners();

    _menus = await _dao.addAllAndGetAllMenus(menuList);

    _isLoading = false;
    notifyListeners();
  }

  // [削除：１件のメニューデータを削除]
  deleteMenu(Menu menu) async {
    print('MenuRepository.deleteMenu :');

    _isLoading = true;
    notifyListeners();

    _menus = await _dao.deleteAndGetAllMenus(menu);

    _isLoading = false;
    notifyListeners();
  }
}
