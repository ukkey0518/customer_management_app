import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/view/components/dialogs/employee_edit_dialog.dart';
import 'package:customermanagementapp/view/components/list_items/employee_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class EmployeeSettingScreen extends StatefulWidget {
  @override
  _EmployeeSettingScreenState createState() => _EmployeeSettingScreenState();
}

class _EmployeeSettingScreenState extends State<EmployeeSettingScreen> {
  List<Employee> _employees = List();

  final dao = MyDao(database);

  @override
  void initState() {
    super.initState();
    _reloadEmployeesList();
  }

  // [更新：従業員リストの更新]
  _reloadEmployeesList() async {
    // すべての従業員リストを取得
    _employees = await dao.allEmployees;
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
        onPressed: () => _showEditEmployeeDialog(),
      ),
      body: ListView.builder(
        itemCount: _employees.length,
        itemBuilder: (context, index) {
          return EmployeeListItem(
            employee: _employees[index],
            onTap: (employee) => _showEditEmployeeDialog(employee),
            onLongPress: (employee) => _deleteEmployee(employee),
          );
        },
      ),
    );
  }

  // [コールバック：FAB・リストアイテムタップ時]
  _showEditEmployeeDialog([Employee employee]) {
    showDialog(
      context: context,
      builder: (_) => EmployeeEditDialog(employee: employee),
    ).then(
      (employee) async {
        if (employee != null) {
          await dao.addEmployee(employee);
        }
        _reloadEmployeesList();
      },
    );
  }

  // [コールバック：リストアイテム長押し時]
  // ・従業員データを削除する
  _deleteEmployee(Employee employee) async {
    await dao.deleteEmployee(employee);
    _reloadEmployeesList();
    Toast.show('削除しました。', context);
  }
}
