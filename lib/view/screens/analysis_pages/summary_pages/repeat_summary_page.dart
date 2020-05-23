import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/sales_summary_cards/new_visitor_breakdown_card.dart';
import 'package:customermanagementapp/view/components/sales_summary_cards/one_repeater_breakdown_card.dart';
import 'package:customermanagementapp/view/components/sales_summary_cards/other_repeater_break_down_card.dart';
import 'package:customermanagementapp/view/components/sales_summary_cards/repeaters_breakdown_card.dart';
import 'package:flutter/material.dart';

class RepeatSummaryPage extends StatefulWidget {
  RepeatSummaryPage({
    @required this.allVisitHistory,
    @required this.vhList,
  });

  final List<VisitHistory> allVisitHistory;
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
            newVisitors: widget.allVisitHistory.getNewVisitors(widget.vhList),
            oneRepeatersData:
                widget.allVisitHistory.getOneRepVisitors(widget.vhList),
            otherRepeatersData:
                widget.allVisitHistory.getOtherRepVisitors(widget.vhList),
          ),
          // 新規内訳
          NewVisitorBreakDownCard(
            vhList: widget.allVisitHistory.getNewVisitors(widget.vhList),
            isExpanded: isNewVisitorListExpand,
            onExpandButtonTap: () {
              setState(() {
                isNewVisitorListExpand = !isNewVisitorListExpand;
              });
            },
          ),
          // ワンリピ内訳
          OneRepeaterBreakDownCard(
            vhData: widget.allVisitHistory.getOneRepVisitors(widget.vhList),
            isExpanded: isOneRepeaterListExpand,
            onExpandButtonTap: () {
              setState(() {
                isOneRepeaterListExpand = !isOneRepeaterListExpand;
              });
            },
          ),
          // リピート内訳
          OtherRepeaterBreakDownCard(
            vhData: widget.allVisitHistory.getOtherRepVisitors(widget.vhList),
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
