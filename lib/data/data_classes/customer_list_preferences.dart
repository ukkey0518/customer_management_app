import 'package:customermanagementapp/data/abstract_classes/list_preferences.dart';
import 'package:customermanagementapp/data/data_classes/customer_narrow_data.dart';
import 'package:customermanagementapp/data/data_classes/customer_sort_data.dart';

class CustomerListPreferences extends ListPreferences {
  CustomerListPreferences({this.narrowData, this.sortData, this.searchWord});

  CustomerNarrowData narrowData;
  CustomerSortData sortData;
  String searchWord;

  @override
  String toString() {
    return 'n: $narrowData, s: $sortData, sw: $searchWord';
  }
}
