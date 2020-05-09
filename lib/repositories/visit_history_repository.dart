import 'package:customermanagementapp/data/data_classes/visit_history_narrow_state.dart';
import 'package:customermanagementapp/data/visit_history_sort_state.dart';
import 'package:customermanagementapp/db/dao/visit_history_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class VisitHistoryRepository extends ChangeNotifier {
  VisitHistoryRepository({dao}) : _dao = dao;

  final VisitHistoryDao _dao;

  // [フィールド：読み込みステータス]
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // [フィールド：メニューカテゴリリスト]
  List<VisitHistory> _visitHistories = List();
  List<VisitHistory> get visitHistories => _visitHistories;

  // [取得：条件付きで来店データを取得]
  getVisitHistories({
    VisitHistoryNarrowData narrowData,
    VisitHistorySortState sortState,
  }) async {
    print('VisitHistoryRepository.getVisitHistories :');

    _isLoading = true;
    notifyListeners();

    _visitHistories = await _dao.getVisitHistories(
        narrowData: narrowData, sortState: sortState);

    _isLoading = false;
    notifyListeners();
  }

  // [追加：１件の来店履歴データを追加]
  addVisitHistory(
    VisitHistory visitHistory, {
    VisitHistoryNarrowData narrowData,
    VisitHistorySortState sortState,
  }) async {
    print('VisitHistoryRepository.addVisitHistory :');

    _isLoading = true;
    notifyListeners();

    _visitHistories = await _dao.addAndGetAllVisitHistories(visitHistory,
        narrowData: narrowData, sortState: sortState);

    _isLoading = false;
    notifyListeners();
  }

  // [追加：複数の来店履歴データを追加]
  addAllVisitHistory(
    List<VisitHistory> visitHistoryList, {
    VisitHistoryNarrowData narrowData,
    VisitHistorySortState sortState,
  }) async {
    print('VisitHistoryRepository.addAllVisitHistory :');

    _isLoading = true;
    notifyListeners();

    _visitHistories = await _dao.addAllAndGetAllVisitHistories(visitHistoryList,
        narrowData: narrowData, sortState: sortState);

    _isLoading = false;
    notifyListeners();
  }

  // [削除：１件の来店履歴データを削除]
  deleteVisitHistory(
    VisitHistory visitHistory, {
    VisitHistoryNarrowData narrowData,
    VisitHistorySortState sortState,
  }) async {
    print('VisitHistoryRepository.deleteVisitHistory :');

    _isLoading = true;
    notifyListeners();

    _visitHistories = await _dao.deleteAndGetAllVisitHistories(visitHistory,
        narrowData: narrowData, sortState: sortState);

    _isLoading = false;
    notifyListeners();
  }

  // [削除：複数の来店履歴を削除]
  deleteMultipleVisitHistories(List<VisitHistory> visitHistoryList) async {
    print('VisitHistoryRepository.deleteMultipleVisitHistories :');

    _isLoading = true;
    notifyListeners();

    _visitHistories = await _dao.deleteMultipleVisitHistories(visitHistoryList);

    _isLoading = false;
    notifyListeners();
  }
}
