import 'package:customermanagementapp/data/enums/list_sort_order.dart';
import 'package:customermanagementapp/data/list_search_state/visit_history_sort_state.dart';

class VisitHistorySortData {
  VisitHistorySortData({
    this.sortState = VisitHistorySortState.REGISTER_DATE,
    this.order = ListSortOrder.ASCENDING_ORDER,
  });

  VisitHistorySortState sortState;
  ListSortOrder order;

  @override
  String toString() {
    return 'SortData(ss: $sortState, or: $order)';
  }
}
