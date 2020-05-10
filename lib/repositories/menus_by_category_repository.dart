import 'package:customermanagementapp/data/data_classes/menus_by_category.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/menu_category_repository.dart';
import 'package:customermanagementapp/repositories/menu_repository.dart';
import 'package:customermanagementapp/util/extensions/convert_from_mbc_list.dart';
import 'package:flutter/cupertino.dart';

class MenusByCategoryRepository extends ChangeNotifier {
  MenusByCategoryRepository({mRep, mcRep})
      : _mRep = mRep,
        _mcRep = mcRep;

  final MenuRepository _mRep;
  final MenuCategoryRepository _mcRep;

  List<Menu> _menus;
  List<MenuCategory> _menuCategories;

  List<MenusByCategory> _menusByCategories;

  List<MenusByCategory> get menusByCategories => _menusByCategories;

  getMenusByCategories() async {
    print('MenusByCategoryRepository.getMenusByCategories :');
    _menus = await _mRep.getMenus();
    _menusByCategories = await _mcRep.getMenuCategories();

    _menusByCategories =
        ConvertFromMBCList.mbcListFrom(_menus, _menuCategories);
  }

  addMenu(Menu menu) {
    _menus = _mRep.addMenu(menu);

    _menusByCategories =
        ConvertFromMBCList.mbcListFrom(_menus, _menuCategories);
  }

  deleteMenu(Menu menu) {
    _menus = _mRep.deleteMenu(menu);

    _menusByCategories =
        ConvertFromMBCList.mbcListFrom(_menus, _menuCategories);
  }

  addMenuCategory(MenuCategory menuCategory) {
    _menuCategories = _mcRep.addMenuCategory(menuCategory);

    _menusByCategories =
        ConvertFromMBCList.mbcListFrom(_menus, _menuCategories);
  }

  deleteMenuCategory(MenuCategory menuCategory) {
    _menuCategories = _mcRep.deleteMenuCategory(menuCategory);

    _menusByCategories =
        ConvertFromMBCList.mbcListFrom(_menus, _menuCategories);
  }

  onRepositoriesUpdated(MenuRepository mRep, MenuCategoryRepository mcRep) {
    print('MenusByCategoryRepository.onRepositoriesUpdated :');
    _menus = mRep.menus;
    _menuCategories = mcRep.menuCategories;

    _menusByCategories =
        ConvertFromMBCList.mbcListFrom(_menus, _menuCategories);

    notifyListeners();
  }
}
