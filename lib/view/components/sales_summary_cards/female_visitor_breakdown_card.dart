import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/sales_summary_cards/expandable_breakdown_card.dart';
import 'package:flutter/material.dart';

class FemaleBreakDownCard extends StatelessWidget {
  FemaleBreakDownCard({
    @required this.vhData,
    @required this.isExpanded,
    @required this.onExpandButtonTap,
  });

  final Map<String, List<VisitHistory>> vhData;
  final VoidCallback onExpandButtonTap;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final List<VisitHistory> allFemaleVisitors = vhData.toAllVisitHistories();
    return ExpandableBreakDownCard(
      title: '女性客内訳',
      isExpanded: isExpanded,
      onExpandButtonTap: onExpandButtonTap,
      isEnable: allFemaleVisitors.isNotEmpty,
      dataMap: {
        '新規': vhData['new'],
        'ワンリピ': vhData['one'],
        '通常リピ': vhData['other'],
      },
      colorList: [
        ConvertFromColor.fromHex('#f4ccd9'),
        ConvertFromColor.fromHex('#edabc2'),
        ConvertFromColor.fromHex('#e382a2'),
      ],
    );
  }
}
