import 'dart:convert';

import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// String拡張：JSON文字列をオブジェクトに変換
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

// List<Menu>拡張
extension ConvertFromMenuList on List<Menu> {
  // [変換：List<Menu> -> JSON文字列]
  String toJsonString() {
    var menuIds = this.map<String>((menu) {
      return menu.toJsonString();
    });
    var menuIdsStr = menuIds.join('%');
    return menuIdsStr;
  }
}

// ListVisitHistory>拡張
extension ConvertFromVisitHistoryList on List<VisitHistory> {
  // [取得：直近の来店履歴を取得]
  VisitHistory getFirstVisitHistory() {
    if (this.isEmpty) {
      return null;
    }
    this.sort((a, b) {
      var aDate = a.date;
      var bDate = b.date;
      return aDate.isAfter(bDate) ? 1 : -1;
    });
    return this.first;
  }

  // [取得：直近の来店履歴を取得]
  VisitHistory getLastVisitHistory() {
    if (this.isEmpty) {
      return null;
    }
    this.sort((a, b) {
      var aDate = a.date;
      var bDate = b.date;
      return aDate.isBefore(bDate) ? 1 : -1;
    });
    return this.first;
  }
}

// String拡張
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

// DateTime拡張
extension ConvertFromDateTime on DateTime {
  // [変換：DateTime -> 表示用日付文字列]
  // 例：2020/4/20(月)
  String toFormatString() {
    var dateStr = DateFormat('yyyy/M/d(E)').format(this);
    return dateStr;
  }

  // [変換：DateTime -> 生年月日文字列（日本語表記）]
  String toBirthDayString() {
    var birthStr = DateFormat('yyyy年 M月 d日').format(this);
    return birthStr;
  }

  // [変換：誕生日から年齢を取得する]
  int toAge() {
    // 引数がnullの場合はnullを返す
    if (this == null) return null;
    var diffDays = DateTime.now().difference(this).inDays;
    var age = (diffDays / 365).floor();
    return age;
  }
}

// int拡張
extension ConvertFromInteger on int {
  // [変換：数値を金額文字列へ]
  String toPriceString() {
    final formatStr = NumberFormat('#,###,###').format(this);
    return '\¥ $formatStr';
  }
}

// Color拡張
extension ConvertFromColor on Color {
  // [変換：Colorから色番号をintで抽出するメソッド]
  int getColorNumber() {
    var colorStr = this.toString();
    var numStr = colorStr.substring(6, colorStr.length - 1);
    return int.parse(numStr);
  }
}
