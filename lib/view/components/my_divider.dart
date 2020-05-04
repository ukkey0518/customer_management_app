import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  MyDivider({this.indent});

  final double indent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 8,
      indent: indent,
      endIndent: indent,
    );
  }
}
