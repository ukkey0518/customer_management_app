import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/employee_repository.dart';
import 'package:flutter/cupertino.dart';

class EmployeeSettingViewModel extends ChangeNotifier {
  EmployeeSettingViewModel({eRep}) : _eRep = eRep;

  final EmployeeRepository _eRep;

  List<Employee> _employees = List();

  List<Employee> get employees => _employees;

  // [取得：従業員データの取得]
  Future<void> getEmployees() async {
    print('[VM: Employee] getEmployees');
    _employees = await _eRep.getEmployees();
  }

  // [追加：１件の従業員データを追加]
  addEmployee(Employee employee) async {
    print('[VM: Employee] addEmployee');
    _employees = await _eRep.addEmployee(employee);
  }

  // [追加：複数の従業員データを追加]
  addAllEmployee(List<Employee> employeeList) async {
    print('[VM: Employee] addAllEmployee');
    _employees = await _eRep.addAllEmployees(employeeList);
  }

  // [削除：１件の従業員データを削除]
  deleteEmployee(Employee employee) async {
    print('[VM: Employee] deleteEmployee');
    _employees = await _eRep.deleteEmployee(employee);
  }

  // [更新：MyRepositoryの変更があったときに呼ばれる]
  onRepositoryUpdated(EmployeeRepository eRep) {
    print('  [VM: Employee] onRepositoryUpdated');
    _employees = eRep.employees;

    notifyListeners();
  }

  @override
  void dispose() {
    _eRep.dispose();
    super.dispose();
  }
}
