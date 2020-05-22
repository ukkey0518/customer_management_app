import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/my_divider.dart';
import 'package:customermanagementapp/view/components/sales_summary_card_rows/average_row.dart';
import 'package:customermanagementapp/view/components/sales_summary_card_rows/heading_row.dart';
import 'package:customermanagementapp/view/components/sales_summary_cards/expandable_breakdown_card.dart';
import 'package:customermanagementapp/view/components/sales_summary_parts/repeater_breakdown_content.dart';
import 'package:flutter/material.dart';

class OneRepeaterBreakDownCard extends StatelessWidget {
  OneRepeaterBreakDownCard({
    @required this.vhData,
    @required this.isExpanded,
    @required this.onExpandButtonTap,
  });

  final Map<String, List<VisitHistory>> vhData;
  final VoidCallback onExpandButtonTap;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    print(vhData.values);
    final List<VisitHistory> allOneRepeater = vhData.values.reduce((v, e) {
      return e.isNotEmpty ? (v..addAll(e)) : v;
    }).toList();

    return ExpandableBreakDownCard(
      title: 'ワンリピ内訳',
      isExpanded: isExpanded,
      onExpandButtonTap: onExpandButtonTap,
      isEnable: allOneRepeater.isNotEmpty,
      children: <Widget>[
        HeadingRow(
          title: '',
          isExpanded: isExpanded,
        ),
        isExpanded
            ? RepeaterBreakDownContent(
                within1MonthRepeaters: vhData['1'],
                within3MonthRepeaters: vhData['3'],
                more4MonthRepeaters: vhData['more'],
              )
            : Container(),
        MyDivider(),
        AverageRow(
          vhList: allOneRepeater,
        ),
      ],
    );
  }
}
