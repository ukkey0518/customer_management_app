import 'package:customermanagementapp/data/data_classes/customer_narrow_data.dart';
import 'package:customermanagementapp/data/data_classes/customer_sort_data.dart';
import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/enums/list_sort_order.dart';
import 'package:customermanagementapp/data/list_search_state/customer_sort_state.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';

extension ConvertFromVHBCList on List<VisitHistoriesByCustomer> {
  // [生成：顧客リストと来店履歴リストからVHBCリストを生成]
  static List<VisitHistoriesByCustomer> from(
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
    if (this == null || this.isEmpty || customer == null) return null;
    final vhbc = this.singleWhere(
      (vhbc) {
        return vhbc.customer == customer;
      },
    );
    return vhbc;
  }

  // [変換：顧客リストへ変換]
  List<Customer> toCustomers() {
    if (this == null || this.isEmpty) return null;
    return this.map((vhbc) => vhbc.customer).toList();
  }

  // [反映：絞り込み設定を反映する]
  List<VisitHistoriesByCustomer> applyNarrowData(
      CustomerNarrowData narrowData) {
    List<VisitHistoriesByCustomer> dataList = List.from(this);
    if (dataList.isEmpty) return dataList;

    final numOfVisits = narrowData.numOfVisits;
    final isGenderFemale = narrowData.isGenderFemale;
    final age = narrowData.age;
    final sinceLastVisit = narrowData.sinceLastVisit;
    final untilLastVisit = narrowData.untilLastVisit;
    final sinceNextVisit = narrowData.sinceNextVisit;
    final untilNextVisit = narrowData.untilNextVisit;
    final visitReason = narrowData.visitReason;

    // 来店回数で絞り込み
    if (numOfVisits != null) {
      var list = numOfVisits.split('~');
      var min;
      var max;

      if (list.length == 2) {
        min = list[0].isNotEmpty ? int.parse(list[0]) : 0;
        max = list[1].isNotEmpty ? int.parse(list[1]) : null;
      } else {
        min = 0;
        max = null;
      }

      dataList = dataList.where((vhbc) {
        final nov = vhbc.histories.length;
        var minFlag = min <= nov;
        var maxFlag = true;
        if (max != null) {
          maxFlag = nov <= max;
        }

        return minFlag && maxFlag;
      }).toList();
    }

    // 性別で絞り込み
    if (isGenderFemale != null) {
      dataList = dataList.where((vhbc) {
        var customerGender = vhbc.customer.isGenderFemale;
        return customerGender == isGenderFemale;
      }).toList();
    }

    // 年齢層で絞り込み
    if (age != null) {
      var min = int.parse(age.substring(0, age.length - 1));
      var max = min + 9;

      dataList = dataList.where((vhbc) {
        var customerAge = vhbc.customer.birth.toAge();
        return min <= customerAge && customerAge <= max;
      }).toList();
    }

    // 最終来店日で絞り込み
    if (sinceLastVisit != null) {
      dataList = dataList.where((vhbc) {
        final lastVisitDate = vhbc.histories.getLastVisitHistory().date;
        return lastVisitDate.isAtSameMomentAs(sinceLastVisit) ||
            lastVisitDate.isAfter(sinceLastVisit);
      }).toList();
    }

    if (untilLastVisit != null) {
      dataList = dataList.where((vhbc) {
        final lastVisitDate = vhbc.histories.getLastVisitHistory().date;
        return lastVisitDate.isAtSameMomentAs(untilLastVisit) ||
            lastVisitDate.isBefore(untilLastVisit);
      }).toList();
    }

    // 次回来店予想日で絞り込み
    if (sinceNextVisit != null) {
      dataList = dataList.where((vhbc) {
        final expectNextVisit = vhbc.histories.expectedNextVisit();
        return expectNextVisit.isAtSameMomentAs(sinceNextVisit) ||
            expectNextVisit.isAfter(sinceNextVisit);
      }).toList();
    }
    if (untilNextVisit != null) {
      dataList = dataList.where((vhbc) {
        final expectNextVisit = vhbc.histories.expectedNextVisit();
        return expectNextVisit.isAtSameMomentAs(untilNextVisit) ||
            expectNextVisit.isBefore(untilNextVisit);
      }).toList();
    }

    //TODO 来店理由で絞り込み

    print(narrowData);
    dataList.forEach((vhbc) =>
        print('${vhbc.customer.toPrintText()}: ${vhbc.histories.length}'));
    return dataList;
  }

