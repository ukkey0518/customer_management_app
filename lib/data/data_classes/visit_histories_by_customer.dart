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
    return 'customer ID [$customer] : history IDs [ ${histories.isEmpty ? 'Empty' : histories[0]} ]\n';
  }
}
