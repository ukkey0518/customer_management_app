import 'package:customermanagementapp/data/data_classes/menus_by_category.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/global_repository.dart';
import 'package:flutter/cupertino.dart';

class MenuSettingViewModel extends ChangeNotifier {
  MenuSettingViewModel({gRep}) : _gRep = gRep;

  final GlobalRepository _gRep;

  List<MenusByCategory> _mbcList;

  List<MenusByCategory> get mbcList => _mbcList;

  getMBCList() async {
    print('[VM: メニュー設定画面] getMBCList');
    await _gRep.getData();
    _mbcList = _gRep.menusByCategories;
  }

  setExpanded(int index, bool isExpanded) async {
    print('[VM: メニュー設定画面] setExpanded');
    _mbcList = await _gRep.setMBCExpanded(index, isExpanded);
  }

  addMenu(Menu menu) async {
    print('[VM: メニュー設定画面] addMenu');
    _mbcList = await _gRep.addSingleData(menu);
  }

  deleteMenu(Menu menu) async {
    print('[VM: メニュー設定画面] deleteMenu');
    _mbcList = await _gRep.deleteData(menu);
  }

  onRepositoryUpdated(GlobalRepository gRep) {
    print('  [VM: メニュー設定画面] onRepositoryUpdated');
    _mbcList = gRep.menusByCategories;

    notifyListeners();
  }
}
