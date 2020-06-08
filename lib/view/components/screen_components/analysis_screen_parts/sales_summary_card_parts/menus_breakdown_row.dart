import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';

class MenusBreakDownRow extends StatelessWidget {
  MenusBreakDownRow({
    @required this.title,
    @required this.menuList,
    @required this.textColor,
  });

  final String title;
  final Color textColor;
  final List<Menu> menuList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '■',
                  style: TextStyle(
                    color: menuList.isEmpty ? Colors.grey.shade300 : textColor,
                  ),
                ),
                TextSpan(
                  text: title,
                  style: TextStyle(
                    color: menuList.isEmpty ? Colors.grey.shade300 : null,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '${menuList.length} 件',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: menuList.isEmpty ? Colors.grey.shade300 : null,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '${menuList.toSumPrice().toPriceString()}',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: menuList.isEmpty ? Colors.grey.shade300 : null,
            ),
          ),
        ),
      ],
    );
  }
}
