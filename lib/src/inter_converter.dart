import 'dart:async';
import 'dart:convert';

import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:intl/intl.dart';

class InterConverter {
  // [変換：List<Menu>からJSON文字列へ]
  static String menuListToJson(List<Menu> menus) {
    var menuIds = menus.map<String>((menu) {
      var jsonMap = menu.toJson();
      return JsonCodec().encode(jsonMap);
    });
    var menuIdsStr = menuIds.join('%');
    return menuIdsStr;
  }

  // [変換：JSON文字列からList<Menu>へ]
  static Stream<Menu> jsonToMenuList(String json) async* {
    var menus = await database.allMenus;
    var menuJsonStrLists = json.split('%');
    for (int i = 0; i <= menuJsonStrLists.length - 1; i++) {
      var jsonMap = JsonCodec().decode(menuJsonStrLists[i]);
      var menu =
          menus.singleWhere((menu) => menu.id == Menu.fromJson(jsonMap).id);
      yield menu;
    }
  }

  // [変換：JSON文字列 -> Customer]
  static Customer jsonToCustomer(String jsonStr) {
    var jsonMap = JsonCodec().decode(jsonStr);
    return Customer.fromJson(jsonMap);
  }

  // [変換：Customer -> JSON文字列]
  static String customerToJson(Customer customer) {
    var jsonMap = customer.toJson();
    return JsonCodec().encode(jsonMap);
  }

  // [変換：JSON文字列 -> Employee]
  static Employee jsonToEmployee(String jsonStr) {
    var jsonMap = JsonCodec().decode(jsonStr);
    return Employee.fromJson(jsonMap);
  }

  // [変換：Employee -> JSON文字列]
  static String employeeToJson(Employee employee) {
    var jsonMap = employee.toJson();
    return JsonCodec().encode(jsonMap);
  }

  // [変換：JSON文字列 -> MenuCategory]
  static MenuCategory jsonToMenuCategory(String jsonStr) {
    var jsonMap = JsonCodec().decode(jsonStr);
    return MenuCategory.fromJson(jsonMap);
  }

  // [変換：MenuCategory -> JSON文字列]
  static String menuCategoryToJson(MenuCategory menuCategory) {
    var jsonMap = menuCategory.toJson();
    return JsonCodec().encode(jsonMap);
  }

  // [変換：数値を金額文字列へ]
  static String intToPriceString(int price) {
    final formatter = NumberFormat('#,###,###');
    return formatter.format(price);
  }

  // [変換：DateTime -> 表示用日付文字列]
  // 例：2020/4/20(月)
  static String dateObjToStr(DateTime date) {
    var dateStr = DateFormat('yyyy/M/d(E)').format(date);
    return dateStr;
  }

  // [変換：表示用日付文字列 -> DateTime]
  static DateTime dateStrToObj(String dateStr) {
    // 曜日部分を削除
    var date = dateStr.substring(0, dateStr.length - 3);
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
