import 'package:customermanagementapp/db/database.dart';

class VisitHistoriesOfCustomer {
  VisitHistoriesOfCustomer({
    this.customer,
    this.histories,
  });

  Customer customer;
  List<VisitHistory> histories;
}
