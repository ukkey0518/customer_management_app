import 'package:customermanagementapp/data/data_classes/menus_by_category.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/menus_by_category_repository.dart';
import 'package:flutter/cupertino.dart';

class MenuCategorySettingViewModel extends ChangeNotifier {
  MenuCategorySettingViewModel({mbcRep}) : _mbcRep = mbcRep;

  final MenusByCategoryRepository _mbcRep;

  List<MenusByCategory> _mbcList;

  List<MenusByCategory> get mbcList => _mbcList;

  getMBCList() async {
    print('[VM: メニューカテゴリ設定画面] getMBCList');
    _mbcList = await _mbcRep.getMenusByCategories();
  }

  addMenuCategory(MenuCategory menuCategory) async {
    print('[VM: メニューカテゴリ設定画面] addMenuCategory');
    _mbcList = await _mbcRep.addMenuCategory(menuCategory);
  }

  deleteMenuCategory(MenuCategory menuCategory) async {
    print('[VM: メニューカテゴリ設定画面] deleteMenuCategory');
    _mbcList = await _mbcRep.deleteMenuCategory(menuCategory);
  }

  onRepositoryUpdated(MenusByCategoryRepository mbcRep) {
    print('  [VM: メニューカテゴリ設定画面] onRepositoryUpdated');
    _mbcList = _mbcRep.menusByCategories;

    notifyListeners();
  }

  @override
  void dispose() {
    _mbcRep.dispose();
    super.dispose();
  }
}
