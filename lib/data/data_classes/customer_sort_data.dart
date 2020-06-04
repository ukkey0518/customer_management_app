import 'package:customermanagementapp/data/enums/list_sort_order.dart';
import 'package:customermanagementapp/data/list_search_state/customer_sort_state.dart';

class CustomerSortData {
  CustomerSortData({
    this.sortState = CustomerSortState.REGISTER_NEW,
    this.order = ListSortOrder.ASCENDING_ORDER,
  });

  CustomerSortState sortState;
  ListSortOrder order;

  @override
  String toString() {
    return '[C]SortData(ss: $sortState, or: $order)';
  }
}
