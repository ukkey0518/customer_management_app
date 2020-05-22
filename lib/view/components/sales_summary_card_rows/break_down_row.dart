import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class BreakDownRow extends StatelessWidget {
  BreakDownRow({
    @required this.title,
    @required this.vhList,
  });

  final String title;
  final List<VisitHistory> vhList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            title,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '${vhList.length} 人',
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '${vhList.toSumPriceList().getSum().toPriceString()}',
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
