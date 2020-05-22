import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/my_divider.dart';
import 'package:customermanagementapp/view/components/sales_summary_card_rows/break_down_row.dart';
import 'package:customermanagementapp/view/components/sales_summary_card_rows/heading_row.dart';
import 'package:flutter/material.dart';

class FixedBreakDownCard extends StatelessWidget {
  FixedBreakDownCard({
    @required this.title,
    @required this.dataMap,
  });

  final String title;
  final Map<String, List<VisitHistory>> dataMap;

  @override
  Widget build(BuildContext context) {
    final dataEntry = dataMap.entries.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.left,
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                HeadingRow(),
                MyDivider(),
                Column(
                  children: List.generate(dataEntry.length, (index) {
                    final entry = dataEntry[index];
                    return BreakDownRow(
                      title: entry.key,
                      vhList: entry.value,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
