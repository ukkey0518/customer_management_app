import 'package:flutter/material.dart';

class LineChartLabel extends StatelessWidget {
  LineChartLabel({
    @required this.text,
    @required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(text: '■', style: TextStyle(color: color)),
          TextSpan(text: text),
        ],
      ),
    );
  }
}
