import 'package:auto_size_text/auto_size_text.dart';
import 'package:customermanagementapp/view/components/custom_containers/rounded_rectangle_container.dart';
import 'package:flutter/material.dart';

class OnOffSwitchButton extends StatelessWidget {
  OnOffSwitchButton({
    this.title = '',
    this.value = 'なし',
    @required this.isOn,
    @required this.onTap,
  });

  final String title;
  final String value;
  final bool isOn;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var backgroundColor;
    var fontWeight;

    if (isOn) {
      fontWeight = FontWeight.bold;
      backgroundColor = Theme.of(context).primaryColorLight;
    }

    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).textSelectionHandleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        RoundedRectangleContainer(
          color: backgroundColor,
          borderColor: Theme.of(context).primaryColor,
          borderWidth: 1.6,
          radius: 16,
          width: 120,
          height: 40,
          onTap: onTap,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: AutoSizeText(
            value,
            maxLines: 1,
            minFontSize: 12,
            maxFontSize: 16,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ],
    );
  }
}
