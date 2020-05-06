import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class MyRepository extends ChangeNotifier {
  // [コンストラクタ：MyDaoを受け取る]
  MyRepository({dao}) : _dao = dao;

  // [定数フィールド：MyDao]
  final MyDao _dao;

  // [priフィールド：従業員リスト]
  List<Employee> _employees;

  // [getter：_employees]
  List<Employee> get employees => _employees;

  // [取得：すべての従業員データを取得]
  getEmployees() async {
    print('MyRepostory.getEmployees :');

    _employees  = await _dao.allEmployees;

    notifyListeners();
  }

}
