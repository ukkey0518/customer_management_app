import 'package:flutter/material.dart';

class NarrowSettingDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('絞り込みの設定'),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
