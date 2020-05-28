import 'package:customermanagementapp/data/data_classes/menus_by_category.dart';
import 'package:customermanagementapp/db/database.dart';

import 'extensions.dart';

extension ConvertFromMBCList on List<MenusByCategory> {
  // [変換：メニューリストとカテゴリリストからMBCリストを生成する]
  List<MenusByCategory> build(List<Menu> menus, List<MenuCategory> categories) {
    List<MenusByCategory> menusByCategories = List();

    if (menus != null && categories != null && categories.isNotEmpty) {
      menusByCategories = categories.map<MenusByCategory>(
        (category) {
          var list = this.where((mbc) {
            return mbc.menuCategory == category;
          }).toList();
          return MenusByCategory(
            menuCategory: category,
            menus: menus.where((menu) {
              return menu.menuCategoryJson.toMenuCategory().id == category.id;
            }).toList(),
            isExpanded: list.isEmpty ? false : list.single.isExpanded,
          );
        },
      ).toList();
    }

    return menusByCategories;
  }
}
