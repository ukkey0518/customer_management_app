import 'package:flutter/material.dart';

class RoundedRectangleContainer extends StatelessWidget {
  RoundedRectangleContainer({
    @required this.child,
    this.radius = 8.0,
    this.color,
    this.borderColor,
    this.borderWidth = 1.0,
    this.height,
    this.width,
    this.padding,
    this.onTap,
    this.onLongPress,
  })  : assert(radius != null),
        assert(borderWidth != null);

  final Widget child;
  final double radius;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final double height;
  final double width;
  final EdgeInsets padding;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          border: Border.all(color: borderColor, width: borderWidth),
          color: color,
        ),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
            ),
            onTap: onTap,
            onLongPress: onLongPress,
            child: Container(
              alignment: Alignment.center,
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
