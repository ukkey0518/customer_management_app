import 'package:customermanagementapp/db/database.dart';

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
    var sum = this.toSumPrice();
    var ave = sum / this.length;
    return ave;
  }
}
