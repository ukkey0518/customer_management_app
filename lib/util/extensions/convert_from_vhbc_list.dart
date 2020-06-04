import 'package:customermanagementapp/data/data_classes/customer_narrow_data.dart';
import 'package:customermanagementapp/data/data_classes/customer_sort_data.dart';
import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
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
    //TODO
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
