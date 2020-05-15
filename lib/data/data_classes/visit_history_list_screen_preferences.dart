import 'package:customermanagementapp/data/data_classes/visit_history_narrow_data.dart';
import 'package:customermanagementapp/data/list_search_state/visit_history_sort_state.dart';

class VisitHistoryListScreenPreferences {
  VisitHistoryListScreenPreferences(
      {this.narrowData, this.sortState, this.searchCustomerName});

  VisitHistoryNarrowData narrowData;
  VisitHistorySortState sortState;
  String searchCustomerName;

  @override
  String toString() {
    return 'nd: $narrowData, ss: $sortState, sn: $searchCustomerName';
  }
}
