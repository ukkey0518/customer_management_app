import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/my_divider.dart';
import 'package:customermanagementapp/view/components/sales_summary_page_widgets/new_visitor_breakdown_content.dart';
import 'package:customermanagementapp/view/components/sales_summary_page_widgets/sales_summary_average_part.dart';
import 'package:customermanagementapp/view/components/sales_summary_page_widgets/sales_summary_heading_part.dart';
import 'package:customermanagementapp/view/components/sales_summary_page_widgets/sales_summary_title.dart';
import 'package:customermanagementapp/view/components/sales_summary_page_widgets/sales_summary_total_part.dart';
import 'package:flutter/material.dart';

class SSPNewVisitorsBreakDownPart extends StatelessWidget {
  SSPNewVisitorsBreakDownPart({
    @required this.vhList,
    @required this.onExpandChanged,
    @required this.isExpanded,
  });

  final List<VisitHistory> vhList;
  final VoidCallback onExpandChanged;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SalesSummaryTitlePart(
          title: '新規内訳',
          isExpanded: isExpanded,
          onExpandChanged: onExpandChanged,
        ),
        Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                SalesSummaryHeadingPart(
                  title: '来店動機',
                  isExpanded: isExpanded,
                ),
                NewVisitorBreakDownContent(
                  vhList: vhList,
                  isExpanded: isExpanded,
                ),
                MyDivider(),
                SalesSummaryTotalPart(
                  vhList: vhList,
                ),
                SalesSummaryAveragePart(
                  vhList: vhList,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
