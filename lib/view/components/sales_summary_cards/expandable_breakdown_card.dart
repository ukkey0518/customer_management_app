import 'package:customermanagementapp/view/components/sales_summary_parts/expandable_card_title.dart';
import 'package:flutter/material.dart';

class ExpandableBreakDownCard extends StatelessWidget {
  ExpandableBreakDownCard({
    @required this.title,
    @required this.children,
    @required this.isExpanded,
    @required this.onExpandButtonTap,
    this.isEnable = true,
  });

  final String title;
  final bool isExpanded;
  final VoidCallback onExpandButtonTap;
  final List<Widget> children;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(4),
        child: Column(
          children: <Widget>[
            ExpandableCardTitle(
              title: title,
              isExpanded: isExpanded,
              onExpandButtonTap: onExpandButtonTap,
              isEnable: isEnable,
            ),
            isExpanded
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: children,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
