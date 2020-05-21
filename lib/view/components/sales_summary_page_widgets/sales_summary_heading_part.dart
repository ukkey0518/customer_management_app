import 'package:flutter/material.dart';

class SalesSummaryHeadingPart extends StatelessWidget {
  SalesSummaryHeadingPart({
    @required this.title,
    @required this.isExpanded,
  });

  final String title;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            isExpanded ? title : '',
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '人数',
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '金額',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
