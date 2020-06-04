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
  void applyNarrowData(CustomerNarrowData narrowData) {
    //TODO
  }

  // [反映：並べ替え設定を反映する]
  void applySortData(CustomerSortData sortData) {
    switch (sortData.sortState) {
      case CustomerSortState.LAST_VISIT:
        this.sort((a, b) {
          final aVh = a.histories.getLastVisitHistory();
          final bVh = b.histories.getLastVisitHistory();
          return aVh.date.isBefore(bVh.date) ? 1 : -1;
        });
        break;

      case CustomerSortState.FIRST_VISIT:
        this.sort((a, b) {
          final aVh = a.histories.getFirstVisitHistory();
          final bVh = b.histories.getFirstVisitHistory();
          return aVh.date.isAfter(bVh.date) ? 1 : -1;
        });
        break;

      case CustomerSortState.EXPECTED_NEXT_VISIT:
        this.sort((a, b) {
          final aDate = a.histories.expectedNextVisit();
          final bDate = b.histories.expectedNextVisit();
          return aDate.isAfter(bDate) ? 1 : -1;
        });
        break;

      case CustomerSortState.NAME:
        this.sort((a, b) {
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
        this.forEach((vhbc) {
          final birth = vhbc.customer.birth;
          birth != null ? birthNotNullData.add(vhbc) : birthNullData.add(vhbc);
        });
        birthNotNullData.sort((a, b) => a.histories
                .getLastVisitHistory()
                .date
                .isBefore(b.histories.getLastVisitHistory().date)
            ? 1
            : -1);
        birthNullData.sort((a, b) => a.histories
                .getLastVisitHistory()
                .date
                .isBefore(b.histories.getLastVisitHistory().date)
            ? 1
            : -1);
        this.clear();
        this.addAll(birthNotNullData);
        this.addAll(birthNullData);
        break;

      case CustomerSortState.NUM_OF_VISITS:
        this.sort((a, b) {
          final aNOV = a.histories.length;
          final bNOV = b.histories.length;
          return aNOV < bNOV ? 1 : -1;
        });
        break;

      case CustomerSortState.REPEAT_CYCLE:
        this.sort((a, b) {
          final aRepCy = a.histories.getRepeatCycle();
          final bRepCy = b.histories.getRepeatCycle();
          return aRepCy < bRepCy ? 1 : -1;
        });
        break;

      case CustomerSortState.TOTAL_PAYMENT:
        this.sort((a, b) {
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
        final reversedList = this.reversed.toList();
        this.clear();
        this.addAll(reversedList);
        break;
    }
  }

  // [反映：名前で検索する]
  void applySearchCustomerName(String name) {
    if (name == null || name.isEmpty) return;
    this.removeWhere((vhbc) {
      final customer = vhbc.customer;
      return !(customer.name.contains(name) ||
          customer.nameReading.contains(name));
    });
  }
}
