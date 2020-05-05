import 'package:customermanagementapp/db/database.dart';

class VisitHistoryNarrowData {
  const VisitHistoryNarrowData({
    this.sinceDate,
    this.untilDate,
    this.customer,
    this.employee,
    this.menuCategory,
  });

  final DateTime sinceDate;
  final DateTime untilDate;
  final Employee employee;
  final Customer customer;
  final MenuCategory menuCategory;
}
