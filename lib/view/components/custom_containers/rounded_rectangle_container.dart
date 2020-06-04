import 'package:flutter/material.dart';

class RoundedRectangleContainer extends StatelessWidget {
  const RoundedRectangleContainer({
    @required this.child,
    this.radius = 8.0,
    this.color,
    this.borderColor = Colors.grey,
    this.borderWidth = 1.0,
  })  : assert(radius != null),
        assert(borderWidth != null);

  final Widget child;
  final double radius;
  final Color color;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: borderColor, width: borderWidth),
        color: color,
      ),
      child: child,
    );
  }
}
