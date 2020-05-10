import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/convert_from_string.dart';

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
    if (this == null || this.isEmpty || customer == null) return null;
    final vhbc = this.singleWhere(
      (vhbc) {
        return vhbc.customer == customer;
      },
    );
    return vhbc;
  }

  List<Customer> toCustomers() {
    if (this == null || this.isEmpty) return null;
    return this.map((vhbc) => vhbc.customer).toList();
  }
}
