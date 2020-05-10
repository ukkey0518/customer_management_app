import 'package:customermanagementapp/data/data_classes/menus_by_category.dart';
import 'extensions.dart';
import 'package:customermanagementapp/db/database.dart';

extension ConvertFromMBCList on List<MenusByCategory> {
  rebuild(List<Menu> menus, List<MenuCategory> categories) {
    if (menus == null || categories == null || categories.isEmpty) {
      return List<MenusByCategory>();
    }

    List<MenusByCategory> menusByCategories = categories.map<MenusByCategory>(
      (category) {
        var list = this
            .where(
                (menusByCategory) => menusByCategory.menuCategory == category)
            .toList();
        return MenusByCategory(
          menuCategory: category,
          menus: menus.where((menu) {
            return menu.menuCategoryJson.toMenuCategory().id == category.id;
          }).toList(),
          isExpanded: list.isEmpty ? false : list.single.isExpanded,
        );
      },
    ).toList();
    return menusByCategories;
  }
}
