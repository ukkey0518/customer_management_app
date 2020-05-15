import 'package:customermanagementapp/data/data_classes/menus_by_category.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/menus_by_category_repository.dart';
import 'package:flutter/cupertino.dart';

class MenuSettingViewModel extends ChangeNotifier {
  MenuSettingViewModel({mbcRep}) : _mbcRep = mbcRep;

  final MenusByCategoryRepository _mbcRep;

  List<MenusByCategory> _mbcList;
  List<MenusByCategory> get mbcList => _mbcList;

  getMBCList() async {
    print('[VM: メニュー設定画面] getMBCList');
    _mbcList = await _mbcRep.getMenusByCategories();
  }

  setExpanded(int index, bool isExpanded) async {
    print('[VM: メニュー設定画面] setExpanded');
    _mbcList = await _mbcRep.setExpanded(index, isExpanded);
  }

  addMenu(Menu menu) async {
    print('[VM: メニュー設定画面] addMenu');
    _mbcList = await _mbcRep.addMenu(menu);
  }

  deleteMenu(Menu menu) async {
    print('[VM: メニュー設定画面] deleteMenu');
    _mbcList = await _mbcRep.deleteMenu(menu);
  }

  onRepositoryUpdated(MenusByCategoryRepository mbcRep) {
    print('  [VM: メニュー設定画面] onRepositoryUpdated');
    _mbcList = _mbcRep.menusByCategories;

    notifyListeners();
  }
}
