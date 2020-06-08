import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  MyDivider({this.indent, this.height = 8});

  final double indent;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      indent: indent,
      endIndent: indent,
    );
  }
}
