import 'package:customermanagementapp/data/data_classes/visit_history_list_preferences.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_narrow_data.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_sort_data.dart';
import 'package:customermanagementapp/data/enums/list_sort_order.dart';
import 'package:customermanagementapp/data/list_search_state/visit_history_sort_state.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/global_repository.dart';
import 'package:flutter/cupertino.dart';

class VisitHistoryListViewModel extends ChangeNotifier {
  VisitHistoryListViewModel({gRep}) : _gRep = gRep;

  final GlobalRepository _gRep;

  List<VisitHistory> _visitHistories = List();

  List<VisitHistory> get visitHistories => _visitHistories;

  List<Employee> _allEmployees = List();

  List<Employee> get allEmployees => _allEmployees;

  List<MenuCategory> _allMenuCategories = List();

  List<MenuCategory> get allMenuCategories => _allMenuCategories;

  VisitHistoryListPreferences _vhPref = VisitHistoryListPreferences(
    narrowData: VisitHistoryNarrowData(),
    sortData: VisitHistorySortData(),
    searchCustomerName: '',
  );

  VisitHistoryListPreferences get vhPref => _vhPref;

  TextEditingController _searchNameController = TextEditingController();

  TextEditingController get searchNameController => _searchNameController;

  String _selectedSortValue =
      visitHistorySortStateMap[VisitHistorySortState.REGISTER_DATE];

  String get selectedSortValue => _selectedSortValue;

  ListSortOrder _selectedOrder = ListSortOrder.ASCENDING_ORDER;

  ListSortOrder get selectedOrder => _selectedOrder;

  getVisitHistories({
    VisitHistoryNarrowData narrowData,
    VisitHistorySortData sortData,
    String searchCustomerName,
  }) async {
    print('[VM: 来店履歴リスト画面] getVisitHistories');
    _vhPref = VisitHistoryListPreferences(
      narrowData: narrowData ?? _vhPref.narrowData,
      sortData: sortData ?? _vhPref.sortData,
      searchCustomerName: searchCustomerName ?? _vhPref.searchCustomerName,
    );

    _selectedSortValue = visitHistorySortStateMap[_vhPref.sortData.sortState];
    _selectedOrder = _vhPref.sortData.order;

    await _gRep.getData(vhPref: _vhPref);
    _visitHistories = _gRep.visitHistories;
    _allEmployees = _gRep.employees;
    _allMenuCategories = _gRep.menuCategories;
  }

  deleteVisitHistory(VisitHistory visitHistory) async {
    print('[VM: 来店履歴リスト画面] deleteVisitHistory');
    _visitHistories = await _gRep.deleteData(visitHistory, pref: _vhPref);
  }

  onRepositoryUpdated(GlobalRepository gRep) {
    print('  [VM: 来店履歴リスト画面] onRepositoryUpdated');
    _visitHistories = gRep.visitHistories;
    _allEmployees = gRep.employees;
    _allMenuCategories = gRep.menuCategories;

    notifyListeners();
  }

  @override
  void dispose() {
    _gRep.dispose();
    super.dispose();
  }
}
