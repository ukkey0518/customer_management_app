import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/my_divider.dart';
import 'package:customermanagementapp/view/components/sales_summary_page_widgets/one_repeater_breakdown_content.dart';
import 'package:customermanagementapp/view/components/sales_summary_page_widgets/sales_summary_average_part.dart';
import 'package:customermanagementapp/view/components/sales_summary_page_widgets/sales_summary_heading_part.dart';
import 'package:customermanagementapp/view/components/sales_summary_page_widgets/sales_summary_title.dart';
import 'package:customermanagementapp/view/components/sales_summary_page_widgets/sales_summary_total_part.dart';
import 'package:flutter/material.dart';

class OneRepeaterBreakDownCard extends StatelessWidget {
  OneRepeaterBreakDownCard({
    @required this.vhData,
    @required this.isExpanded,
    @required this.onExpandChanged,
  });

  final Map<String, List<VisitHistory>> vhData;
  final VoidCallback onExpandChanged;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final List<VisitHistory> allOneRepeater =
        vhData.values.reduce((v, e) => v..addAll(e)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SalesSummaryTitlePart(
          title: 'ワンリピ内訳',
          isExpanded: isExpanded,
          onExpandChanged: onExpandChanged,
        ),
        Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                SalesSummaryHeadingPart(
                  title: '',
                  isExpanded: isExpanded,
                ),
                isExpanded
                    ? OneRepeaterBreakDownContent(
                        within1MonthRepeaters: vhData['1'],
                        within3MonthRepeaters: vhData['3'],
                        more4MonthRepeaters: vhData['more'],
                      )
                    : Container(),
                MyDivider(),
                SalesSummaryTotalPart(
                  title: 'ワンリピ合計',
                  vhList: allOneRepeater,
                ),
                SalesSummaryAveragePart(
                  vhList: allOneRepeater,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
