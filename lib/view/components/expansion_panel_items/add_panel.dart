import 'package:flutter/material.dart';

class ExpansionPanelAddPanel extends StatelessWidget {
  ExpansionPanelAddPanel({
    @required this.name,
    this.onTap,
  });

  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(height: 1),
        ListTile(
          title: Text('$nameを追加'),
          leading: Icon(Icons.add),
          onTap: onTap,
        ),
      ],
    );
  }
}
