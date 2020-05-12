import 'package:customermanagementapp/data/list_status.dart';

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
