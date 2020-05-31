import 'package:flutter/material.dart';

class OnOffSwitchButton extends StatelessWidget {
  OnOffSwitchButton({
    @required this.text,
    @required this.isSetAnyNarrowData,
    @required this.onPressed,
  });

  final String text;
  final bool isSetAnyNarrowData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var flagText;
    var backgroundColor;
    var fontWeight;
    var offset;

    if (isSetAnyNarrowData) {
      flagText = 'あり';
      fontWeight = FontWeight.bold;
      backgroundColor = Theme.of(context).primaryColorLight;
      offset = Offset(0, 1);
    } else {
      flagText = 'なし';
      fontWeight = null;
      backgroundColor = const Color(0xffffffff);
      offset = Offset(0, 2);
    }

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Theme.of(context).primaryColor, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).primaryColor,
            offset: offset,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        child: Text.rich(
          TextSpan(children: <TextSpan>[
            TextSpan(
              text: '$text: ',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            TextSpan(
              text: flagText,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: fontWeight,
              ),
            ),
          ]),
        ),
        onTap: onPressed,
      ),
    );
  }
}
