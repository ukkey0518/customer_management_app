import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repository/my_repository.dart';
import 'package:flutter/cupertino.dart';

class EmployeeSettingViewModel extends ChangeNotifier {
  // [コンストラクタ：MyRepositoryを受け取る]
  EmployeeSettingViewModel({repository}) : _repository = repository;

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
    print('EmployeeSettingViewModel.getEmployees :');
    _employees = await _repository.getEmployees();
  }

  // [追加：１件の従業員データを追加]
  addEmployee(Employee employee) async {
    print('EmployeeSettingViewModel.addEmployee :');
    _employees = await _repository.addEmployee(employee);

    notifyListeners();
  }

  // [追加：複数の従業員データを追加]
  addAllEmployee(List<Employee> employeeList) async {
    print('EmployeeSettingViewModel.addAllEmployee :');
    _employees = await _repository.addAllEmployee(employeeList);

    notifyListeners();
  }

  // [削除：１件の従業員データを削除]
  deleteEmployee(Employee employee) async {
    print('EmployeeSettingViewModel.deleteEmployee :');
    _employees = await _repository.deleteEmployee(employee);

    notifyListeners();
  }

  // [更新：MyRepositoryの変更があったときに呼ばれる]
  onRepositoryUpdated(MyRepository repository) {
    print('EmployeeSettingViewModel.onRepositoryUpdated :');
    _employees = repository.employees;
    _isLoading = repository.isLoading;
  }

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }
}
