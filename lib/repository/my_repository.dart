import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class MyRepository extends ChangeNotifier {
  // [コンストラクタ：MyDaoを受け取る]
  MyRepository({dao}) : _dao = dao;

  // [定数フィールド：MyDao]
  final MyDao _dao;

  // [priフィールド：従業員リスト]
  List<Employee> _employees = List();

  // [getter：_employees]
  List<Employee> get employees => _employees;

  // [取得：すべての従業員データを取得]
  getEmployees() async {
    print('MyRepostory.getEmployees :');

    _employees = await _dao.allEmployees;

    notifyListeners();
  }

  // [追加：１件の従業員データを追加]
  addEmployee(Employee employee) async {
    print('MyRepostory.addEmployee :');
    _employees = await _dao.addAndGetAllEmployees(employee);

    notifyListeners();
  }

  // [削除：１件の従業員データを削除]
  deleteEmployee(Employee employee) async {
    print('MyRepostory.deleteEmployee :');
    _employees = await _dao.deleteAndGetAllEmployees(employee);

    notifyListeners();
  }
}
