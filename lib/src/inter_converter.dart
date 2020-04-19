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
}
