import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/sales_summary_cards/expandable_breakdown_card.dart';
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
      dataMap: {
        '１ヶ月以内': vhData['1'],
        '３ヶ月以内': vhData['3'],
        '４ヶ月以上': vhData['more'],
      },
    );
  }
}
