import 'dart:convert';

import 'package:customermanagementapp/data/date_format_mode.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/cupertino.dart';
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

// List<VisitHistory>拡張
extension ConvertFromVisitHistoryList on List<VisitHistory> {
  // [取得：直近の来店履歴を取得]
  VisitHistory getFirstVisitHistory() {
    if (this.isEmpty) return null;

    this.sort((a, b) {
      var aDate = a.date;
      var bDate = b.date;
      return aDate.isAfter(bDate) ? 1 : -1;
    });
    return this.first;
  }

  // [取得：直近の来店履歴を取得]
  VisitHistory getLastVisitHistory() {
    if (this.isEmpty) return null;
    this.sort((a, b) {
      var aDate = a.date;
      var bDate = b.date;
      return aDate.isBefore(bDate) ? 1 : -1;
    });
    return this.first;
  }

  // [取得：支払い金額リスト]
  List<int> toSumPriceList() {
    if (this.isEmpty) return null;
    final sumPriceList = this.map<int>((visitHistory) {
      final menuList = visitHistory.menuListJson.toMenuList();
      final priceList = menuList.map<int>((menu) => menu.price);
      return priceList.reduce((a, b) => a + b);
    }).toList();
    return sumPriceList;
  }

  // [取得：指定期間以内に再来店した回数を取得]
  int getNumOfRepeatDuringPeriodByMonths({int minMonth = 0, int maxMonth = 0}) {
    if (this.isEmpty) return null;
    var count = 0;
    final dateList =
        this.map<DateTime>((visitHistory) => visitHistory.date).toList();
    dateList.sort((a, b) => a.isAfter(b) ? 1 : -1);
    dateList.reduce((before, after) {
      final minDate = DateTime(
        before.year,
        before.month + minMonth,
        before.day,
        before.hour,
        before.minute,
        before.second,
        before.millisecond,
        before.microsecond,
      );

      var maxDate;
      if (maxMonth == 0) {
        maxDate = DateTime.now();
      } else {
        maxDate = DateTime(
          before.year,
          before.month + maxMonth,
          before.day,
          before.hour,
          before.minute,
          before.second,
          before.millisecond,
          before.microsecond,
        );
      }

      if (after.isAfter(minDate) && after.isBefore(maxDate)) {
        count++;
      }

      return after;
    });
    return count;
  }

  // [取得：リピートサイクル平均(日)]
  int getRepeatCycle() {
    if (this.isEmpty) return null;
    var repeatCycle = 0.0;
    final dateList =
        this.map<DateTime>((visitHistory) => visitHistory.date).toList();
    dateList.sort((a, b) => a.isAfter(b) ? 1 : -1);
    List<Duration> periodList = List();
    dateList.reduce((before, after) {
      var period;
      period = after.difference(before);
      periodList.add(period);
      return after;
    });
    final periodDaysList =
        periodList.map<int>((duration) => duration.inDays).toList();

    if (periodDaysList.isEmpty) return 0;

    final sumDays = periodDaysList.reduce((a, b) => a + b);
    final length = periodList.length;

    repeatCycle = sumDays / length;

    return repeatCycle.floor();
  }

  // [取得：次回来店予想を取得]
  DateTime expectedNextVisit() {
    if (this.isEmpty || this.getRepeatCycle() == 0) return null;
    final lastVisit = this.getLastVisitHistory().date;
    final repeatCycle = Duration(days: this.getRepeatCycle());

    return lastVisit.add(repeatCycle);
  }
}

// List<int>拡張
extension ConvertFromIntList on List<int> {
  // [取得：合計値を取得]
  int getSum() {
    if (this.isEmpty) return null;
    return this.reduce((a, b) => a + b);
  }

  // [取得：平均値を取得]
  double getAverage() {
    if (this.isEmpty) return null;
    final length = this.length;
    final sum = this.getSum();
    return sum / length;
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
  String toFormatString(DateFormatMode mode) {
    var dateStr;
    switch (mode) {
      case DateFormatMode.FULL:
        dateStr = DateFormat('yyyy年 M月 d日').format(this);
        break;
      case DateFormatMode.FULL_WITH_DAY_OF_WEEK:
        dateStr = DateFormat('yyyy年 M月 d日 (E)').format(this);
        break;
      case DateFormatMode.MEDIUM:
        dateStr = DateFormat('yyyy/M/d').format(this);
        break;
      case DateFormatMode.MEDIUM_WITH_DAY_OF_WEEK:
        dateStr = DateFormat('yyyy/M/d(E)').format(this);
        break;
      case DateFormatMode.SHORT:
        dateStr = DateFormat('M月 d日').format(this);
        break;
      case DateFormatMode.SHORT_WITH_DAY_OF_WEEK:
        dateStr = DateFormat('M月 d日 (E)').format(this);
        break;
    }
    return dateStr;
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
    return '\¥$formatStr';
  }
}

// double拡張
extension ConvertFromDouble on double {
  // [変換：数値を金額文字列へ]
  String toPriceString(int asFixed) {
    final num = double.parse(this.toStringAsFixed(asFixed));
    final formatStr = NumberFormat('#,###,###.######').format(num);
    return '\¥$formatStr';
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