  // [反映：並べ替え設定を反映する]
  List<VisitHistoriesByCustomer> applySortData(CustomerSortData sortData) {
    List<VisitHistoriesByCustomer> dataList = List.from(this);
    switch (sortData.sortState) {
      case CustomerSortState.LAST_VISIT:
        dataList.sort((a, b) {
          final aVh = a.histories.getLastVisitHistory();
          final bVh = b.histories.getLastVisitHistory();
          final aDate = aVh != null ? aVh.date : DateTime(1, 1, 1);
          final bDate = bVh != null ? bVh.date : DateTime(1, 1, 1);
          return aDate.isBefore(bDate) ? 1 : -1;
        });
        break;

      case CustomerSortState.FIRST_VISIT:
        dataList.sort((a, b) {
          final aVh = a.histories.getFirstVisitHistory();
          final bVh = b.histories.getFirstVisitHistory();
          final aDate = aVh != null ? aVh.date : DateTime(1, 1, 1);
          final bDate = bVh != null ? bVh.date : DateTime(1, 1, 1);
          return aDate.isAfter(bDate) ? 1 : -1;
        });
        break;

      case CustomerSortState.EXPECTED_NEXT_VISIT:
        dataList.sort((a, b) {
          final aDate = a.histories.expectedNextVisit();
          final bDate = b.histories.expectedNextVisit();
          return aDate.isAfter(bDate) ? 1 : -1;
        });
        break;

      case CustomerSortState.NAME:
        dataList.sort((a, b) {
          final aCustomerNameReading = a.customer.nameReading;
          final bCustomerNameReading = b.customer.nameReading;
          return aCustomerNameReading
              .toLowerCase()
              .compareTo(bCustomerNameReading.toLowerCase());
        });
        break;

      case CustomerSortState.AGE:
        final birthNotNullData = List<VisitHistoriesByCustomer>();
        final birthNullData = List<VisitHistoriesByCustomer>();
        dataList.forEach((vhbc) {
          final birth = vhbc.customer.birth;
          birth != null ? birthNotNullData.add(vhbc) : birthNullData.add(vhbc);
        });
        birthNotNullData.sort((a, b) {
          final aBirth = a.customer.birth.toAge();
          final bBirth = b.customer.birth.toAge();
          if (aBirth == bBirth) {
            // 同じ年齢の場合は来店日順にソート
            final aLast = a.histories.getLastVisitHistory();
            final bLast = b.histories.getLastVisitHistory();
            final aDate = aLast != null ? aLast.date : DateTime(1, 1, 1);
            final bDate = bLast != null ? bLast.date : DateTime(1, 1, 1);
            return aDate.isAfter(bDate) ? 1 : -1;
          }
          return aBirth > bBirth ? 1 : -1;
        });
        birthNullData.sort((a, b) {
          final aLast = a.histories.getLastVisitHistory();
          final bLast = b.histories.getLastVisitHistory();
          final aDate = aLast != null ? aLast.date : DateTime(1, 1, 1);
          final bDate = bLast != null ? bLast.date : DateTime(1, 1, 1);
          return aDate.isAfter(bDate) ? 1 : -1;
        });
        dataList.clear();
        dataList.addAll(birthNotNullData);
        dataList.addAll(birthNullData);
        break;

      case CustomerSortState.NUM_OF_VISITS:
        dataList.sort((a, b) {
          final aNOV = a.histories.length;
          final bNOV = b.histories.length;
          return aNOV < bNOV ? 1 : -1;
        });
        break;

      case CustomerSortState.REPEAT_CYCLE:
        dataList.sort((a, b) {
          final aRepCy = a.histories.getRepeatCycle();
          final bRepCy = b.histories.getRepeatCycle();
          return aRepCy > bRepCy ? 1 : -1;
        });
        break;

      case CustomerSortState.TOTAL_PAYMENT:
        dataList.sort((a, b) {
          final aTotal = a.histories.getAllSoldMenus().toSumPrice();
          final bTotal = b.histories.getAllSoldMenus().toSumPrice();
          return aTotal < bTotal ? 1 : -1;
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
  List<VisitHistoriesByCustomer> applySearchCustomerName(String name) {
    if (this.isEmpty) return List<VisitHistoriesByCustomer>();

    List<VisitHistoriesByCustomer> dataList = List.from(this);
    if (name == null || name.isEmpty) return dataList;
    dataList.removeWhere((vhbc) {
      final customer = vhbc.customer;
      return !(customer.name.toLowerCase().contains(name.toLowerCase()) ||
          customer.nameReading.toLowerCase().contains(name.toLowerCase()));
    });
    return dataList;
  }
}
