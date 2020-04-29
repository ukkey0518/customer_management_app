import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class EmployeeSettingScreen extends StatefulWidget {
  @override
  _EmployeeSettingScreenState createState() => _EmployeeSettingScreenState();
}

class _EmployeeSettingScreenState extends State<EmployeeSettingScreen> {
  List<Employee> _employees = List();

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
  _showAddEmployeeDialog() {
    showDialog(
      context: context,
      builder: (_) => _editEmployeeDialog(),
    ).then(
      (_) => _reloadEmployeesList(),
    );
  }

  // [コールバック：リストアイテムタップ時]
  // ・従業員データを編集するダイアログを開く
  _showEditEmployeeDialog(Employee employee) {
    showDialog(
      context: context,
      builder: (_) => _editEmployeeDialog(employee),
    ).then(
      (_) => _reloadEmployeesList(),
    );
  }

  // [コールバック：リストアイテム長押し時]
  // ・従業員データを削除する
  _deleteEmployee(Employee employee) async {
    await database.deleteEmployee(employee);
    _reloadEmployeesList();
    Toast.show('削除しました。', context);
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
        onPressed: () => _showAddEmployeeDialog(),
      ),
      body: ListView.builder(
        itemCount: _employees.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.supervisor_account),
                title: Text(_employees[index].name),
                onTap: () => _showEditEmployeeDialog(_employees[index]),
                onLongPress: () => _deleteEmployee(_employees[index]),
              ),
              Divider(height: 1),
            ],
          );
        },
      ),
    );
  }

  // [ウィジェット：従業員データ編集用ダイアログ]
  Widget _editEmployeeDialog([Employee employee]) {
    var titleText;
    var nameController = TextEditingController();
    var positiveButtonText;
    var databaseProcess;

    // 引数にEmployeeが渡されたときは編集用として開く
    if (employee == null) {
      titleText = 'スタッフ情報登録';
      nameController.text = '';
      positiveButtonText = '追加';
      databaseProcess = () async {
        var newEmployee = Employee(id: null, name: nameController.text);
        await database.addEmployee(newEmployee);
        Toast.show('登録されました。', context);
      };
    } else {
      titleText = 'スタッフ情報編集';
      nameController.text = employee.name;
      positiveButtonText = '更新';
      databaseProcess = () async {
        var newEmployee = Employee(id: employee.id, name: nameController.text);
        await database.updateEmployee(newEmployee);
        Toast.show('更新されました。', context);
      };
    }

    return AlertDialog(
      title: Text(titleText),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('名前：'),
            Container(
              padding: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'スタッフ名を入力',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () =>
                        WidgetsBinding.instance.addPostFrameCallback(
                      (_) => nameController.clear(),
                    ),
                  ),
                ),
              ),
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
          onPressed: () async {
            // 未入力チェック
            if (nameController.text.isEmpty) {
              Toast.show('未入力項目があります', context);
              return;
            }
            // 更新or追加処理
            await databaseProcess();
            // 画面を閉じる
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
