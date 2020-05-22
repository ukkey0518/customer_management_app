import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class BreakDownRow extends StatelessWidget {
  BreakDownRow({
    @required this.title,
    @required this.textColor,
    @required this.vhList,
  });

  final String title;
  final Color textColor;
  final List<VisitHistory> vhList;

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
                    color: vhList.isEmpty ? Colors.grey.shade300 : textColor,
                  ),
                ),
                TextSpan(
                  text: title,
                  style: TextStyle(
                    color: vhList.isEmpty ? Colors.grey.shade300 : null,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '${vhList.length} 人',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: vhList.isEmpty ? Colors.grey.shade300 : null,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '${vhList.toSumPriceList().getSum().toPriceString()}',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: vhList.isEmpty ? Colors.grey.shade300 : null,
            ),
          ),
        ),
      ],
    );
  }
}
