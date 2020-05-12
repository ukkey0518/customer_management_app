import 'package:customermanagementapp/view/components/dialogs/dialog_title_text.dart';
import 'package:flutter/material.dart';

class DeleteConfirmDialog extends StatelessWidget {
  DeleteConfirmDialog({this.deleteValue});
  final String deleteValue;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const DialogTitleText(
        '削除の確認',
        isConfirmDialog: true,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(deleteValue, style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('このデータを削除しますか？'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('キャンセル'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        FlatButton(
          child: Text('削除する'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
