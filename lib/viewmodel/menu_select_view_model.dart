import 'package:customermanagementapp/data/data_classes/menus_by_category.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/menus_by_category_repository.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';

class MenuSelectViewModel extends ChangeNotifier {
  MenuSelectViewModel({mbcRep}) : _mbcRep = mbcRep;

  final MenusByCategoryRepository _mbcRep;

  List<MenusByCategory> _mbcList = List();
  List<MenusByCategory> get mbcList => _mbcList;

  List<Menu> _selectedMenus = List();
  List<Menu> get selectedMenus => _selectedMenus;

  String _whenSetMessage = '';
  String get whenSetMessage => _whenSetMessage;

  getMBCList(List<Menu> selectedMenus) async {
    _mbcList = await _mbcRep.getMenusByCategories();
    _selectedMenus = selectedMenus ?? _selectedMenus;
  }

  setMenu(Menu menu) {
    if (_selectedMenus.contains(menu)) {
      _selectedMenus.remove(menu);
      _whenSetMessage = 'リストから削除しました。';
    } else {
      _selectedMenus.add(menu);
      _whenSetMessage = 'リストに追加しました。';
    }
    _selectedMenus.sort((a, b) {
      var aCategory = a.menuCategoryJson.toMenuCategory();
      var bCategory = b.menuCategoryJson.toMenuCategory();
      return aCategory.id - bCategory.id;
    });
    notifyListeners();
  }

  setExpanded(int index, bool isExpanded) async {
    _mbcList = await _mbcRep.setExpanded(index, isExpanded);
  }

  onRepositoryUpdated(MenusByCategoryRepository mbcRep) {
    _mbcList = _mbcRep.menusByCategories;

    notifyListeners();
  }
}
