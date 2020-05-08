import 'package:customermanagementapp/db/dao/employee_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class EmployeeRepository extends ChangeNotifier {
  EmployeeRepository({dao}) : _dao = dao;

  final EmployeeDao _dao;

  // [フィールド：読み込みステータス]
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // [フィールド：従業員リスト]
  List<Employee> _employees = List();
  List<Employee> get employees => _employees;

  // [取得：すべての従業員データを取得]
  getEmployees() async {
    print('EmployeeRepository.getEmployees :');

    _isLoading = true;
    notifyListeners();

    _employees = await _dao.allEmployees;

    _isLoading = false;
    notifyListeners();
  }

  // [追加：１件の従業員データを追加]
  addEmployee(Employee employee) async {
    print('EmployeeRepository.addEmployee :');

    _isLoading = true;
    notifyListeners();

    _employees = await _dao.addAndGetAllEmployees(employee);

    _isLoading = false;
    notifyListeners();
  }

  // [追加：複数の従業員データを追加]
  addAllEmployee(List<Employee> employeeList) async {
    print('EmployeeRepository.addAllEmployee :');

    _isLoading = true;
    notifyListeners();

    _employees = await _dao.addAllAndGetAllEmployees(employeeList);

    _isLoading = false;
    notifyListeners();
  }

  // [削除：１件の従業員データを削除]
  deleteEmployee(Employee employee) async {
    print('EmployeeRepository.deleteEmployee :');

    _isLoading = true;
    notifyListeners();

    _employees = await _dao.deleteAndGetAllEmployees(employee);

    _isLoading = false;
    notifyListeners();
  }
}
