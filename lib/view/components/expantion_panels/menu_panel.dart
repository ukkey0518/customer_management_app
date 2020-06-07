import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class MenuPanel extends StatelessWidget {
  MenuPanel({
    @required this.menu,
    this.onTap,
    this.onLongPress,
  });

  final Menu menu;
  final ValueChanged onTap;
  final ValueChanged onLongPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(height: 1),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(menu.name, style: TextStyle(fontSize: 16)),
                ),
                Text('${menu.price.toPriceString()}',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          onTap: () => onTap(menu),
          onLongPress: onLongPress != null ? () => onLongPress(menu) : null,
        ),
      ],
    );
  }
}
