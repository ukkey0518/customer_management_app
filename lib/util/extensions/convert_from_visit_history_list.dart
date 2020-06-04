import 'package:customermanagementapp/data/data_classes/visit_history_narrow_data.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_sort_data.dart';
import 'package:customermanagementapp/data/enums/list_sort_order.dart';
import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:customermanagementapp/data/list_search_state/visit_history_sort_state.dart';
import 'package:customermanagementapp/data/visit_reason_data.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:fl_chart/fl_chart.dart';

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
    final customer = visitHistory.customerJson.toCustomer();

    final vhListByCustomer = List<VisitHistory>.from(this).where((vh) {
      return vh.customerJson.toCustomer().id == customer.id;
    }).toList();

    vhListByCustomer.sort((a, b) => a.date.isAfter(b.date) ? 1 : -1);

    final vhIndex = vhListByCustomer.indexOf(visitHistory);

    return vhIndex + 1;
  }

  // [反映：絞り込みステータスを反映させる]
  List<VisitHistory> applyNarrowData(VisitHistoryNarrowData narrowData) {
    if (this.isEmpty) return this;

    final sinceDate = narrowData.sinceDate;
    final untilDate = narrowData.untilDate;
    final employee = narrowData.employee;
    final menuCategory = narrowData.menuCategory;

    List<VisitHistory> dataList = List.from(this);

    if (sinceDate != null) {
      print('since : $sinceDate');
      dataList = dataList.where((vh) {
        return vh.date.isAfter(sinceDate);
      }).toList();
    }

    if (untilDate != null) {
      print('until : $untilDate');
      dataList = dataList.where((vh) {
        return vh.date.isBefore(untilDate);
      }).toList();
    }

    if (employee != null) {
      print('employee : ${employee.id}');
      dataList = dataList.where((vh) {
        return vh.employeeJson.toEmployee().id == employee.id;
      }).toList();
    }

    if (menuCategory != null) {
      print('menuCategory : ${menuCategory.id}');
      dataList = dataList.where((vh) {
        var list = vh.toMenuCategoriesList();
        var idList = list.map<int>((category) => category.id).toList();
        return idList.contains(menuCategory.id);
      }).toList();
    }

    return dataList;
  }

  // [反映：ソートを反映させる]
  List<VisitHistory> applySortData(VisitHistorySortData sortData) {
    List<VisitHistory> dataList = List.from(this);

    switch (sortData.sortState) {
      case VisitHistorySortState.REGISTER_DATE:
        dataList.sort((a, b) => a.date.isBefore(b.date) ? 1 : -1);
        break;

      case VisitHistorySortState.PAYMENT_AMOUNT:
        dataList.sort((a, b) {
          final aPrice = a.menuListJson.toMenuList().toSumPrice();
          final bPrice = b.menuListJson.toMenuList().toSumPrice();
          return aPrice < bPrice ? 1 : -1;
        });
        break;

      case VisitHistorySortState.CUSTOMER_AGE:
        final birthNotNullData = List<VisitHistory>();
        final birthNullData = List<VisitHistory>();
        dataList.forEach((vh) {
          final birth = vh.customerJson.toCustomer().birth;
          birth != null ? birthNotNullData.add(vh) : birthNullData.add(vh);
        });
        birthNotNullData.sort((a, b) {
          final aAge = a.customerJson.toCustomer().birth;
          final bAge = b.customerJson.toCustomer().birth;
          if (aAge.isAtSameMomentAs(bAge)) {
            // 同じ年齢の場合は来店日順にソート
            return a.date.isAfter(b.date) ? 1 : -1;
          }
          return aAge.isAfter(bAge) ? 1 : -1;
        });
        // 年齢未登録の場合は来店日順にソート
        birthNullData.sort((a, b) {
          return a.date.isAfter(b.date) ? 1 : -1;
        });
        dataList.clear();
        dataList.addAll(birthNotNullData);
        dataList.addAll(birthNullData);
        break;

      case VisitHistorySortState.CUSTOMER_NAME:
        dataList.sort((a, b) {
          final aCustomerNameReading = a.customerJson.toCustomer().nameReading;
          final bCustomerNameReading = b.customerJson.toCustomer().nameReading;
          return aCustomerNameReading
              .toLowerCase()
              .compareTo(bCustomerNameReading.toLowerCase());
        });
        break;
    }

    switch (sortData.order) {
      case ListSortOrder.ASCENDING_ORDER:
        break;
      case ListSortOrder.REVERSE_ORDER:
        final reversedList = dataList.reversed.toList();
        dataList.clear();
        dataList.addAll(reversedList);
        break;
    }

    return dataList;
  }

  // [反映：名前で検索する]
  List<VisitHistory> applySearchCustomerName(String name) {
    if (name == null || name.isEmpty) return this;

    List<VisitHistory> dataList = List.from(this);
    dataList.removeWhere((vh) {
      return !(vh.customerJson.toCustomer().name.contains(name) ||
          vh.customerJson.toCustomer().nameReading.contains(name));
    });

    return dataList;
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
      List<Menu> m = menus.getMultipleMenus(menuIds);

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

  // [取得：１ヶ月以内に再来店した来店履歴を取得する]
  List<VisitHistory> getRepeaterWithin1Month(List<VisitHistory> vhList) {
    if (this.isEmpty || vhList.isEmpty) return vhList;

    return vhList.where((vh) {
      final slv = ConvertFromVisitHistoryList(this).getSinceLastVisit(vh);
      return slv == 1;
    }).toList();
  }

  // [取得：３ヶ月以内に再来店した来店履歴を取得する]
  List<VisitHistory> getRepeaterWithin3Month(List<VisitHistory> vhList) {
    if (this.isEmpty || vhList.isEmpty) return vhList;

    return vhList.where((vh) {
      final slv = ConvertFromVisitHistoryList(this).getSinceLastVisit(vh);
      if (slv == null) return false;
      return 1 < slv && slv <= 3;
    }).toList();
  }

  // [取得：４ヶ月以上で再来店した来店履歴を取得する]
  List<VisitHistory> getRepeaterMore4Month(List<VisitHistory> vhList) {
    if (this.isEmpty || vhList.isEmpty) return vhList;

    return vhList.where((vh) {
      final slv = ConvertFromVisitHistoryList(this).getSinceLastVisit(vh);
      if (slv == null) return false;
      return 4 <= slv;
    }).toList();
  }

  // [取得：すべての新規顧客の来店履歴データを取得する]
  List<VisitHistory> getNewVisitors(List<VisitHistory> vhList) {
    if (this.isEmpty || vhList.isEmpty) return vhList;

    return vhList.where((vh) {
      return ConvertFromVisitHistoryList(this).getNumOfVisit(vh) == 1;
    }).toList();
  }

  // [取得：すべてのワンリピ顧客の来店履歴データを取得する]
  Map<String, List<VisitHistory>> getOneRepVisitors(List<VisitHistory> vhList) {
    final Map<String, List<VisitHistory>> dataMap =
        Map<String, List<VisitHistory>>();
    var oneRepeaters = List<VisitHistory>();

    if (this.isNotEmpty || vhList.isNotEmpty) {
      oneRepeaters = vhList.where((vh) {
        return ConvertFromVisitHistoryList(this).getNumOfVisit(vh) == 2;
      }).toList();
    }

    dataMap['1'] =
        ConvertFromVisitHistoryList(this).getRepeaterWithin1Month(oneRepeaters);
    dataMap['3'] =
        ConvertFromVisitHistoryList(this).getRepeaterWithin3Month(oneRepeaters);
    dataMap['more'] =
        ConvertFromVisitHistoryList(this).getRepeaterMore4Month(oneRepeaters);

    return dataMap;
  }

  // [取得：すべての通常リピ顧客の来店履歴データを取得する]
  Map<String, List<VisitHistory>> getOtherRepVisitors(
      List<VisitHistory> vhList) {
    final Map<String, List<VisitHistory>> dataMap =
        Map<String, List<VisitHistory>>();
    var otherRepeaters = List<VisitHistory>();

    if (this.isNotEmpty || vhList.isNotEmpty) {
      otherRepeaters = vhList.where((vh) {
        return ConvertFromVisitHistoryList(this).getNumOfVisit(vh) >= 3;
      }).toList();
    }

    dataMap['1'] = ConvertFromVisitHistoryList(this)
        .getRepeaterWithin1Month(otherRepeaters);
    dataMap['3'] = ConvertFromVisitHistoryList(this)
        .getRepeaterWithin3Month(otherRepeaters);
    dataMap['more'] =
        ConvertFromVisitHistoryList(this).getRepeaterMore4Month(otherRepeaters);

    return dataMap;
  }

  // [取得：すべての男性顧客の来店履歴を取得する]
  Map<String, List<VisitHistory>> getMaleVisitors(List<VisitHistory> vhList) {
    final Map<String, List<VisitHistory>> dataMap =
        Map<String, List<VisitHistory>>();
    var maleVisitors = List<VisitHistory>();

    if (this.isNotEmpty || vhList.isNotEmpty) {
      maleVisitors = vhList.where((vh) {
        return ConvertFromJson(vh.customerJson).toCustomer().isGenderFemale ==
            false;
      }).toList();
    }

    dataMap['new'] =
        ConvertFromVisitHistoryList(this).getNewVisitors(maleVisitors);
    dataMap['one'] = ConvertFromVisitHistoryList(this)
        .getOneRepVisitors(maleVisitors)
        .toAllVisitHistories();
    dataMap['other'] = ConvertFromVisitHistoryList(this)
        .getOtherRepVisitors(maleVisitors)
        .toAllVisitHistories();

    return dataMap;
  }

  // [取得：すべての女性顧客の来店履歴を取得する]
  Map<String, List<VisitHistory>> getFemaleVisitors(List<VisitHistory> vhList) {
    final Map<String, List<VisitHistory>> dataMap =
        Map<String, List<VisitHistory>>();
    var femaleVisitors = List<VisitHistory>();

    if (this.isNotEmpty || vhList.isNotEmpty) {
      femaleVisitors = vhList.where((vh) {
        return ConvertFromJson(vh.customerJson).toCustomer().isGenderFemale ==
            true;
      }).toList();
    }

    dataMap['new'] =
        ConvertFromVisitHistoryList(this).getNewVisitors(femaleVisitors);
    dataMap['one'] = ConvertFromVisitHistoryList(this)
        .getOneRepVisitors(femaleVisitors)
        .toAllVisitHistories();
    dataMap['other'] = ConvertFromVisitHistoryList(this)
        .getOtherRepVisitors(femaleVisitors)
        .toAllVisitHistories();

    return dataMap;
  }

  // [取得：売り上がったすべてのメニューを取得する]
  List<Menu> getAllSoldMenus() {
    final dataList = List<Menu>();

    final vhList = List<VisitHistory>.from(this);

    if (this.isNotEmpty) {
      vhList.forEach((vh) {
        final vhMenus = vh.menuListJson.toMenuList();
        dataList.addAll(vhMenus);
      });
    }
    return dataList;
  }

  // [変換：指定年(または月)のグラフ用スポットデータへ変換]
  List<FlSpot> toNumOfVisitorsFlSpotList(int year, [int month]) {
    List<FlSpot> spotList = List();
    var dataList = List();
    var vhListByLength = List();
    var isMonthSummaryMode = false;
    var maxLength;
    var compareTag;

    final dataDate = DateTime(
      year,
      month ?? DateTime.now().month,
      DateTime.now().day,
    );

    final nowDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    if (dataDate.isBefore(nowDate)) compareTag = 'before';
    if (dataDate.isAfter(nowDate)) compareTag = 'after';
    if (dataDate.isAtSameMomentAs(nowDate)) compareTag = 'same';
    print('dataDate: $dataDate');
    print('nowDate: $nowDate');
    print('compare: $compareTag');

    dataList = ConvertFromVisitHistoryList(this).getByYear(year);
    if (month != null) {
      isMonthSummaryMode = true;
      dataList = ConvertFromVisitHistoryList(dataList).getByMonth(month);
    }

    if (dataList.isEmpty) {
      switch (compareTag) {
        case 'before':
          var length = 31;
          spotList = List<FlSpot>.generate(length, (index) {
            return FlSpot(index.toDouble(), 0.0);
          });
          break;
        case 'after':
          spotList = [FlSpot(0.0, 0.0)];
          break;
        case 'same':
          final length =
              isMonthSummaryMode ? DateTime.now().day : DateTime.now().month;
          spotList = List<FlSpot>.generate(length, (index) {
            return FlSpot(index.toDouble(), 0.0);
          });
          break;
      }

      print('monthMode: $isMonthSummaryMode');
      print(
          'spotList: ${spotList.toPrintText(xMode: isMonthSummaryMode ? 'day' : 'month', yMode: 'nov')}');
      print(
          'vhListByLength: ${List<List<VisitHistory>>.from(vhListByLength).map<String>((list) {
        return ConvertFromVisitHistoryList(list).toPrintText();
      })}');

      return spotList;
    }

    if (dataList.length == 1) {
      maxLength = isMonthSummaryMode
          ? dataList.single.date.day
          : dataList.single.date.month;
    } else {
      maxLength = List<VisitHistory>.from(dataList)
          .map<int>((vh) {
            return isMonthSummaryMode ? vh.date.day : vh.date.month;
          })
          .toList()
          .reduce((v, e) => v >= e ? v : e);
    }

    vhListByLength = List<List<VisitHistory>>.generate(maxLength, (index) {
      return dataList.where((vh) {
        return (isMonthSummaryMode ? vh.date.day : vh.date.month) == index + 1;
      }).toList();
    });

    spotList = List<FlSpot>.generate(maxLength, (index) {
      var magnification = isMonthSummaryMode ? 1.0 : 0.2;
      final spot = vhListByLength[index].length * magnification;
      return FlSpot(index.toDouble(), spot);
    });

    switch (compareTag) {
      case 'before':
        final length = isMonthSummaryMode ? 31 : 12;
        for (int i = maxLength; i <= length - 1; i++) {
          spotList.add(FlSpot(i.toDouble(), 0));
        }
        break;
      case 'same':
        final length =
            isMonthSummaryMode ? DateTime.now().day : DateTime.now().month;
        for (int i = maxLength; i <= length - 1; i++) {
          spotList.add(FlSpot(i.toDouble(), 0));
        }
        break;
    }

    print('monthMode: $isMonthSummaryMode');
    print(
        'spotList: ${spotList.toPrintText(xMode: isMonthSummaryMode ? 'day' : 'month', yMode: 'nov')}');
    print(
        'vhListByLength: ${List<List<VisitHistory>>.from(vhListByLength).map<String>((list) {
      return ConvertFromVisitHistoryList(list).toPrintText();
    })}');

    return spotList;
  }

  // [取得：この来店履歴リストから来店理由に一致するデータをすべて取得する]
  List<VisitHistory> getDataByVisitReason(String visitReason) {
    if (!visitReasonData.keys.contains(visitReason)) {
      throw Exception('登録済みのvisitReasonDataに含まれない文字列: $visitReason');
    }

    List<VisitHistory> data = List<VisitHistory>();

    if (this.isNotEmpty) {
      data = List<VisitHistory>.from(this)
          .where((vh) =>
              ConvertFromJson(vh.customerJson).toCustomer().visitReason ==
              visitReason)
          .toList();
    }

    return data;
  }

  // [変換：出力用文字列を取得]
  String toPrintText({
    bool onlyLength = false,
    bool showId = false,
    bool showDate = true,
    bool showCustomer = false,
    bool showEmployee = false,
    bool showMenuList = false,
  }) {
    var str;

    if (onlyLength) {
      str = 'length: ${this.length}';
    } else {
      str = List<VisitHistory>.from(this).map<String>(
        (vh) {
          return vh.toPrintText(
            showId: showId,
            showDate: showDate,
            showCustomer: showCustomer,
            showEmployee: showEmployee,
            showMenuList: showMenuList,
          );
        },
      ).join(', ');
    }

    return 'VisitHistoryList{$str}';
  }
}
