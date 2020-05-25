import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';

extension ConvertFromMenuList on List<Menu> {
  // [変換：List<Menu> -> JSON文字列]
  String toJsonString() {
    var menuIds = this.map<String>((menu) {
      return menu.toJsonString();
    });
    var menuIdsStr = menuIds.join('%');
    return menuIdsStr;
  }

  // [集約：合計金額を取得]
  int toSumPrice() {
    if (this.isEmpty) return 0;
    var prices = this.map<int>((menu) => menu.price);
    return prices.reduce((a, b) => a + b);
  }

  // [集約：平均単価を取得]
  double toAveragePrice() {
    if (this.isEmpty) return 0.0;
    var sum = ConvertFromMenuList(this).toSumPrice();
    var ave = sum / this.length;
    return ave;
  }

  List<Menu> getMenus(List<int> ids) {
    final menus = List<Menu>();
    if (this.isEmpty) return menus;

    ids.forEach((id) {
      final menu = this.where((menu) => menu.id == id).toList();
      if (menu.isNotEmpty) {
        menus.add(menu.single);
      }
    });

    return menus;
  }

  // [変換：メニューカテゴリごとのデータマップを取得]
  Map<MenuCategory, List<Menu>> toMenusData(List<MenuCategory> categories) {
    final dataMap = Map<MenuCategory, List<Menu>>();

    categories.forEach((category) {
      dataMap[category] = this.where((menu) {
        return menu.menuCategoryJson.toMenuCategory() == category;
      }).toList();
    });

    return dataMap;
  }
}
