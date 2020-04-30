import 'package:flutter/material.dart';

class UnsavedConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('ご注意ください'),
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
