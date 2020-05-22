import 'package:customermanagementapp/view/components/sales_summary_card_rows/heading_row.dart';
import 'package:flutter/material.dart';

class FixedBreakDownCard extends StatelessWidget {
  FixedBreakDownCard({
    @required this.title,
    @required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.left,
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                HeadingRow(

                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
