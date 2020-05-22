import 'package:customermanagementapp/data/visit_reason_data.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/sales_summary_cards/expandable_breakdown_card.dart';
import 'package:flutter/material.dart';

class NewVisitorBreakDownCard extends StatelessWidget {
  NewVisitorBreakDownCard({
    @required this.vhList,
    @required this.onExpandButtonTap,
    @required this.isExpanded,
  });

  final List<VisitHistory> vhList;
  final VoidCallback onExpandButtonTap;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return ExpandableBreakDownCard(
      title: '新規内訳',
      isExpanded: isExpanded,
      onExpandButtonTap: onExpandButtonTap,
      isEnable: vhList.isNotEmpty,
      dataMap: Map<String, List<VisitHistory>>.fromIterable(
        visitReasonData.keys.toList(),
        key: (reason) => reason.toString(),
        value: (reason) => vhList.getDataByVisitReason(reason),
      ),
      colorList: visitReasonData.values.toList(),
    );
  }
}
