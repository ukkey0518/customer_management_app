import 'dart:async';

import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';

class InterConverter {
  // [変換：List<Menu>からStringへ]
  //  (例)：
  //  onPressed: () async {
  //    var list = await database.allMenus;
  //    var str = await InterConverter.menusToIdStr(list);
  //  },
  static Future<String> menusToIdStr(List<Menu> menus) {
    var menuIds = menus.map<String>((menu) {
      return menu.id.toString();
    });
    var menuIdsStr = menuIds.join(',');
    return Future.value(menuIdsStr);
  }

  // [変換：StringからList<Menu>へ]
  //  (例)：
  //  onPressed: () async {
  //    var idStr = '1,2,3';
  //    var list = await InterConverter.idStrToMenus(idStr).toList();
  //  },
  static Stream<Menu> idStrToMenus(String idStr) async* {
    var menus = await database.allMenus;
    var menuIdStrLists =
        idStr.split(',').map((idStr) => int.parse(idStr)).toList();
    for (int i = 0; i <= menuIdStrLists.length - 1; i++) {
      var menu =
          menus.where((menu) => menu.id == menuIdStrLists[i]).toList().single;
      yield menu;
    }
  }
}
