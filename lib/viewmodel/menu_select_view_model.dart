import 'package:customermanagementapp/data/data_classes/menus_by_category.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/global_repository.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';

class MenuSelectViewModel extends ChangeNotifier {
  MenuSelectViewModel({gRep}) : _gRep = gRep;

  final GlobalRepository _gRep;

  List<MenusByCategory> _mbcList = List();

  List<MenusByCategory> get mbcList => _mbcList;

  List<Menu> _selectedMenus = List();

  List<Menu> get selectedMenus => _selectedMenus;

  String _whenSetMessage = '';

  String get whenSetMessage => _whenSetMessage;

  getMBCList(List<Menu> selectedMenus) async {
    print('[VM: メニュー選択画面] getMBCList');
    await _gRep.getData();
    _mbcList = _gRep.menusByCategories;
    if (selectedMenus != null) {
      List<Menu> list = List.from(selectedMenus);
      _selectedMenus = list;
    }
  }

  setMenu(Menu menu) {
    print('[VM: メニュー選択画面] setMenu');
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
    print('[VM: メニュー選択画面] setExpanded');
    _mbcList = await _gRep.setMBCExpanded(index, isExpanded);
  }

  onRepositoryUpdated(GlobalRepository gRep) {
    print('  [VM: メニュー選択画面] onRepositoryUpdated');
    _mbcList = gRep.menusByCategories;

    notifyListeners();
  }

  @override
  void dispose() {
    _gRep.dispose();
    super.dispose();
  }
}
