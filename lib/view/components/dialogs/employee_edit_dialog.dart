import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class EmployeeEditDialog extends StatelessWidget {
  EmployeeEditDialog({this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    var titleText;
    var controller = TextEditingController();
    var positiveButtonText;

    if (employee == null) {
      titleText = 'スタッフ情報登録';
      controller.text = '';
      positiveButtonText = '追加';
    } else {
      titleText = 'スタッフ情報編集';
      controller.text = employee.name;
      positiveButtonText = '更新';
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
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'スタッフ名を入力',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () =>
                        WidgetsBinding.instance.addPostFrameCallback(
                      (_) => controller.clear(),
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
            if (controller.text.isEmpty) {
              Toast.show('未入力項目があります', context);
              return;
            }

            final newEmployee = Employee(
              id: employee?.id,
              name: controller.text,
            );

            // 画面を閉じる
            Navigator.of(context).pop(newEmployee);
          },
        )
      ],
    );
  }
}
