import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/my_divider.dart';
import 'package:customermanagementapp/view/components/sales_summary_card_rows/average_row.dart';
import 'package:customermanagementapp/view/components/sales_summary_card_rows/heading_row.dart';
import 'package:customermanagementapp/view/components/sales_summary_cards/expandable_breakdown_card.dart';
import 'package:customermanagementapp/view/components/sales_summary_parts/new_visitor_breakdown_content.dart';
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
      children: <Widget>[
        HeadingRow(
          title: '来店動機',
          isExpanded: isExpanded,
        ),
        isExpanded
            ? NewVisitorBreakDownContent(
                vhList: vhList,
              )
            : Container(),
        MyDivider(),
        AverageRow(
          vhList: vhList,
        ),
      ],
    );
  }
}
