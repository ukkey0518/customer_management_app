import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:flutter/material.dart';

class EmployeeSettingScreen extends StatefulWidget {
  @override
  _EmployeeSettingScreenState createState() => _EmployeeSettingScreenState();
}

class _EmployeeSettingScreenState extends State<EmployeeSettingScreen> {
  List<Employee> _employees;

  @override
  void initState() {
    super.initState();
    _reloadEmployeesList();
  }

  // [更新：従業員リストの更新]
  _reloadEmployeesList() async {
    // すべての従業員リストを取得
    _employees = await database.allEmployees;
    // 画面を更新
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('スタッフ管理'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddEmployeeDialog(),
      ),
      body: Container(),
    );
  }

  // [コールバック：FABタップ時]
  // ・追加用ダイアログを表示する
  _showAddEmployeeDialog() {}
}
