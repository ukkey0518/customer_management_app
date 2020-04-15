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

  // [コールバック：FABタップ時]
  // ・追加用ダイアログを表示する
  _showAddEmployeeDialog() {}

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

  // [ウィジェット：従業員データ編集用ダイアログ]
  Widget _editEmployeeDialog([Employee employee]) {
    var titleText;
    var nameController = TextEditingController();
    var positiveButtonText;

    // 引数にEmployeeが渡されたときは編集用として開く
    if (employee = null) {
      titleText = 'スタッフ情報登録';
      nameController.text = '';
      positiveButtonText = '追加';
    } else {
      titleText = 'スタッフ情報編集';
      nameController.text = employee.name;
      positiveButtonText = '更新';
    }

    return AlertDialog(
      title: Text(titleText),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('名前'),
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'スタッフ名を入力'),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('キャンセル'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text(positiveButtonText),
          onPressed: null, // TODO
        )
      ],
    );
  }
}
