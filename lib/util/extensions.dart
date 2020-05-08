import 'dart:convert';

import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/date_format_mode.dart';
import 'package:customermanagementapp/data/visit_history_sort_state.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_narrow_state.dart';
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
      return menuList.toSumPrice();
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

  // [反映：絞り込みステータスを反映させる]
  void applyNarrowData(VisitHistoryNarrowData narrowData) {
    if (this.isEmpty) return;

    final sinceDate = narrowData.sinceDate;
    final untilDate = narrowData.untilDate;
    final customer = narrowData.customer;
    final employee = narrowData.employee;
    final menuCategory = narrowData.menuCategory;

    List<VisitHistory> visitHistories = List.from(this);

    if (sinceDate != null) {
      print('since : $sinceDate');
      visitHistories = visitHistories.where((vh) {
        return vh.date.isAfter(sinceDate);
      }).toList();
    }

    if (untilDate != null) {
      print('until : $untilDate');
      visitHistories = visitHistories.where((vh) {
        return vh.date.isBefore(untilDate);
      }).toList();
    }

    if (customer != null) {
      print('customer : ${customer.id}');
      visitHistories = visitHistories.where((vh) {
        return vh.customerJson.toCustomer().id == customer.id;
      }).toList();
    }

    if (employee != null) {
      print('employee : ${employee.id}');
      visitHistories = visitHistories.where((vh) {
        return vh.employeeJson.toEmployee().id == employee.id;
      }).toList();
    }

    if (menuCategory != null) {
      print('menuCategory : ${menuCategory.id}');
      visitHistories = visitHistories.where((vh) {
        var list = vh.toMenuCategoriesList();
        var idList = list.map<int>((category) => category.id).toList();
        return idList.contains(menuCategory.id);
      }).toList();
    }

    this
      ..clear()
      ..addAll(visitHistories);
  }

  // [反映：ソートを反映させる]
  void applySortState(VisitHistorySortState sortState) {
    switch (sortState) {
      case VisitHistorySortState.REGISTER_NEW:
        this.sort((a, b) => a.date.isAfter(b.date) ? 1 : -1);
        break;
      case VisitHistorySortState.REGISTER_OLD:
        this.sort((a, b) => a.date.isBefore(b.date) ? 1 : -1);
        break;
    }
  }
}

// List<VisitHistoriesByCustomers>拡張
extension ConvertFromVHBCList on List<VisitHistoriesByCustomer> {
  // 顧客リストと来店履歴リストから生成
  static List<VisitHistoriesByCustomer> vhbcListFrom(
    List<Customer> customers,
    List<VisitHistory> visitHistories,
  ) {
    var customerList = customers ?? List();
    var visitHistoryList = visitHistories ?? List();
    final visitHistoriesByCustomers = List<VisitHistoriesByCustomer>();

    customerList.forEach((customer) {
      final historiesByCustomer = visitHistoryList.where((history) {
        final customerOfVisitHistory = history.customerJson.toCustomer();
        return customerOfVisitHistory.id == customer.id;
      }).toList();
      visitHistoriesByCustomers.add(
        VisitHistoriesByCustomer(
          customer: customer,
          histories: historiesByCustomer,
        ),
      );
    });

    return visitHistoriesByCustomers;
  }

  // [取得：指定顧客の顧客別来店履歴を取得]
  VisitHistoriesByCustomer getVHBC(Customer customer) {
    final vhbc = this.singleWhere(
      (vhbc) {
        return vhbc.customer == customer;
      },
    );
    return vhbc;
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
