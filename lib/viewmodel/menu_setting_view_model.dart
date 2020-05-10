import 'package:customermanagementapp/data/data_classes/menus_by_category.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/menus_by_category_repository.dart';
import 'package:flutter/cupertino.dart';

class MenuSettingViewModel extends ChangeNotifier {
  MenuSettingViewModel({mbcRep}) : _mbcRep = mbcRep;

  final MenusByCategoryRepository _mbcRep;

  List<MenusByCategory> _mbc;
  List<MenusByCategory> get mbc => _mbc;

  getMBC() async {
    _mbc = await _mbcRep.getMenusByCategories();
  }

  setExpanded(int index, bool isExpanded) async {
    _mbc = await _mbcRep.setExpanded(index, isExpanded);
  }

  addMenu(Menu menu) async {
    _mbc = await _mbcRep.addMenu(menu);
  }

  deleteMenu(Menu menu) async {
    _mbc = await _mbcRep.deleteMenu(menu);
  }

  onRepositoryUpdated(MenusByCategoryRepository mbcRep) {
    _mbc = _mbcRep.menusByCategories;

    notifyListeners();
  }
}
