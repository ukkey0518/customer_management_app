import 'package:flutter/material.dart';

class ExpandableCardTitle extends StatelessWidget {
  ExpandableCardTitle({
    @required this.title,
    @required this.isExpanded,
    @required this.onExpandButtonTap,
    @required this.isEnable,
  });

  final String title;
  final bool isExpanded;
  final VoidCallback onExpandButtonTap;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: isEnable ? null : Colors.grey.shade400,
          ),
          textAlign: TextAlign.left,
        ),
        IconButton(
          icon: isExpanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
          onPressed: isEnable ? onExpandButtonTap : null,
        ),
      ],
    );
  }
}
