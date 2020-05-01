import 'package:customermanagementapp/view/components/dialogs/dialog_title_text.dart';
import 'package:flutter/material.dart';

class UnsavedConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const DialogTitleText(
        'ご注意ください',
        isConfirmDialog: true,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text('このまま画面を閉じると'),
            const Text('保存されていないデータは失われます。'),
            const Text('保存せずに終了しますか？'),
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
          child: Text('保存せずに閉じる'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
