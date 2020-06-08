import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/dividers/my_divider.dart';
import 'package:customermanagementapp/view/components/analysis_screen_parts/sales_summary_card_parts/heading_row.dart';
import 'package:customermanagementapp/view/components/analysis_screen_parts/sales_summary_card_parts/menus_breakdown_row.dart';
import 'package:customermanagementapp/view/components/analysis_screen_parts/sales_summary_card_parts/sales_summary_card_pie_chart.dart';
import 'package:flutter/material.dart';

class MenuListBreakDownCard extends StatelessWidget {
  MenuListBreakDownCard({
    @required this.menuData,
  });

  final Map<MenuCategory, List<Menu>> menuData;

  @override
  Widget build(BuildContext context) {
    final dataEntry = menuData.entries.toList();
    print(dataEntry);

    final numOfMenusDataMap = Map<String, double>.fromIterable(
      dataEntry,
      key: (entry) => entry.key.name,
      value: (entry) => entry.value.length.toDouble(),
    );

    print('nom: $numOfMenusDataMap');

    final priceDataMap = Map<String, double>.fromIterable(
      dataEntry,
      key: (entry) => entry.key.name,
      value: (entry) =>
          ConvertFromMenuList(entry.value).toSumPrice().toDouble(),
    );

    final colorList = List<Color>();
    dataEntry.forEach((entry) {
      colorList.add(Color(entry.key.color));
    });

    final isEmpty = numOfMenusDataMap.entries
            .reduce((v, e) => MapEntry('result', v.value + e.value))
            .value ==
        0.0;

    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            HeadingRow(),
            MyDivider(),
            Column(
              children: List.generate(dataEntry.length, (index) {
                final entry = dataEntry[index];
                return MenusBreakDownRow(
                  title: entry.key.name,
                  menuList: entry.value,
                  textColor: colorList[index],
                );
              }),
            ),
            SizedBox(height: 16),
            MyDivider(),
            SalesSummaryCardPieCharts(
              numberOfVisitorDataMap: numOfMenusDataMap,
              priceDataMap: priceDataMap,
              colorList: colorList,
              isEmpty: isEmpty,
            ),
          ],
        ),
      ),
    );
  }
}
