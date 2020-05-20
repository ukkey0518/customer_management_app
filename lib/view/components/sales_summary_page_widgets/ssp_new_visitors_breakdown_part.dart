import 'package:customermanagementapp/data/visit_reason_data.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/my_divider.dart';
import 'package:flutter/material.dart';

class SSPNewVisitorsBreakDownPart extends StatelessWidget {
  SSPNewVisitorsBreakDownPart({
    @required this.vhList,
    @required this.onExpandChanged,
    @required this.isExpanded,
  });

  final List<VisitHistory> vhList;
  final VoidCallback onExpandChanged;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              '新規内訳',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            ),
            IconButton(
              icon: isExpanded
                  ? Icon(Icons.expand_less)
                  : Icon(Icons.expand_more),
              onPressed: () => onExpandChanged(),
            ),
          ],
        ),
        Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        isExpanded ? '来店理由' : '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '人数',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '金額',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: isExpanded ? null : 0,
                  child: Column(
                    children: <Widget>[
                      MyDivider(),
                      Column(
                        children:
                            List.generate(visitReasonData.length, (index) {
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
                                    color: numOfVisitors == 0
                                        ? Colors.grey.shade300
                                        : null,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '${vhList.getDataByVisitReason(visitReason).length}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: numOfVisitors == 0
                                        ? Colors.grey.shade300
                                        : null,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '${vhList.getDataByVisitReason(visitReason).toSumPriceList().getSum().toPriceString()}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: numOfVisitors == 0
                                        ? Colors.grey.shade300
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                MyDivider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        '新規合計',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${vhList.length} 人',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${vhList.toSumPriceList().getSum().toPriceString()}',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
