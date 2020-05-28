import 'package:customermanagementapp/data/enums/date_format_mode.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/simple_table_item.dart';
import 'package:flutter/material.dart';

class CustomerInformationPanel extends StatelessWidget {
  CustomerInformationPanel({
    @required this.numberOfVisits,
    @required this.lastVisitDate,
    @required this.personInCharge,
  });

  final int numberOfVisits;
  final DateTime lastVisitDate;
  final Employee personInCharge;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            SimpleTableItem(
              titleText: '来店回数',
              contentText: numberOfVisits.toString(),
            ),
            SimpleTableItem(
              titleText: '最終来店日',
              contentText: lastVisitDate == null
                  ? '--'
                  : lastVisitDate.toFormatStr(DateFormatMode.FULL),
            ),
            SimpleTableItem(
              titleText: '担当',
              contentText: personInCharge == null ? '--' : personInCharge.name,
            ),
          ],
        ),
      ],
    );
  }
}
