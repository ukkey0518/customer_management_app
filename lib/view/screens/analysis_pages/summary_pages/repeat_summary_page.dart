import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/analysis_screen_parts/sales_summary_cards/new_visitor_breakdown_card.dart';
import 'package:customermanagementapp/view/components/analysis_screen_parts/sales_summary_cards/one_repeater_breakdown_card.dart';
import 'package:customermanagementapp/view/components/analysis_screen_parts/sales_summary_cards/other_repeater_break_down_card.dart';
import 'package:customermanagementapp/view/components/analysis_screen_parts/sales_summary_cards/repeaters_breakdown_card.dart';
import 'package:flutter/material.dart';

class RepeatSummaryPage extends StatefulWidget {
  RepeatSummaryPage({
    @required this.allVisitHistories,
    @required this.vhList,
  });

  final List<VisitHistory> allVisitHistories;
  final List<VisitHistory> vhList;

  @override
  _RepeatSummaryPageState createState() => _RepeatSummaryPageState();
}

class _RepeatSummaryPageState extends State<RepeatSummaryPage> {
  bool isNewVisitorListExpand = false;
  bool isOneRepeaterListExpand = false;
  bool isOtherRepeaterListExpand = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          RepeatersBreakDownCard(
            newVisitors: widget.allVisitHistories.getNewVisitors(widget.vhList),
            oneRepeatersData:
                widget.allVisitHistories.getOneRepVisitors(widget.vhList),
            otherRepeatersData:
                widget.allVisitHistories.getOtherRepVisitors(widget.vhList),
          ),
          // 新規内訳
          NewVisitorBreakDownCard(
            vhList: widget.allVisitHistories.getNewVisitors(widget.vhList),
            isExpanded: isNewVisitorListExpand,
            onExpandButtonTap: () {
              setState(() {
                isNewVisitorListExpand = !isNewVisitorListExpand;
              });
            },
          ),
          // ワンリピ内訳
          OneRepeaterBreakDownCard(
            vhData: widget.allVisitHistories.getOneRepVisitors(widget.vhList),
            isExpanded: isOneRepeaterListExpand,
            onExpandButtonTap: () {
              setState(() {
                isOneRepeaterListExpand = !isOneRepeaterListExpand;
              });
            },
          ),
          // リピート内訳
          OtherRepeaterBreakDownCard(
            vhData: widget.allVisitHistories.getOtherRepVisitors(widget.vhList),
            isExpanded: isOtherRepeaterListExpand,
            onExpandButtonTap: () {
              setState(() {
                isOtherRepeaterListExpand = !isOtherRepeaterListExpand;
              });
            },
          ),
        ],
      ),
    );
  }
}
