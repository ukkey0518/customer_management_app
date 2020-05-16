import 'package:customermanagementapp/data/abstract_classes/list_preferences.dart';
import 'package:customermanagementapp/data/list_search_state/customer_narrow_state.dart';
import 'package:customermanagementapp/data/list_search_state/customer_sort_state.dart';

class CustomerListPreferences extends ListPreferences {
  CustomerListPreferences({this.narrowState, this.sortState, this.searchWord});
  CustomerNarrowState narrowState;
  CustomerSortState sortState;
  String searchWord;

  @override
  String toString() {
    return 'n : $narrowState, s: $sortState, sw: $searchWord';
  }
}