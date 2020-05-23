import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/sales_summary_cards/fixed_breakdown_card.dart';
import 'package:flutter/material.dart';

class RepeatersBreakDownCard extends StatelessWidget {
  RepeatersBreakDownCard({
    @required this.newVisitors,
    @required this.oneRepeatersData,
    @required this.otherRepeatersData,
  });

  final List<VisitHistory> newVisitors;
  final Map<String, List<VisitHistory>> oneRepeatersData;
  final Map<String, List<VisitHistory>> otherRepeatersData;

  @override
  Widget build(BuildContext context) {
    final List<VisitHistory> oneRepeaters =
        oneRepeatersData.toAllVisitHistories();

    final List<VisitHistory> otherRepeaters =
        otherRepeatersData.toAllVisitHistories();

    return FixedBreakDownCard(
      dataMap: {
        '新規': newVisitors,
        'ワンリピ': oneRepeaters,
        '通常リピ': otherRepeaters,
      },
      colorList: [
        Colors.redAccent,
        Colors.greenAccent,
        Colors.blueAccent,
      ],
    );
  }
}
