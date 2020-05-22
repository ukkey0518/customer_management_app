import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/my_divider.dart';
import 'package:customermanagementapp/view/components/sales_summary_card_rows/break_down_row.dart';
import 'package:customermanagementapp/view/components/sales_summary_card_rows/heading_row.dart';
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
        oneRepeatersData.values.reduce((v, e) {
      return e.isNotEmpty ? (v..addAll(e)) : v;
    }).toList();

    final List<VisitHistory> otherRepeaters =
        otherRepeatersData.values.reduce((v, e) {
      return e.isNotEmpty ? (v..addAll(e)) : v;
    }).toList();

    return FixedBreakDownCard(
      title: '新規・リピート別',
      children: <Widget>[
        HeadingRow(),
        MyDivider(),
        BreakDownRow(
          title: '新規',
          vhList: newVisitors,
        ),
        BreakDownRow(
          title: 'ワンリピ',
          vhList: oneRepeaters,
        ),
        BreakDownRow(
          title: '通常リピ',
          vhList: otherRepeaters,
        ),
      ],
    );
  }
}
