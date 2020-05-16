import 'package:customermanagementapp/data/abstract_classes/list_preferences.dart';
import 'package:customermanagementapp/data/data_classes/customer_list_preferences.dart';
import 'package:customermanagementapp/data/data_classes/menus_by_category.dart';
import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_list_preferences.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_narrow_data.dart';
import 'package:customermanagementapp/data/list_search_state/customer_narrow_state.dart';
import 'package:customermanagementapp/data/list_search_state/customer_sort_state.dart';
import 'package:customermanagementapp/data/list_search_state/visit_history_sort_state.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/customer_repository.dart';
import 'package:customermanagementapp/repositories/employee_repository.dart';
import 'package:customermanagementapp/repositories/menu_category_repository.dart';
import 'package:customermanagementapp/repositories/menu_repository.dart';
import 'package:customermanagementapp/repositories/visit_history_repository.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class GlobalRepository extends ChangeNotifier {
  GlobalRepository({cRep, eRep, mcRep, mRep, vhRep})
      : _cRep = cRep,
        _eRep = eRep,
        _mcRep = mcRep,
        _mRep = mRep,
        _vhRep = vhRep;

  final CustomerRepository _cRep;
  final EmployeeRepository _eRep;
  final MenuCategoryRepository _mcRep;
  final MenuRepository _mRep;
  final VisitHistoryRepository _vhRep;

  CustomerListPreferences _cPref = CustomerListPreferences(
    narrowState: CustomerNarrowState.ALL,
    sortState: CustomerSortState.REGISTER_OLD,
    searchWord: '',
  );

  CustomerListPreferences get cPref => _cPref;

  VisitHistoryListPreferences _vhPref = VisitHistoryListPreferences(
    narrowData: VisitHistoryNarrowData(),
    sortState: VisitHistorySortState.REGISTER_OLD,
    searchCustomerName: '',
  );

  VisitHistoryListPreferences get vhPref => _vhPref;

  List<Customer> _customers = List();

  List<Customer> get customers => _customers;

  List<Employee> _employees = List();

  List<Employee> get employees => _employees;

  List<MenuCategory> _menuCategories = List();

  List<MenuCategory> get menuCategories => _menuCategories;

  List<Menu> _menus = List();

  List<Menu> get menus => _menus;

  List<VisitHistory> _visitHistories = List();

  List<VisitHistory> get visitHistories => _visitHistories;

  List<MenusByCategory> _menusByCategories = List<MenusByCategory>();

  List<MenusByCategory> get menusByCategories => _menusByCategories;

  List<VisitHistoriesByCustomer> _visitHistoriesByCustomers =
      List<VisitHistoriesByCustomer>();

  List<VisitHistoriesByCustomer> get visitHistoriesByCustomers =>
      _visitHistoriesByCustomers;

  getData({
    CustomerListPreferences cPref,
    VisitHistoryListPreferences vhPref,
  }) async {
    print('[Rep: Global] getData');
    _cPref = cPref ?? _cPref;
    _vhPref = vhPref ?? _vhPref;

    _customers = await _cRep.getCustomers(cPref: _cPref);
    _employees = await _eRep.getEmployees();
    _menuCategories = await _mcRep.getMenuCategories();
    _menus = await _mRep.getMenus();
    _visitHistories = await _vhRep.getVisitHistories(vhPref: _vhPref);

    _menusByCategories = _menusByCategories.build(_menus, _menuCategories);
    _visitHistoriesByCustomers =
        ConvertFromVHBCList.vhbcListFrom(_customers, _visitHistories);
    notifyListeners();
  }

  addSingleData(dynamic data, {ListPreferences pref}) async {
    print('[Rep: Global] addSingleData');
    switch (data.runtimeType) {
      case Customer:
        _customers = await _cRep.addCustomer(data, cPref: pref);
        break;
      case Employee:
        _employees = await _eRep.addEmployee(data);
        break;
      case MenuCategory:
        _menuCategories = await _mcRep.addMenuCategory(data);
        break;
      case Menu:
        _menus = await _mRep.addMenu(data);
        break;
      case VisitHistory:
        _visitHistories = await _vhRep.addVisitHistory(data, vhPref: pref);
        break;
    }
  }

  addMultipleData(List<dynamic> dataList, {ListPreferences pref}) async {
    print('[Rep: Global] addMultipleData');
    switch (dataList.single.runtimeType) {
      case Customer:
        _customers = await _cRep.addAllCustomers(dataList, cPref: pref);
        break;
      case Employee:
        _employees = await _eRep.addAllEmployees(dataList);
        break;
      case MenuCategory:
        _menuCategories = await _mcRep.addAllMenuCategories(dataList);
        break;
      case Menu:
        _menus = await _mRep.addAllMenus(dataList);
        break;
      case VisitHistory:
        _visitHistories =
            await _vhRep.addAllVisitHistories(dataList, vhPref: pref);
        break;
    }
  }

  deleteData(dynamic data, {ListPreferences pref}) async {
    print('[Rep: Global] deleteData');
    switch (data.runtimeType) {
      case Customer:
        _customers = await _cRep.deleteCustomer(data, cPref: pref);
        break;
      case Employee:
        _employees = await _eRep.deleteEmployee(data);
        break;
      case MenuCategory:
        _menuCategories = await _mcRep.deleteMenuCategory(data);
        break;
      case Menu:
        _menus = await _mRep.deleteMenu(data);
        break;
      case VisitHistory:
        _visitHistories = await _vhRep.deleteVisitHistory(data, vhPref: pref);
        break;
      case VisitHistoriesByCustomer:
        _customers = await _cRep.deleteCustomer(data.customer, cPref: cPref);
        _visitHistories =
            await _vhRep.deleteMultipleVisitHistories(data.histories);
    }
  }

  setMBCExpanded(int index, bool isExpanded) {
    print('[Rep: Global] setMBCExpanded');
    _menusByCategories[index].isExpanded = isExpanded;
    notifyListeners();
  }

  onRepositoriesUpdated(
    CustomerRepository cRep,
    EmployeeRepository eRep,
    MenuCategoryRepository mcRep,
    MenuRepository mRep,
    VisitHistoryRepository vhRep,
  ) {
    print('  [Rep: Global] onRepositoriesUpdated');
    _customers = cRep.customers;
    _employees = eRep.employees;
    _menuCategories = mcRep.menuCategories;
    _menus = mRep.menus;
    _visitHistories =
        vhRep.visitHistories.getUpdate(_customers, _employees, _menus);

    _menusByCategories = _menusByCategories.build(_menus, _menuCategories);
    _visitHistoriesByCustomers =
        ConvertFromVHBCList.vhbcListFrom(_customers, _visitHistories);
    notifyListeners();
  }

  @override
  void dispose() {
    _cRep.dispose();
    _eRep.dispose();
    _mcRep.dispose();
    _mRep.dispose();
    _vhRep.dispose();
    super.dispose();
  }
}
