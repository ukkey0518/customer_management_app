import 'package:customermanagementapp/data/list_status.dart';
import 'package:customermanagementapp/data/visit_history_sort_state.dart';
import 'package:customermanagementapp/data_classes/visit_history_narrow_state.dart';

class CustomerListScreenPreferences {
  CustomerListScreenPreferences(
      {this.narrowState, this.sortState, this.searchWord});
  CustomerNarrowState narrowState;
  CustomerSortState sortState;
  String searchWord;
}

class VisitHistoryListScreenPreferences {
  VisitHistoryListScreenPreferences(
      {this.narrowData, this.sortState, this.searchWord});
  VisitHistoryNarrowData narrowData;
  VisitHistorySortState sortState;
  String searchWord;
}
