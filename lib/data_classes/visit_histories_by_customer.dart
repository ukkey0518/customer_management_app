import 'package:customermanagementapp/db/database.dart';

class VisitHistoriesByCustomer {
  VisitHistoriesByCustomer({
    this.customer,
    this.histories,
  });

  Customer customer;
  List<VisitHistory> histories;

  VisitHistory getLastVisitHistory() {
    if (histories.isEmpty) {
      return null;
    }
    var historyList = histories;
    historyList.sort((a, b) {
      var aDate = a.date;
      var bDate = b.date;
      return aDate.isAfter(bDate) ? 1 : -1;
    });
    return historyList.first;
  }

  @override
  String toString() {
    return 'cusotmer ID [${customer.id}] : history IDs [ ${histories.map((h) => h.id)} ]\n';
  }
}
