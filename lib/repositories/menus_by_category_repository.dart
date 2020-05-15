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

  List<Menu> _menus = List();
  List<MenuCategory> _menuCategories;

  List<MenusByCategory> _menusByCategories = List();

  List<MenusByCategory> get menusByCategories => _menusByCategories;

  // [取得：すべて]
  getMenusByCategories() async {
    print('[Rep: MenusByCategory] getMenusByCategories');

    _menus = await _mRep.getMenus();
    _menusByCategories = await _mcRep.getMenuCategories();

    _menusByCategories = _menusByCategories.rebuild(_menus, _menuCategories);
  }

  // [追加：１件のメニュー]
  addMenu(
    Menu menu,
  ) async {
    print('[Rep: MenusByCategory] addMenu');

    await _mRep.addMenu(menu);

    _menusByCategories = _menusByCategories.rebuild(_menus, _menuCategories);
  }

  // [追加：１件のメニューカテゴリ]
  addMenuCategory(
    MenuCategory menuCategory,
  ) async {
    print('[Rep: MenusByCategory] addMenuCategory');

    await _mcRep.addMenuCategory(menuCategory);

    _menusByCategories = _menusByCategories.rebuild(_menus, _menuCategories);
  }

  // [削除：１件のメニュー]
  deleteMenu(
    Menu menu,
  ) async {
    print('[Rep: MenusByCategory] deleteMenu');

    await _mRep.deleteMenu(menu);

    _menusByCategories = _menusByCategories.rebuild(_menus, _menuCategories);
  }

  // [削除：１件のメニューカテゴリ]
  deleteMenuCategory(
    MenuCategory menuCategory,
  ) async {
    print('[Rep: MenusByCategory] deleteMenuCategory');

    await _mcRep.deleteMenuCategory(menuCategory);

    _menusByCategories = _menusByCategories.rebuild(_menus, _menuCategories);
  }

  // [Repository更新]
  onRepositoriesUpdated(
    MenuRepository mRep,
    MenuCategoryRepository mcRep,
  ) {
    print('  [Rep: MenusByCategory] onRepositoriesUpdated');

    _menus = mRep.menus;
    _menuCategories = mcRep.menuCategories;

    _menusByCategories = _menusByCategories.rebuild(_menus, _menuCategories);

    notifyListeners();
  }

  // [フィールド更新：展開パネルの展開状態]
  setExpanded(
    int index,
    bool isExpanded,
  ) {
    print('[Rep: MenusByCategory] setExpanded');

    _menusByCategories[index].isExpanded = isExpanded;
    notifyListeners();
  }

  @override
  void dispose() {
    _mRep.dispose();
    _mcRep.dispose();
    super.dispose();
  }
}
