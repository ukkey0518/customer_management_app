import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class AverageRow extends StatelessWidget {
  AverageRow({
    @required this.vhList,
  });

  final List<VisitHistory> vhList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            '平均単価',
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '${vhList.toSumPriceList().getAverage().toPriceString(1)}',
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
