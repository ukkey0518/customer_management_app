import 'dart:convert';

import 'package:customermanagementapp/db/database.dart';

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

extension ConvertFromString on String {
  // [変換：表示用日付文字列 -> DateTime]
  DateTime toDateTime() {
    // 曜日部分を削除
    var date = this.substring(0, this.length - 3);
    // 分割してリストにする
    var list = date.split('/');
    // 月が１桁なら頭に０を追加して２桁に揃える
    if (list[1].length == 1) list[1] = '0${list[1]}';
    // 日が１桁なら頭に０を追加して２桁に揃える
    if (list[2].length == 1) list[2] = '0${list[2]}';
    // 連結
    var parseStr = list.join();
    // DataTime解析後オブジェクト化して返す
    return DateTime.parse(parseStr);
  }
}
