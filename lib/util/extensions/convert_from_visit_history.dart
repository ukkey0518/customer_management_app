import 'package:customermanagementapp/data/enums/date_format_mode.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';

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

  // [変換：出力用文字列を取得]
  String toPrintText({
    bool showId = false,
    bool showDate = true,
    bool showCustomer = false,
    bool showEmployee = false,
    bool showMenuList = false,
  }) {
    final list = List();

    list.add(showId ? 'id: $id' : '');
    list.add(
        showDate ? 'date: ${date.toFormatStr(DateFormatMode.MEDIUM)}' : '');
    list.add(showCustomer
        ? 'customer: ${customerJson.toCustomer().toPrintText()}'
        : '');
    list.add(showEmployee
        ? 'employee: ${employeeJson.toEmployee().toPrintText()}'
        : '');
    list.add(showMenuList
        ? 'menuList: ${menuListJson.toMenuList().toPrintText()}'
        : '');

    list.removeWhere((value) => value == '');

    return list.join(', ');
  }
}
