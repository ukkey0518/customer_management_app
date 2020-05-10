import 'package:customermanagementapp/db/database.dart';

class MenusByCategory {
  MenusByCategory({this.menuCategory, this.menus, this.isExpanded = false});
  // カテゴリ
  MenuCategory menuCategory;
  // カテゴリの全メニュー
  List<Menu> menus;
  // パネルが開いているかどうか
  bool isExpanded;

  @override
  String toString() {
    return 'menuCategory...${menuCategory.id}, menus...${menus.map((menu) => menu.id)}, isExpanded...$isExpanded';
  }
}
