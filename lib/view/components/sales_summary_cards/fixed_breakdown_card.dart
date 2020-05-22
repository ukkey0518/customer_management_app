import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/convert_from_visit_history_list.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/my_divider.dart';
import 'package:customermanagementapp/view/components/sales_summary_card_parts/break_down_row.dart';
import 'package:customermanagementapp/view/components/sales_summary_card_parts/heading_row.dart';
import 'package:customermanagementapp/view/components/sales_summary_card_parts/sales_summary_card_pie_chart.dart';
import 'package:flutter/material.dart';

class FixedBreakDownCard extends StatelessWidget {
  FixedBreakDownCard({
    @required this.title,
    @required this.dataMap,
    @required this.colorList,
  });

  final String title;
  final Map<String, List<VisitHistory>> dataMap;
  final List<Color> colorList;

  @override
  Widget build(BuildContext context) {
    final dataEntry = dataMap.entries.toList();

    final numOfVisitorsDataMap = Map<String, double>.fromIterable(
      dataEntry,
      key: (entry) => entry.key,
      value: (entry) => entry.value.length.toDouble(),
    );

    final priceDataMap = Map<String, double>.fromIterable(
      dataEntry,
      key: (entry) => entry.key,
      value: (entry) => ConvertFromVisitHistoryList(entry.value)
          .toSumPriceList()
          .getSum()
          .toDouble(),
    );

    final isEmpty = numOfVisitorsDataMap.entries
            .reduce((v, e) => MapEntry('result', v.value + e.value))
            .value ==
        0.0;

    print('novDataMap: $numOfVisitorsDataMap');
    print('priDataMap: $priceDataMap');

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
                      textColor: colorList[index],
                    );
                  }),
                ),
                SizedBox(height: 16),
                MyDivider(),
                SalesSummaryCardPieCharts(
                  numberOfVisitorDataMap: numOfVisitorsDataMap,
                  priceDataMap: priceDataMap,
                  colorList: colorList,
                  isEmpty: isEmpty,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
