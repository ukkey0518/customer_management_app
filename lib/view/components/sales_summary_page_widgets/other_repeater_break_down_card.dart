import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/my_divider.dart';
import 'package:customermanagementapp/view/components/sales_summary_page_widgets/repeater_breakdown_content.dart';
import 'package:customermanagementapp/view/components/sales_summary_page_widgets/sales_summary_average_part.dart';
import 'package:customermanagementapp/view/components/sales_summary_page_widgets/sales_summary_heading_part.dart';
import 'package:customermanagementapp/view/components/sales_summary_page_widgets/sales_summary_title.dart';
import 'package:customermanagementapp/view/components/sales_summary_page_widgets/sales_summary_total_part.dart';
import 'package:flutter/material.dart';

class OtherRepeaterBreakDownCard extends StatelessWidget {
  OtherRepeaterBreakDownCard({
    @required this.vhData,
    @required this.isExpanded,
    @required this.onExpandChanged,
  });

  final Map<String, List<VisitHistory>> vhData;
  final VoidCallback onExpandChanged;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final List<VisitHistory> allOneRepeater = vhData.values.reduce((v, e) {
      return e.isNotEmpty ? (v..addAll(e)) : v;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SalesSummaryTitlePart(
          title: '通常リピ内訳',
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
                    ? RepeaterBreakDownContent(
                        within1MonthRepeaters: vhData['1'],
                        within3MonthRepeaters: vhData['3'],
                        more4MonthRepeaters: vhData['more'],
                      )
                    : Container(),
                MyDivider(),
                SalesSummaryTotalPart(
                  title: '通常リピ合計',
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
