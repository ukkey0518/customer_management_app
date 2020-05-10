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
    return 'menuCategory...$menuCategory, menus...$menus, isExpanded...$isExpanded';
  }
}
