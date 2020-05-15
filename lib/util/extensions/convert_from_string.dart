import 'dart:convert';

import 'package:customermanagementapp/db/database.dart';

extension ConvertFromString on String {
  // [変換：表示用日付文字列 -> DateTime]
  DateTime toDateTime() {
    var date = this.substring(0, this.length - 3);
    var list = date.split('/');
    if (list[1].length == 1) list[1] = '0${list[1]}';
    if (list[2].length == 1) list[2] = '0${list[2]}';
    var parseStr = list.join();
    return DateTime.parse(parseStr);
  }
}

extension ConvertFromJson on String {
  // [変換：JSON文字列 -> Customer]
  Customer toCustomer() {
    var jsonMap = JsonCodec().decode(this);
    return Customer.fromJson(jsonMap);
  }

  // [変換：JSON文字列 -> Employee]
  Employee toEmployee() {
    var jsonMap = JsonCodec().decode(this);
    return Employee.fromJson(jsonMap);
  }

  // [変換：JSON文字列 -> VisitReason]
  VisitReason toVisitReason() {
    var jsonMap = JsonCodec().decode(this);
    return VisitReason.fromJson(jsonMap);
  }

  // [変換：JSON文字列 -> MenuCategory]
  MenuCategory toMenuCategory() {
    var jsonMap = JsonCodec().decode(this);
    return MenuCategory.fromJson(jsonMap);
  }

  // [変換：JSON文字列 -> List<Menu>]
  List<Menu> toMenuList() {
    var menuJsonList = this.split('%');
    var menuList = menuJsonList.map<Menu>((jsonStr) {
      var jsonMap = JsonCodec().decode(jsonStr);
      return Menu.fromJson(jsonMap);
    }).toList();
    return menuList;
  }
}
