import 'package:flutter/material.dart';

class DialogTitleText extends StatelessWidget {
  const DialogTitleText(
    this.text, {
    this.isConfirmDialog = false,
  });

  final String text;
  final bool isConfirmDialog;

  @override
  Widget build(BuildContext context) {
    var bgColor;
    var txColor;

    if (isConfirmDialog) {
      bgColor = Colors.yellow;
      txColor = Colors.red;
    } else {
      bgColor = Theme.of(context).primaryColorLight;
      txColor = Theme.of(context).textTheme.body1.color;
    }

    return Container(
      alignment: Alignment.center,
      height: 32,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: txColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
