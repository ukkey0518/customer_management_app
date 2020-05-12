import 'package:customermanagementapp/data/data_classes/visit_history_list_screen_preferences.dart';
import 'package:customermanagementapp/db/dao/visit_history_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/customer_repository.dart';
import 'package:customermanagementapp/repositories/employee_repository.dart';
import 'package:customermanagementapp/repositories/menu_repository.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class VisitHistoryRepository extends ChangeNotifier {
  VisitHistoryRepository({dao, cRep, eRep, mRep})
      : _dao = dao,
        _cRep = cRep,
        _eRep = eRep,
        _mRep = mRep;

  final VisitHistoryDao _dao;
  final CustomerRepository _cRep;
  final EmployeeRepository _eRep;
  final MenuRepository _mRep;

  List<Customer> _customerList;
  List<Employee> _employeeList;
  List<Menu> _menuList;

  // [フィールド：読み込みステータス]
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // [フィールド：メニューカテゴリリスト]
  List<VisitHistory> _visitHistories = List();

  List<VisitHistory> get visitHistories => _visitHistories;

  // [取得：条件付きで来店データを取得]
  getVisitHistories({
    VisitHistoryListScreenPreferences vhPref,
  }) async {
    print('VisitHistoryRepository.getVisitHistories :');

    _isLoading = true;
    notifyListeners();

    _customerList = await _cRep.getCustomers();
    _employeeList = await _eRep.getEmployees();
    _menuList = await _mRep.getMenus();

    _visitHistories = await _dao.getVisitHistories(vhPref: vhPref);

    _isLoading = false;
    notifyListeners();
  }

  // [追加：１件の来店履歴データを追加]
  addVisitHistory(
    VisitHistory visitHistory, {
    VisitHistoryListScreenPreferences vhPref,
  }) async {
    print('VisitHistoryRepository.addVisitHistory :');

    _isLoading = true;
    notifyListeners();

    _visitHistories =
        await _dao.addAndGetAllVisitHistories(visitHistory, vhPref: vhPref);

    _isLoading = false;
    notifyListeners();
  }

  // [追加：複数の来店履歴データを追加]
  addAllVisitHistory(
    List<VisitHistory> visitHistoryList, {
    VisitHistoryListScreenPreferences vhPref,
  }) async {
    print('VisitHistoryRepository.addAllVisitHistory :');

    _isLoading = true;
    notifyListeners();

    _visitHistories = await _dao.addAllAndGetAllVisitHistories(visitHistoryList,
        vhPref: vhPref);

    _isLoading = false;
    notifyListeners();
  }

  // [削除：１件の来店履歴データを削除]
  deleteVisitHistory(
    VisitHistory visitHistory, {
    VisitHistoryListScreenPreferences vhPref,
  }) async {
    print('VisitHistoryRepository.deleteVisitHistory :');

    _isLoading = true;
    notifyListeners();

    _visitHistories =
        await _dao.deleteAndGetAllVisitHistories(visitHistory, vhPref: vhPref);

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

  onRepositoryUpdated(
      CustomerRepository cRep, EmployeeRepository eRep, MenuRepository mRep) {
    print(_visitHistories);
    _customerList = _cRep.customers;
    _employeeList = _eRep.employees;
    _menuList = _mRep.menus;

    _visitHistories =
        _visitHistories.getUpdate(_customerList, _employeeList, _menuList);
    print(_visitHistories);
    notifyListeners();
  }

  @override
  void dispose() {
    _cRep.dispose();
    _eRep.dispose();
    _mRep.dispose();
    super.dispose();
  }
}
