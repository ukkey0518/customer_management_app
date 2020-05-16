import 'package:customermanagementapp/data/data_classes/menus_by_category.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/global_repository.dart';
import 'package:flutter/cupertino.dart';

class MenuCategorySettingViewModel extends ChangeNotifier {
  MenuCategorySettingViewModel({gRep}) : _gRep = gRep;

  final GlobalRepository _gRep;

  List<MenusByCategory> _mbcList;

  List<MenusByCategory> get mbcList => _mbcList;

  getMBCList() async {
    print('[VM: メニューカテゴリ設定画面] getMBCList');
    await _gRep.getData();
    _mbcList = _gRep.menusByCategories;
    notifyListeners();
  }

  addMenuCategory(MenuCategory menuCategory) async {
    print('[VM: メニューカテゴリ設定画面] addMenuCategory');
    _mbcList = await _gRep.addSingleData(menuCategory);
  }

  deleteMenuCategory(MenuCategory menuCategory) async {
    print('[VM: メニューカテゴリ設定画面] deleteMenuCategory');
    _mbcList = await _gRep.deleteData(menuCategory);
  }

  onRepositoryUpdated(GlobalRepository gRep) {
    print('  [VM: メニューカテゴリ設定画面] onRepositoryUpdated');
    _mbcList = gRep.menusByCategories;

    notifyListeners();
  }

  @override
  void dispose() {
    _gRep.dispose();
    super.dispose();
  }
}
