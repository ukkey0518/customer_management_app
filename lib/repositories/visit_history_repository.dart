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

  List<Customer> _customerList = List();
  List<Employee> _employeeList = List();
  List<Menu> _menuList = List();

  List<VisitHistory> _visitHistories = List();

  List<VisitHistory> get visitHistories => _visitHistories;

  // [取得：条件一致データ]
  getVisitHistories({
    VisitHistoryListScreenPreferences vhPref,
  }) async {
    print('[Rep: VisitHistory] getVisitHistories');

    _customerList = await _cRep.getCustomers();
    _employeeList = await _eRep.getEmployees();
    _menuList = await _mRep.getMenus();

    _visitHistories = await _dao.getVisitHistories(vhPref: vhPref);
    notifyListeners();
  }

  // [追加：１件]
  addVisitHistory(
    VisitHistory visitHistory, {
    VisitHistoryListScreenPreferences vhPref,
  }) async {
    print('[Rep: VisitHistory] addVisitHistory');

    _visitHistories =
        await _dao.addAndGetAllVisitHistories(visitHistory, vhPref: vhPref);
    notifyListeners();
  }

  // [追加：複数]
  addAllVisitHistory(
    List<VisitHistory> visitHistoryList, {
    VisitHistoryListScreenPreferences vhPref,
  }) async {
    print('[Rep: VisitHistory] addAllVisitHistory');

    _visitHistories =
        await _dao.addAllAndGetAllVisitHistories(visitHistoryList);
    notifyListeners();
  }

  // [削除：１件]
  deleteVisitHistory(
    VisitHistory visitHistory, {
    VisitHistoryListScreenPreferences vhPref,
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

  onRepositoryUpdated(
    CustomerRepository cRep,
    EmployeeRepository eRep,
    MenuRepository mRep,
  ) {
    print('[Rep: VisitHistory] onRepositoryUpdated');
    _customerList = _cRep.customers;
    _employeeList = _eRep.employees;
    _menuList = _mRep.menus;

    _visitHistories =
        _visitHistories.getUpdate(_customerList, _employeeList, _menuList);
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
