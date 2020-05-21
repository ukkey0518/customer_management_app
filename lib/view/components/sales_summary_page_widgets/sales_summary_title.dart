import 'package:flutter/material.dart';

class SalesSummaryTitlePart extends StatelessWidget {
  SalesSummaryTitlePart({
    @required this.title,
    @required this.isExpanded,
    @required this.onExpandChanged,
  });

  final String title;
  final bool isExpanded;
  final VoidCallback onExpandChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.left,
        ),
        IconButton(
          icon: isExpanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
          onPressed: () => onExpandChanged(),
        ),
      ],
    );
  }
}
