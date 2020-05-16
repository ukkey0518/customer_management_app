import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/global_repository.dart';
import 'package:flutter/cupertino.dart';

class EmployeeSettingViewModel extends ChangeNotifier {
  EmployeeSettingViewModel({gRep}) : _gRep = gRep;

  final GlobalRepository _gRep;

  List<Employee> _employees = List();

  List<Employee> get employees => _employees;

  // [取得：従業員データの取得]
  Future<void> getEmployees() async {
    print('[VM: Employee] getEmployees');
    await _gRep.getData();
    _employees = _gRep.employees;
  }

  // [追加：１件の従業員データを追加]
  addEmployee(Employee employee) async {
    print('[VM: Employee] addEmployee');
    _employees = await _gRep.addSingleData(employee);
  }

  // [追加：複数の従業員データを追加]
  addAllEmployee(List<Employee> employeeList) async {
    print('[VM: Employee] addAllEmployee');
    _employees = await _gRep.addMultipleData(employeeList);
  }

  // [削除：１件の従業員データを削除]
  deleteEmployee(Employee employee) async {
    print('[VM: Employee] deleteEmployee');
    _employees = await _gRep.deleteData(employee);
  }

  // [更新：MyRepositoryの変更があったときに呼ばれる]
  onRepositoryUpdated(GlobalRepository gRep) {
    print('  [VM: Employee] onRepositoryUpdated');
    _employees = gRep.employees;

    notifyListeners();
  }

  @override
  void dispose() {
    _gRep.dispose();
    super.dispose();
  }
}
