import 'package:customermanagementapp/data/data_classes/menus_by_category.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/menu_category_repository.dart';
import 'package:customermanagementapp/repositories/menu_repository.dart';
import 'package:flutter/cupertino.dart';

class MenusByCategoryRepository extends ChangeNotifier {
  MenusByCategoryRepository({mRep, mcRep})
      : _mRep = mRep,
        _mcRep = mcRep;

  final MenuRepository _mRep;
  final MenuCategoryRepository _mcRep;

  List<Menu> _menus;
  List<MenuCategory> _categories;

  List<MenusByCategory> _menusByCategories;

  List<MenusByCategory> get menusByCategories => _menusByCategories;

  getMenusByCategories() async {
    print('MenusByCategoryRepository.getMenusByCategories :');
    _menus = await _mRep.getMenus();
    _menusByCategories = await _mcRep.getMenuCategories();

    //TODO _menusByCategories初期化処理
  }

  onRepositoriesUpdated(MenuRepository mRep, MenuCategoryRepository mcRep) {
    print('MenusByCategoryRepository.onRepositoriesUpdated :');
    _menus = mRep.menus;
    _categories = mcRep.menuCategories;

    //TODO _menusByCategories初期化処理

    notifyListeners();
  }
}
