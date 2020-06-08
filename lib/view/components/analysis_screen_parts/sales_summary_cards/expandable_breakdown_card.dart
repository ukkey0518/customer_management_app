import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/convert_from_visit_history_list.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/dividers/my_divider.dart';
import 'package:customermanagementapp/view/components/analysis_screen_parts/sales_summary_card_parts/average_row.dart';
import 'package:customermanagementapp/view/components/analysis_screen_parts/sales_summary_card_parts/break_down_row.dart';
import 'package:customermanagementapp/view/components/analysis_screen_parts/sales_summary_card_parts/heading_row.dart';
import 'package:customermanagementapp/view/components/analysis_screen_parts/sales_summary_card_parts/sales_summary_card_pie_chart.dart';
import 'package:customermanagementapp/view/components/analysis_screen_parts/sales_summary_parts/expandable_card_title.dart';
import 'package:flutter/material.dart';

class ExpandableBreakDownCard extends StatelessWidget {
  ExpandableBreakDownCard({
    @required this.title,
    @required this.dataMap,
    @required this.colorList,
    @required this.isExpanded,
    @required this.onExpandButtonTap,
    this.isEnable = true,
  });

  final String title;
  final Map<String, List<VisitHistory>> dataMap;
  final List<Color> colorList;
  final bool isExpanded;
  final VoidCallback onExpandButtonTap;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    final dataEntry = dataMap.entries.toList();

    final allData = dataMap.toAllVisitHistories();

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
    var expandFlag = isEmpty ? false : isExpanded;

    print('novDataMap: $numOfVisitorsDataMap');
    print('priDataMap: $priceDataMap');

    return Card(
      child: Container(
        padding: EdgeInsets.all(4),
        child: Column(
          children: <Widget>[
            ExpandableCardTitle(
              title: title,
              isExpanded: expandFlag,
              onExpandButtonTap: onExpandButtonTap,
              isEnable: isEnable,
            ),
            expandFlag
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
                        SizedBox(height: 16),
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
