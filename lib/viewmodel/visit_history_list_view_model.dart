import 'package:customermanagementapp/data/data_classes/visit_history_list_screen_preferences.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_narrow_data.dart';
import 'package:customermanagementapp/data/drop_down_menu_items.dart';
import 'package:customermanagementapp/data/visit_history_sort_state.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/visit_history_repository.dart';
import 'package:flutter/cupertino.dart';

class VisitHistoryListViewModel extends ChangeNotifier {
  VisitHistoryListViewModel({vhRep}) : _vhRep = vhRep;

  final VisitHistoryRepository _vhRep;

  List<VisitHistory> _visitHistories = List();

  List<VisitHistory> get visitHistories => _visitHistories;

  VisitHistoryListScreenPreferences _vhPref = VisitHistoryListScreenPreferences(
    narrowData: VisitHistoryNarrowData(),
    sortState: VisitHistorySortState.REGISTER_OLD,
    searchCustomerName: '',
  );

  VisitHistoryListScreenPreferences get vhPref => _vhPref;

  TextEditingController _searchNameController = TextEditingController();

  TextEditingController get searchNameController => _searchNameController;

  String _selectedSortValue =
      visitHistorySortStateMap[VisitHistorySortState.REGISTER_OLD];

  String get selectedSortValue => _selectedSortValue;

  getVisitHistories({
    VisitHistoryNarrowData narrowData,
    VisitHistorySortState sortState,
    String searchCustomerName,
  }) async {
    _vhPref = VisitHistoryListScreenPreferences(
      narrowData: narrowData ?? _vhPref.narrowData,
      sortState: sortState ?? _vhPref.sortState,
      searchCustomerName: searchCustomerName ?? _vhPref.searchCustomerName,
    );

    _selectedSortValue = visitHistorySortStateMap[_vhPref.sortState];

    _visitHistories = await _vhRep.getVisitHistories(vhPref: _vhPref);
  }

  deleteVisitHistory(VisitHistory visitHistory) async {
    _visitHistories =
        await _vhRep.deleteVisitHistory(visitHistory, vhPref: _vhPref);
  }

  onRepositoryUpdated(VisitHistoryRepository vhRep) {
    _visitHistories = vhRep.visitHistories;

    notifyListeners();
  }
}
