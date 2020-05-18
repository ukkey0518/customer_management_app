import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:flutter/material.dart';

class PeriodModeIndicator extends StatelessWidget {
  PeriodModeIndicator({@required this.mode});

  final PeriodMode mode;

  @override
  Widget build(BuildContext context) {
    var text;

    switch (mode) {
      case PeriodMode.YEAR:
        text = '年 別 集 計';
        break;
      case PeriodMode.MONTH:
        text = '月 別 集 計';
        break;
      case PeriodMode.DAY:
        text = '日 別 集 計';
        break;
    }

    return Row(
      children: <Widget>[
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Theme.of(context).primaryColorLight,
              ),
              child: Text(
                text,
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
            ),
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }
}
