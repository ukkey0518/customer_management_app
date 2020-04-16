import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';

class InterConverter {
  // [変換：List<Menu>からintへ]
  static Future<String> menusToIdStr(List<Menu> menus) {
    var menuIds = menus.map<String>((menu) {
      return menu.id.toString();
    });
    var menuIdsStr = menuIds.join(',');
    print('[List<Menu> -> String] convert result : $menuIdsStr}');
    return Future.value(menuIdsStr);
  }

  static Future<List<Menu>> idStrToMenus(String idStr) {
    var menuIds = idStr.split(',');
    var menus = menuIds.map((id) async {
      return await database.getMenusById(id);
    }).toList();
    print('String -> [List<Menu>] convert result : $menus}');
    return Future.value(menus);
  }
}
