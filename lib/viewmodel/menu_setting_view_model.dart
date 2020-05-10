import 'package:customermanagementapp/data/data_classes/menus_by_category.dart';
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

  onRepositoryUpdated(MenusByCategoryRepository mbcRep) {
    _mbc = _mbcRep.menusByCategories;

    notifyListeners();
  }
}
