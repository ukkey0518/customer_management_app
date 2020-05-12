import 'package:customermanagementapp/db/database.dart';

class VisitHistoryNarrowData {
  VisitHistoryNarrowData({
    this.sinceDate,
    this.untilDate,
    this.customer,
    this.employee,
    this.menuCategory,
  });

  DateTime sinceDate;
  DateTime untilDate;
  Employee employee;
  Customer customer;
  MenuCategory menuCategory;

  // [判定：何かしらの絞り込み条件が設定されているか]
  bool isSetAny() {
    return sinceDate != null ||
        untilDate != null ||
        customer != null ||
        employee != null ||
        menuCategory != null;
  }

  // [変更：条件をすべてクリアする]
  void clear() {
    sinceDate = null;
    untilDate = null;
    employee = null;
    customer = null;
    menuCategory = null;
  }

  @override
  String toString() {
    return 'NarrowData(sd: $sinceDate, ud: $untilDate, em: $employee, cu: $customer, mc: $menuCategory)';
  }
}
