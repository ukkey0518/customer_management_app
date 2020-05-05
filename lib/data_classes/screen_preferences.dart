import 'package:customermanagementapp/data/list_status.dart';
import 'package:customermanagementapp/data/visit_history_sort_state.dart';

class CustomerListScreenPreferences {
  CustomerListScreenPreferences(
      {this.narrowState, this.sortState, this.searchWord});
  CustomerNarrowState narrowState;
  CustomerSortState sortState;
  String searchWord;
}

class VisitHistoryListScreenPreferences {
  VisitHistoryListScreenPreferences(
      {this.narrowState, this.sortState, this.searchWord});
  VisitHistoryNarrowState narrowState;
  VisitHistorySortState sortState;
  String searchWord;
}
