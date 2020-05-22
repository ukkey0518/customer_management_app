import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/sales_summary_cards/expandable_breakdown_card.dart';
import 'package:flutter/material.dart';

class OtherRepeaterBreakDownCard extends StatelessWidget {
  OtherRepeaterBreakDownCard({
    @required this.vhData,
    @required this.isExpanded,
    @required this.onExpandButtonTap,
  });

  final Map<String, List<VisitHistory>> vhData;
  final VoidCallback onExpandButtonTap;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final List<VisitHistory> allOtherRepeater = vhData.values.reduce((v, e) {
      return e.isNotEmpty ? (v..addAll(e)) : v;
    }).toList();

    return ExpandableBreakDownCard(
      title: '通常リピ内訳',
      isExpanded: isExpanded,
      onExpandButtonTap: onExpandButtonTap,
      isEnable: allOtherRepeater.isNotEmpty,
      dataMap: {
        '１ヶ月以内': vhData['1'],
        '３ヶ月以内': vhData['3'],
        '４ヶ月以上': vhData['more'],
      },
      colorList: [
        ConvertFromColor.fromHex('#0086ad'),
        ConvertFromColor.fromHex('#68a5da'),
        ConvertFromColor.fromHex('#a2d7dd'),
      ],
    );
  }
}
