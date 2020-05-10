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
    _mbcList = await _mbcRep.getMenusByCategories();
  }

  addMenuCategory(MenuCategory menuCategory) async {
    _mbcList = await _mbcRep.addMenuCategory(menuCategory);
  }

  deleteMenuCategory(MenuCategory menuCategory) async {
    _mbcList = await _mbcRep.deleteMenuCategory(menuCategory);
  }

  onRepositoryUpdated(MenusByCategoryRepository mbcRep) {
    _mbcList = _mbcRep.menusByCategories;

    notifyListeners();
  }
}
