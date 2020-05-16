import 'package:customermanagementapp/data/data_classes/visit_history_list_preferences.dart';
import 'package:customermanagementapp/db/dao/visit_history_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class VisitHistoryRepository extends ChangeNotifier {
  VisitHistoryRepository({dao}) : _dao = dao;

  final VisitHistoryDao _dao;

  List<VisitHistory> _visitHistories = List();

  List<VisitHistory> get visitHistories => _visitHistories;

  // [取得：条件一致データ]
  getVisitHistories({
    VisitHistoryListPreferences vhPref,
  }) async {
    print('[Rep: VisitHistory] getVisitHistories');

    _visitHistories = await _dao.getVisitHistories(vhPref: vhPref);
    notifyListeners();
  }

  // [追加：１件]
  addVisitHistory(
    VisitHistory visitHistory, {
    VisitHistoryListPreferences vhPref,
  }) async {
    print('[Rep: VisitHistory] addVisitHistory');

    _visitHistories =
        await _dao.addAndGetAllVisitHistories(visitHistory, vhPref: vhPref);
    notifyListeners();
  }

  // [追加：複数]
  addAllVisitHistories(
    List<VisitHistory> visitHistoryList, {
    VisitHistoryListPreferences vhPref,
  }) async {
    print('[Rep: VisitHistory] addAllVisitHistory');

    _visitHistories =
        await _dao.addAllAndGetAllVisitHistories(visitHistoryList);
    notifyListeners();
  }

  // [削除：１件]
  deleteVisitHistory(
    VisitHistory visitHistory, {
    VisitHistoryListPreferences vhPref,
  }) async {
    print('[Rep: VisitHistory] deleteVisitHistory');

    _visitHistories =
        await _dao.deleteAndGetAllVisitHistories(visitHistory, vhPref: vhPref);
    notifyListeners();
  }

  // [削除：複数]
  deleteMultipleVisitHistories(
    List<VisitHistory> visitHistoryList,
  ) async {
    print('[Rep: VisitHistory] deleteMultipleVisitHistories');

    _visitHistories = await _dao.deleteMultipleVisitHistories(visitHistoryList);
    notifyListeners();
  }
}
