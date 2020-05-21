import 'package:customermanagementapp/data/visit_reason_data.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/my_divider.dart';
import 'package:flutter/material.dart';

class NewVisitorBreakDownContent extends StatelessWidget {
  NewVisitorBreakDownContent({
    @required this.vhList,
  });

  final List<VisitHistory> vhList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MyDivider(),
        Column(
          children: List.generate(
            visitReasonData.length,
            (index) {
              final visitReason = visitReasonData[index];
              final numOfVisitors =
                  vhList.getDataByVisitReason(visitReason).length;
              return Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${visitReasonData[index]}',
                      style: TextStyle(
                        color: numOfVisitors == 0 ? Colors.grey.shade300 : null,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${vhList.getDataByVisitReason(visitReason).length}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: numOfVisitors == 0 ? Colors.grey.shade300 : null,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${vhList.getDataByVisitReason(visitReason).toSumPriceList().getSum().toPriceString()}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: numOfVisitors == 0 ? Colors.grey.shade300 : null,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
