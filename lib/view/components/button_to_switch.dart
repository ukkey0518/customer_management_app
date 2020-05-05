import 'package:flutter/material.dart';

class ButtonToSwitch extends StatelessWidget {
  ButtonToSwitch({
    @required this.switchFlag,
    @required this.trueButton,
    @required this.falseButton,
  });

  final bool switchFlag;
  final IconButton trueButton;
  final IconButton falseButton;

  @override
  Widget build(BuildContext context) {
    return switchFlag ? trueButton : falseButton;
  }
}
