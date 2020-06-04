import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OnOffSwitchButton extends StatelessWidget {
  OnOffSwitchButton({
    this.title = '',
    this.value = 'なし',
    @required this.isSetAny,
    @required this.onTap,
  });

  final String title;
  final String value;
  final bool isSetAny;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var backgroundColor;
    var fontWeight;
    var offset;

    if (isSetAny) {
      fontWeight = FontWeight.bold;
      backgroundColor = Theme.of(context).primaryColorLight;
      offset = Offset(0, 0);
    } else {
      fontWeight = null;
      backgroundColor = const Color(0xffffffff);
      offset = Offset(0, 0);
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
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 1.6),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Theme.of(context).primaryColor,
                offset: offset,
              ),
            ],
          ),
          width: 120,
          height: 40,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: InkWell(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            ),
          ),
        ),
      ],
    );
  }
}
