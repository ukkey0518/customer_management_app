import 'package:customermanagementapp/data/data_classes/visit_history_narrow_state.dart';
import 'package:customermanagementapp/data/visit_history_sort_state.dart';

class VisitHistoryListScreenPreferences {
  VisitHistoryListScreenPreferences(
      {this.narrowData, this.sortState, this.searchCustomerName});

  VisitHistoryNarrowData narrowData;
  VisitHistorySortState sortState;
  String searchCustomerName;
}
