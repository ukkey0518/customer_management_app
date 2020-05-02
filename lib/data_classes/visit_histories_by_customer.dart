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
    return 'cusotmer ID [${customer.id}] : history IDs [ ${histories.map((h) => h.id)} ]\n';
  }
}
