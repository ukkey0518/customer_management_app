import 'package:flutter/material.dart';

class NarrowSwitchButton extends StatelessWidget {
  NarrowSwitchButton({
    @required this.isSetAnyNarrowData,
    @required this.onPressed,
  });

  final bool isSetAnyNarrowData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var text;
    var textColor;
    var fontWeight;
    if (isSetAnyNarrowData) {
      text = 'ON';
      fontWeight = FontWeight.bold;
      textColor = Colors.red;
    } else {
      text = 'OFF';
      fontWeight = null;
      textColor = Colors.black;
    }

    return RaisedButton(
      child: Text(
        '絞り込み：$text',
        style: TextStyle(
          color: textColor,
          fontWeight: fontWeight,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
