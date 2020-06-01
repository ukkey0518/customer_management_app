import 'package:customermanagementapp/data/data_classes/visit_history_list_preferences.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_narrow_data.dart';
import 'package:customermanagementapp/data/list_search_state/visit_history_sort_state.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/global_repository.dart';
import 'package:flutter/cupertino.dart';

class VisitHistoryListViewModel extends ChangeNotifier {
  VisitHistoryListViewModel({gRep}) : _gRep = gRep;

  final GlobalRepository _gRep;

  List<VisitHistory> _visitHistories = List();

  List<VisitHistory> get visitHistories => _visitHistories;

  VisitHistoryListPreferences _vhPref = VisitHistoryListPreferences(
    narrowData: VisitHistoryNarrowData(),
    sortState: VisitHistorySortState.REGISTER_DATE,
    searchCustomerName: '',
  );

  VisitHistoryListPreferences get vhPref => _vhPref;

  TextEditingController _searchNameController = TextEditingController();

  TextEditingController get searchNameController => _searchNameController;

  String _selectedSortValue =
      visitHistorySortStateMap[VisitHistorySortState.REGISTER_DATE];

  String get selectedSortValue => _selectedSortValue;

  getVisitHistories({
    VisitHistoryNarrowData narrowData,
    VisitHistorySortState sortState,
    String searchCustomerName,
  }) async {
    print('[VM: 来店履歴リスト画面] getVisitHistories');
    _vhPref = VisitHistoryListPreferences(
      narrowData: narrowData ?? _vhPref.narrowData,
      sortState: sortState ?? _vhPref.sortState,
      searchCustomerName: searchCustomerName ?? _vhPref.searchCustomerName,
    );

    _selectedSortValue = visitHistorySortStateMap[_vhPref.sortState];

    await _gRep.getData(vhPref: _vhPref);
    _visitHistories = _gRep.visitHistories;
  }

  deleteVisitHistory(VisitHistory visitHistory) async {
    print('[VM: 来店履歴リスト画面] deleteVisitHistory');
    _visitHistories = await _gRep.deleteData(visitHistory, pref: _vhPref);
  }

  onRepositoryUpdated(GlobalRepository gRep) {
    print('  [VM: 来店履歴リスト画面] onRepositoryUpdated');
    _visitHistories = gRep.visitHistories;

    notifyListeners();
  }

  @override
  void dispose() {
    _gRep.dispose();
    super.dispose();
  }
}
