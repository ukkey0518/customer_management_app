import 'package:customermanagementapp/data/data_classes/visit_history_narrow_data.dart';
import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:customermanagementapp/data/list_search_state/visit_history_sort_state.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';

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

  // [取得：直近の来店履歴を取得]˙
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
    var sumPriceList = List<int>();

    if (this.isNotEmpty) {
      sumPriceList = this.map<int>((visitHistory) {
        final menuList = visitHistory.menuListJson.toMenuList();
        return menuList.toSumPrice();
      }).toList();
    }

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
    if (this.isEmpty || ConvertFromVisitHistoryList(this).getRepeatCycle() == 0)
      return null;
    final lastVisit =
        ConvertFromVisitHistoryList(this).getLastVisitHistory().date;
    final repeatCycle =
        Duration(days: ConvertFromVisitHistoryList(this).getRepeatCycle());

    return lastVisit.add(repeatCycle);
  }

  // [取得：前回来店から何ヶ月以内に来店したかを取得]
  // 5 -> 5ヶ月以内に再来店
  // null -> 初回来店
  int getSinceLastVisit(VisitHistory visitHistory) {
    if (this.isEmpty || visitHistory == null) return null;
    final customer = visitHistory.customerJson.toCustomer();

    final vhListByCustomer = List<VisitHistory>.from(this).where((vh) {
      return vh.customerJson.toCustomer().id == customer.id;
    }).toList();

    vhListByCustomer.sort((a, b) => a.date.isBefore(b.date) ? 1 : -1);

    final vhIndex = vhListByCustomer.indexOf(visitHistory);

    if (vhListByCustomer.length <= vhIndex + 1) return null;

    final lastVH = vhListByCustomer[vhIndex + 1];

    final diffYears = visitHistory.date.year - lastVH.date.year;
    final diffMonths = visitHistory.date.month - lastVH.date.month;
    final diffDays = visitHistory.date.day - lastVH.date.day;
    var monthOfPeriod = (diffYears * 12) + diffMonths;

    if (diffDays >= 1) {
      monthOfPeriod++;
    }

    return monthOfPeriod;
  }

  // [取得：何回目の来店かを取得する]
  int getNumOfVisit(VisitHistory visitHistory) {
    if (this.isEmpty || visitHistory == null) return null;
    if (this.isEmpty || visitHistory == null) return null;
    final customer = visitHistory.customerJson.toCustomer();

    final vhListByCustomer = List<VisitHistory>.from(this).where((vh) {
      return vh.customerJson.toCustomer().id == customer.id;
    }).toList();

    vhListByCustomer.sort((a, b) => a.date.isAfter(b.date) ? 1 : -1);

    final vhIndex = vhListByCustomer.indexOf(visitHistory);

    return vhIndex + 1;
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

  // [反映：名前で検索する]
  void applySearchCustomerName(String name) {
    if (name == null || name.isEmpty) return;
    this.removeWhere((vh) {
      return !(vh.customerJson.toCustomer().name.contains(name) ||
          vh.customerJson.toCustomer().nameReading.contains(name));
    });
  }

  // [反映：顧客データ、従業員データ、メニューデータの更新を反映する]
  List<VisitHistory> getUpdate(
      List<Customer> customers, List<Employee> employees, List<Menu> menus) {
    if (this == null) return List();

    final newVHList = List<VisitHistory>();

    this.forEach((vh) {
      final cId = vh.customerJson.toCustomer().id;
      final eId = vh.employeeJson.toEmployee().id;
      final menuIds =
          vh.menuListJson.toMenuList().map((menu) => menu.id).toList();

      Customer c = customers.getCustomer(cId);
      Employee e = employees.getEmployee(eId);
      List<Menu> m = menus.getMenus(menuIds);

      newVHList.add(
        VisitHistory(
          id: vh.id,
          date: vh.date,
          customerJson: c.toJsonString(),
          employeeJson: e.toJsonString(),
          menuListJson: m.toJsonString(),
        ),
      );
    });

    return newVHList;
  }

  // [取得：「年」が一致する来店履歴を取得する]
  List<VisitHistory> getByYear(int year) {
    if (this.isEmpty || year == null) return this;

    final List<VisitHistory> vhList = List.from(this);

    return vhList.where((vh) => vh.date.year == year).toList();
  }

  // [取得：「月」が一致する来店履歴を取得する]
  List<VisitHistory> getByMonth(int month) {
    if (this.isEmpty || month == null) return this;

    final List<VisitHistory> vhList = List.from(this);

    return vhList.where((vh) => vh.date.month == month).toList();
  }

  // [取得：「日」が一致する来店履歴を取得する]
  List<VisitHistory> getByDay(int day) {
    if (this.isEmpty || day == null) return this;

    final List<VisitHistory> vhList = List.from(this);

    return vhList.where((vh) => vh.date.day == day).toList();
  }

  // [取得：年月日が一致する来店履歴を取得する]
  List<VisitHistory> getByPeriod(DateTime date, PeriodMode selectMode) {
    if (this.isEmpty || date == null || selectMode == null) return this;
    List<VisitHistory> vhList =
        ConvertFromVisitHistoryList(this).getByYear(date.year);

    if (selectMode == PeriodMode.MONTH) {
      vhList = ConvertFromVisitHistoryList(vhList).getByMonth(date.month);
    }

    if (selectMode == PeriodMode.DAY) {
      vhList = ConvertFromVisitHistoryList(vhList).getByMonth(date.month);
      vhList = ConvertFromVisitHistoryList(vhList).getByDay(date.day);
    }

    return vhList;
  }

  // [取得：すべての新規顧客の来店履歴データを取得する]
  List<VisitHistory> getNewVisitors(List<VisitHistory> vhList) {
    if (this.isEmpty || vhList.isEmpty) return vhList;

    return vhList.where((vh) {
      return ConvertFromVisitHistoryList(this).getNumOfVisit(vh) == 1;
    }).toList();
  }

  // [取得：すべてのワンリピ顧客の来店履歴データを取得する]
  List<VisitHistory> getOneRepVisitors(List<VisitHistory> vhList) {
    if (this.isEmpty || vhList.isEmpty) return vhList;

    return vhList.where((vh) {
      return ConvertFromVisitHistoryList(this).getNumOfVisit(vh) == 2;
    }).toList();
  }

  // [取得：すべての通常リピ顧客の来店履歴データを取得する]
  List<VisitHistory> getOtherRepVisitors(List<VisitHistory> vhList) {
    if (this.isEmpty || vhList.isEmpty) return vhList;

    return vhList.where((vh) {
      return ConvertFromVisitHistoryList(this).getNumOfVisit(vh) >= 3;
    }).toList();
  }

  // [取得：来店者の内訳データ（人数・金額）を取得する]
  Map<String, int> getBDOfVisitorsDataMap(List<VisitHistory> vhList) {
    if (this.isEmpty || vhList.isEmpty) return Map<String, int>();

    final newVisitors =
        ConvertFromVisitHistoryList(this).getNewVisitors(vhList);

    final oneRepVisitors =
        ConvertFromVisitHistoryList(this).getOneRepVisitors(vhList);

    final otherRepVisitors =
        ConvertFromVisitHistoryList(this).getOtherRepVisitors(vhList);

    var priceOfNewVisitors = 0;
    if (newVisitors.isNotEmpty) {
      priceOfNewVisitors = List.of(newVisitors)
          .map<int>((vh) => vh.menuListJson.toMenuList().toSumPrice())
          .reduce((v, e) => v + e);
    }

    var priceOfOneRepVisitors = 0;
    if (oneRepVisitors.isNotEmpty) {
      priceOfOneRepVisitors = List.of(oneRepVisitors)
          .map<int>((vh) => vh.menuListJson.toMenuList().toSumPrice())
          .reduce((v, e) => v + e);
    }

    var priceOfOtherRepVisitors = 0;
    if (otherRepVisitors.isNotEmpty) {
      priceOfOtherRepVisitors = List.of(otherRepVisitors)
          .map<int>((vh) => vh.menuListJson.toMenuList().toSumPrice())
          .reduce((v, e) => v + e);
    }

    final Map<String, int> dataMap = Map();
    dataMap.putIfAbsent('num_new', () => newVisitors.length);
    dataMap.putIfAbsent('num_oneRep', () => oneRepVisitors.length);
    dataMap.putIfAbsent('num_otherRep', () => otherRepVisitors.length);
    dataMap.putIfAbsent('pri_new', () => priceOfNewVisitors);
    dataMap.putIfAbsent('pri_oneRep', () => priceOfOneRepVisitors);
    dataMap.putIfAbsent('pri_otherRep', () => priceOfOtherRepVisitors);

    return dataMap;
  }
}
