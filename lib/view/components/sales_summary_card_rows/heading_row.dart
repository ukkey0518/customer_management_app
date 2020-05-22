import 'package:flutter/material.dart';

class HeadingRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            '分類',
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '人数',
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '金額',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
