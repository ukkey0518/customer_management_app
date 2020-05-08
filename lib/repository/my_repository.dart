import 'package:customermanagementapp/data/list_status.dart';
import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class MyRepository extends ChangeNotifier {
  // [コンストラクタ：MyDaoを受け取る]
  MyRepository({dao}) : _dao = dao;

  // [定数フィールド：MyDao]
  final MyDao _dao;

  // [フィールド：読み込みステータス]
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // [フィールド：顧客リスト]
  List<Customer> _customers = List();
  List<Customer> get customer => _customers;

  // [フィールド：従業員リスト]
  List<Employee> _employees = List();
  List<Employee> get employees => _employees;

  //
  // --  Customers -------------------------------------------------------------
  //

  // [取得：条件付きで顧客データを取得]
  getCustomers({
    CustomerNarrowState narrowState,
    CustomerSortState sortState,
  }) async {
    print('MyRepostory.getCustomers :');
    _isLoading = true;
    notifyListeners();

    _customers =
        await _dao.getCustomers(narrowState: narrowState, sortState: sortState);

    _isLoading = false;
    notifyListeners();
  }

  // [追加：１つの顧客データを追加]
  addCustomer(
    Customer customer, {
    CustomerNarrowState narrowState,
    CustomerSortState sortState,
  }) async {
    print('MyRepostory.addCustomer :');
    _isLoading = true;
    notifyListeners();

    _customers = await _dao.addAndGetAllCustomers(customer,
        narrowState: narrowState, sortState: sortState);

    _isLoading = false;
    notifyListeners();
  }

  // [追加：複数の顧客データを追加]
  addAllCustomer(
    List<Customer> customerList, {
    CustomerNarrowState narrowState,
    CustomerSortState sortState,
  }) async {
    print('MyRepostory.addAllCustomer :');
    _isLoading = true;
    notifyListeners();

    _customers = await _dao.addAllAndGetAllCustomers(customerList,
        narrowState: narrowState, sortState: sortState);

    _isLoading = false;
    notifyListeners();
  }

  // [削除：１つの顧客データを削除]
  deleteCustomer(
    Customer customer, {
    CustomerNarrowState narrowState,
    CustomerSortState sortState,
  }) async {
    print('MyRepostory.deleteCustomer :');
    _isLoading = true;
    notifyListeners();

    _customers = await _dao.deleteAndGetAllCustomers(customer,
        narrowState: narrowState, sortState: sortState);

    _isLoading = false;
    notifyListeners();
  }

  //
  // -- Employees --------------------------------------------------------------
  //

  // [取得：すべての従業員データを取得]
  getEmployees() async {
    print('MyRepostory.getEmployees :');

    _isLoading = true;
    notifyListeners();

    _employees = await _dao.allEmployees;

    _isLoading = false;
    notifyListeners();
  }

  // [追加：１件の従業員データを追加]
  addEmployee(Employee employee) async {
    print('MyRepostory.addEmployee :');

    _isLoading = true;
    notifyListeners();

    _employees = await _dao.addAndGetAllEmployees(employee);

    _isLoading = false;
    notifyListeners();
  }

  // [追加：複数の従業員データを追加]
  addAllEmployee(List<Employee> employeeList) async {
    print('MyRepostory.addAllEmployee :');

    _isLoading = true;
    notifyListeners();

    _employees = await _dao.addAllAndGetAllEmployees(employeeList);

    _isLoading = false;
    notifyListeners();
  }

  // [削除：１件の従業員データを削除]
  deleteEmployee(Employee employee) async {
    print('MyRepostory.deleteEmployee :');

    _isLoading = true;
    notifyListeners();

    _employees = await _dao.deleteAndGetAllEmployees(employee);

    _isLoading = false;
    notifyListeners();
  }
}
