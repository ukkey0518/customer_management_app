import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repository/my_repository.dart';
import 'package:flutter/cupertino.dart';

class EmployeeViewModel extends ChangeNotifier {
  // [コンストラクタ：MyRepositoryを受け取る]
  EmployeeViewModel({repository}) : _repository = repository;

  // [定数フィールド：MyRepository]
  final MyRepository _repository;

  // [フィールド：従業員データ]
  List<Employee> _employees = List();
  List<Employee> get employees => _employees;

  // [フィールド：読み込み状態]
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // [取得：従業員データの取得]
  Future<void> getEmployees() async {
    print('EmployeeViewModel.getEmployees :');
    _employees = await _repository.getEmployees();
  }

  // [追加：１件の従業員データを追加]
  addEmployee(Employee employee) async {
    print('EmployeeViewModel.addEmployee :');
    _employees = await _repository.addEmployee(employee);
  }

  // [追加：複数の従業員データを追加]
  addAllEmployee(List<Employee> employeeList) async {
    print('EmployeeViewModel.addAllEmployee :');
    _employees = await _repository.addAllEmployee(employeeList);
  }

  // [削除：１件の従業員データを削除]
  deleteEmployee(Employee employee) async {
    print('EmployeeViewModel.deleteEmployee :');
    _employees = await _repository.deleteEmployee(employee);
  }

  // [更新：MyRepositoryの変更があったときに呼ばれる]
  onRepositoryUpdated(MyRepository repository) {
    print('EmployeeViewModel.onRepositoryUpdated :');
    _employees = repository.employees;
    _isLoading = repository.isLoading;

    notifyListeners();
  }

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }
}
