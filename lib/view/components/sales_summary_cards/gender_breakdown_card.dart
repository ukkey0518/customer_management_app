import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/sales_summary_cards/fixed_breakdown_card.dart';
import 'package:flutter/material.dart';

class GenderBreakDownCard extends StatelessWidget {
  GenderBreakDownCard(
      {@required this.maleVisitorsData, @required this.femaleVisitorsData});

  final Map<String, List<VisitHistory>> maleVisitorsData;
  final Map<String, List<VisitHistory>> femaleVisitorsData;

  @override
  Widget build(BuildContext context) {
    final List<VisitHistory> maleVisitors =
        maleVisitorsData.values.reduce((v, e) {
      return e.isNotEmpty ? (v..addAll(e)) : v;
    }).toList();

    final List<VisitHistory> femaleVisitors =
        femaleVisitorsData.values.reduce((v, e) {
      return e.isNotEmpty ? (v..addAll(e)) : v;
    }).toList();

    return FixedBreakDownCard(
      dataMap: {
        '男性客': maleVisitors,
        '女性客': femaleVisitors,
      },
      colorList: [
        Colors.lightBlueAccent,
        Colors.pinkAccent,
      ],
    );
  }
}
