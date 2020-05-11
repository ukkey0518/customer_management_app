import 'package:customermanagementapp/data/data_classes/visit_history_narrow_state.dart';
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

  VisitHistoryNarrowData _narrowData = VisitHistoryNarrowData();
  VisitHistoryNarrowData get narrowData => _narrowData;

  VisitHistorySortState _sortState = VisitHistorySortState.REGISTER_OLD;
  VisitHistorySortState get sortState => _sortState;

  String _selectedSortValue = '';
  String get selectedSortValue => _selectedSortValue;

  getVisitHistories({
    VisitHistoryNarrowData narrowData,
    VisitHistorySortState sortState,
  }) async {
    _narrowData = narrowData ?? _narrowData;
    _sortState = sortState ?? _sortState;

    _selectedSortValue = visitHistorySortStateMap[_sortState];

    _visitHistories = await _vhRep.getVisitHistories(
        narrowData: _narrowData, sortState: _sortState);
  }

  deleteVisitHistory(VisitHistory visitHistory) async {
    _visitHistories = await _vhRep.deleteVisitHistory(visitHistory,
        narrowData: _narrowData, sortState: _sortState);
  }

  onRepositoryUpdated(VisitHistoryRepository vhRep) {
    _visitHistories = vhRep.visitHistories;

    notifyListeners();
  }
}
