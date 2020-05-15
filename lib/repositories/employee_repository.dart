import 'package:customermanagementapp/db/dao/employee_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class EmployeeRepository extends ChangeNotifier {
  EmployeeRepository({dao}) : _dao = dao;

  final EmployeeDao _dao;

  List<Employee> _employees = List();

  List<Employee> get employees => _employees;

  // [取得：すべて]
  getEmployees() async {
    print('[Rep: Employee] getEmployees');

    _employees = await _dao.allEmployees;
    notifyListeners();
  }

  // [追加：１件の従業員データを追加]
  addEmployee(
    Employee employee,
  ) async {
    print('[Rep: Employee] addEmployee');

    _employees = await _dao.addAndGetAllEmployees(employee);
    notifyListeners();
  }

  // [追加：複数]
  addAllEmployees(
    List<Employee> employeeList,
  ) async {
    print('[Rep: Employee] addAllEmployees');

    _employees = await _dao.addAllAndGetAllEmployees(employeeList);
    notifyListeners();
  }

  // [削除：１件]
  deleteEmployee(
    Employee employee,
  ) async {
    print('[Rep: Employee] deleteEmployee');

    _employees = await _dao.deleteAndGetAllEmployees(employee);
    notifyListeners();
  }
}
