import 'package:customermanagementapp/data/abstract_classes/list_preferences.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_narrow_data.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_sort_data.dart';

class VisitHistoryListPreferences extends ListPreferences {
  VisitHistoryListPreferences({
    this.narrowData,
    this.sortData,
    this.searchCustomerName,
  });

  VisitHistoryNarrowData narrowData;
  VisitHistorySortData sortData;
  String searchCustomerName;

  @override
  String toString() {
    return 'nd: $narrowData, sd: $sortData, sn: $searchCustomerName';
  }
}
