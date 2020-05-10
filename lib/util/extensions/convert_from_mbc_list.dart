import 'package:customermanagementapp/data/data_classes/menus_by_category.dart';
import 'extensions.dart';
import 'package:customermanagementapp/db/database.dart';

extension ConvertFromMBCList on List<MenusByCategory> {
  static mbcListFrom(List<Menu> menus, List<MenuCategory> categories) {
    if (menus == null || categories == null || categories.isEmpty) {
      return List();
    }

    final menusByCategories = categories.map<MenusByCategory>(
      (category) {
        return MenusByCategory(
          menuCategory: category,
          menus: menus.where((menu) {
            return menu.menuCategoryJson.toMenuCategory().id == category.id;
          }).toList(),
          isExpanded: false,
        );
      },
    ).toList();
    return menusByCategories;
  }
}
