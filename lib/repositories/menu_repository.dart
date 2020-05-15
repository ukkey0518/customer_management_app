import 'package:customermanagementapp/db/dao/menu_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class MenuRepository extends ChangeNotifier {
  MenuRepository({dao}) : _dao = dao;

  final MenuDao _dao;

  List<Menu> _menus = List();

  List<Menu> get menus => _menus;

  // [取得：すべて]
  getMenus() async {
    print('[Rep: Menu] getMenus');

    _menus = await _dao.allMenus;
    notifyListeners();
  }

  // [追加：１件]
  addMenu(
    Menu menu,
  ) async {
    print('[Rep: Menu] addMenu');

    _menus = await _dao.addAndGetAllMenus(menu);
    notifyListeners();
  }

  // [追加：複数]
  addAllMenus(
    List<Menu> menuList,
  ) async {
    print('[Rep: Menu] addAllMenus');

    _menus = await _dao.addAllAndGetAllMenus(menuList);
    notifyListeners();
  }

  // [削除：１件]
  deleteMenu(
    Menu menu,
  ) async {
    print('[Rep: Menu] deleteMenu');

    _menus = await _dao.deleteAndGetAllMenus(menu);
    notifyListeners();
  }
}
