import 'package:flutter/material.dart';

class SeparatedColumn extends StatelessWidget {
  SeparatedColumn({
    @required this.children,
    @required this.separatorBuilder,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.showTopDivider = true,
    this.showBottomDivider = true,
  });

  final List<Widget> children;
  final WidgetBuilder separatorBuilder;
  final CrossAxisAlignment crossAxisAlignment;
  final bool showTopDivider;
  final bool showBottomDivider;

  @override
  Widget build(BuildContext context) {
    final divider = separatorBuilder(context);

    final contents = List<Widget>.generate(children.length, (index) {
      return Column(
        children: <Widget>[
          divider,
          children[index],
          index == children.length - 1 ? divider : Container(),
        ],
      );
    });

    final firstDivider = showTopDivider ? divider : Container();
    final bottomDivider = showBottomDivider ? divider : Container();

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: <Widget>[firstDivider]
        ..addAll(contents)
        ..add(bottomDivider),
    );
  }
}
