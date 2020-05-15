import 'package:customermanagementapp/data/enums/input_field_style.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/dialogs/dialog_title_text.dart';
import 'package:customermanagementapp/view/components/input_widgets/text_input_field.dart';
import 'package:flutter/material.dart';

class VisitReasonEditDialog extends StatelessWidget {
  VisitReasonEditDialog({
    @required this.visitReason,
  });

  final VisitReason visitReason;

  @override
  Widget build(BuildContext context) {
    var titleText;
    var controller = TextEditingController();
    var positiveButtonText;

    var errorText;

    if (visitReason == null) {
      titleText = '来店動機登録';
      controller.text = '';
      positiveButtonText = '追加';
    } else {
      titleText = '来店動機編集';
      controller.text = visitReason.reason;
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
                Text('来店理由：'),
                TextInputField(
                  controller: controller,
                  errorText: errorText,
                  hintText: '来店動機を入力',
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

                final newVisitReason = VisitReason(
                  id: visitReason?.id,
                  reason: controller.text,
                );

                // 画面を閉じる
                Navigator.of(context).pop(newVisitReason);
              },
            )
          ],
        );
      },
    );
  }
}
