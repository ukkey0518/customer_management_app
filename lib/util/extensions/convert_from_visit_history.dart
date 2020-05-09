import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/convert_from_string.dart';

extension ConvertFromVisitHistory on VisitHistory {
  // [変換：メニューカテゴリのリストとして返す(重複の許容を指定)]
  List<MenuCategory> toMenuCategoriesList([bool allowDuplicate = false]) {
    final menuList = this.menuListJson.toMenuList();
    var categoryList = menuList
        .map<MenuCategory>((menu) => menu.menuCategoryJson.toMenuCategory())
        .toList();
    if (!allowDuplicate) {
      categoryList = categoryList.toSet().toList();
    }
    return categoryList;
  }
}
