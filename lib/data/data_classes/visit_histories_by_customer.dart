import 'package:customermanagementapp/db/database.dart';

class VisitHistoriesByCustomer {
  VisitHistoriesByCustomer({
    this.customer,
    this.histories,
  });

  Customer customer;
  List<VisitHistory> histories;

  @override
  String toString() {
    return 'cusotmer ID [$customer] : history IDs [ ${histories[0]} ]\n';
  }
}
