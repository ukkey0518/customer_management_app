import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/my_divider.dart';
import 'package:flutter/material.dart';

class RepeaterBreakDownContent extends StatelessWidget {
  RepeaterBreakDownContent({
    @required this.within1MonthRepeaters,
    @required this.within3MonthRepeaters,
    @required this.more4MonthRepeaters,
  });

  final List<VisitHistory> within1MonthRepeaters;
  final List<VisitHistory> within3MonthRepeaters;
  final List<VisitHistory> more4MonthRepeaters;

  @override
  Widget build(BuildContext context) {
    final int numOfRepeaterWithin1Month = within1MonthRepeaters.length;
    final int numOfRepeaterWithin3Month = within3MonthRepeaters.length;
    final int numOfRepeaterMore4Month = more4MonthRepeaters.length;
    final int totalPriceWithin1Month =
        within1MonthRepeaters.toSumPriceList().getSum();
    final int totalPriceWithin3Month =
        within3MonthRepeaters.toSumPriceList().getSum();
    final int totalPriceMore4Month =
        more4MonthRepeaters.toSumPriceList().getSum();

    return Column(
      children: <Widget>[
        MyDivider(),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    '1ヶ月以内',
                    style: TextStyle(
                      color: numOfRepeaterWithin1Month == 0
                          ? Colors.grey.shade300
                          : null,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '$numOfRepeaterWithin1Month',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: numOfRepeaterWithin1Month == 0
                          ? Colors.grey.shade300
                          : null,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '${totalPriceWithin1Month.toPriceString()}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: numOfRepeaterWithin1Month == 0
                          ? Colors.grey.shade300
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    '3ヶ月以内',
                    style: TextStyle(
                      color: numOfRepeaterWithin3Month == 0
                          ? Colors.grey.shade300
                          : null,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '$numOfRepeaterWithin3Month',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: numOfRepeaterWithin3Month == 0
                          ? Colors.grey.shade300
                          : null,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '${totalPriceWithin3Month.toPriceString()}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: numOfRepeaterWithin3Month == 0
                          ? Colors.grey.shade300
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    '4ヶ月以上',
                    style: TextStyle(
                      color: numOfRepeaterMore4Month == 0
                          ? Colors.grey.shade300
                          : null,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '$numOfRepeaterMore4Month',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: numOfRepeaterMore4Month == 0
                          ? Colors.grey.shade300
                          : null,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '${totalPriceMore4Month.toPriceString()}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: numOfRepeaterMore4Month == 0
                          ? Colors.grey.shade300
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
