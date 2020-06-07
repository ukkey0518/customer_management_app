import 'package:flutter/material.dart';

class SettingListTile extends StatelessWidget {
  SettingListTile({
    @required this.text,
    @required this.screen,
  });

  final String text;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding:
              EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 8),
          leading: Icon(Icons.settings),
          trailing: Icon(Icons.chevron_right),
          title: Text(text),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => screen),
            );
          },
        ),
        Divider(height: 1),
      ],
    );
  }
}
