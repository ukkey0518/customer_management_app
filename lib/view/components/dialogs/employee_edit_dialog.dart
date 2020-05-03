import 'package:customermanagementapp/data/input_field_style.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/dialogs/dialog_title_text.dart';
import 'package:customermanagementapp/view/components/input_widgets/input_field.dart';
import 'package:flutter/material.dart';

class EmployeeEditDialog extends StatelessWidget {
  EmployeeEditDialog({this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    var titleText;
    var controller = TextEditingController();
    var positiveButtonText;

    var errorText;

    if (employee == null) {
      titleText = 'スタッフ情報登録';
      controller.text = '';
      positiveButtonText = '追加';
    } else {
      titleText = 'スタッフ情報編集';
      controller.text = employee.name;
      positiveButtonText = '更新';
    }

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: DialogTitleText(titleText),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('名前：'),
                InputField(
                  controller: controller,
                  errorText: errorText,
                  hintText: 'スタッフ名を入力',
                  style: InputFieldStyle.ROUNDED_RECTANGLE,
                  isClearable: true,
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
              onPressed: () {
                // 未入力チェック
                errorText = controller.text.isEmpty ? '未入力項目があります' : null;

                setState(() {});

                if (errorText != null) return;

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
      },
    );
  }
}
