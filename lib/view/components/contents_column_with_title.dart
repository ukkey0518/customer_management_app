import 'package:customermanagementapp/view/components/my_divider.dart';
import 'package:flutter/material.dart';

class ContentsColumnWithTitle extends StatelessWidget {
  ContentsColumnWithTitle({
    this.title,
    this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(title, style: TextStyle(fontSize: 20)),
        ),
        Column(
          children: List.generate(children.length, (index) {
            return Column(
              children: <Widget>[
                MyDivider(indent: 8),
                children[index],
              ],
            );
          }),
        ),
      ],
    );
  }
}
