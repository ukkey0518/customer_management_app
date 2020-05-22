import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/my_divider.dart';
import 'package:customermanagementapp/view/components/sales_summary_card_rows/average_row.dart';
import 'package:customermanagementapp/view/components/sales_summary_card_rows/break_down_row.dart';
import 'package:customermanagementapp/view/components/sales_summary_card_rows/heading_row.dart';
import 'package:customermanagementapp/view/components/sales_summary_parts/expandable_card_title.dart';
import 'package:flutter/material.dart';

class ExpandableBreakDownCard extends StatelessWidget {
  ExpandableBreakDownCard({
    @required this.title,
    @required this.dataMap,
    @required this.isExpanded,
    @required this.onExpandButtonTap,
    this.isEnable = true,
  });

  final String title;
  final bool isExpanded;
  final VoidCallback onExpandButtonTap;
  final Map<String, List<VisitHistory>> dataMap;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    final dataEntry = dataMap.entries.toList();
    final allData = dataMap.values.reduce((v, e) {
      return e.isNotEmpty ? (v..addAll(e)) : v;
    }).toList();

    return Card(
      child: Container(
        padding: EdgeInsets.all(4),
        child: Column(
          children: <Widget>[
            ExpandableCardTitle(
              title: title,
              isExpanded: isExpanded,
              onExpandButtonTap: onExpandButtonTap,
              isEnable: isEnable,
            ),
            isExpanded
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        HeadingRow(),
                        MyDivider(),
                        Column(
                          children: List.generate(dataEntry.length, (index) {
                            return BreakDownRow(
                              title: dataEntry[index].key,
                              vhList: dataEntry[index].value,
                            );
                          }),
                        ),
                        MyDivider(),
                        AverageRow(
                          vhList: allData,
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
