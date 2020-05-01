import 'package:flutter/material.dart';

class SimpleTableItem extends StatelessWidget {
  SimpleTableItem({this.titleText, this.contentText});

  final String titleText;
  final String contentText;

  @override
  Widget build(BuildContext context) {
    var titleStyle = TextStyle(fontSize: 12);
    var contentStyle = TextStyle(fontSize: 14);
    return Column(
      children: <Widget>[
        Text(titleText, style: titleStyle),
        SizedBox(height: 4),
        Text(contentText, style: contentStyle),
      ],
    );
  }
}
