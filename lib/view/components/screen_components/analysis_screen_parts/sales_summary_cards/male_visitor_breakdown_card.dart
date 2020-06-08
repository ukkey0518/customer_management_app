import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/screen_components/analysis_screen_parts/sales_summary_cards/expandable_breakdown_card.dart';
import 'package:flutter/material.dart';

class MaleVisitorBreakDownCard extends StatelessWidget {
  MaleVisitorBreakDownCard({
    @required this.vhData,
    @required this.isExpanded,
    @required this.onExpandButtonTap,
  });

  final Map<String, List<VisitHistory>> vhData;
  final VoidCallback onExpandButtonTap;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final List<VisitHistory> allMaleVisitors = vhData.toAllVisitHistories();

    return ExpandableBreakDownCard(
      title: '男性客内訳',
      isExpanded: isExpanded,
      onExpandButtonTap: onExpandButtonTap,
      isEnable: allMaleVisitors.isNotEmpty,
      dataMap: {
        '新規': vhData['new'],
        'ワンリピ': vhData['one'],
        '通常リピ': vhData['other'],
      },
      colorList: [
        ConvertFromColor.fromHex('#79ffff'),
        ConvertFromColor.fromHex('#5ad6fa'),
        ConvertFromColor.fromHex('#00acff'),
      ],
    );
  }
}
