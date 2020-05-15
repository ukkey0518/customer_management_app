import 'package:customermanagementapp/data/drop_down_menu_items/customer_narrow_state.dart';
import 'package:customermanagementapp/data/drop_down_menu_items/customer_sort_state.dart';

class CustomerListScreenPreferences {
  CustomerListScreenPreferences(
      {this.narrowState, this.sortState, this.searchWord});
  CustomerNarrowState narrowState;
  CustomerSortState sortState;
  String searchWord;

  @override
  String toString() {
    return 'n : $narrowState, s: $sortState, sw: $searchWord';
  }
}
