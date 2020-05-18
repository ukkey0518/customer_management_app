import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:flutter/material.dart';

class MonthSelectTile extends StatelessWidget {
  MonthSelectTile({
    this.date,
    this.maxDate,
    this.minDate,
    this.increment,
    this.decrement,
  });

  final DateTime date;
  final DateTime maxDate;
  final DateTime minDate;
  final ValueChanged<PeriodMode> increment;
  final ValueChanged<PeriodMode> decrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: FlatButton(
            child: Icon(Icons.chevron_left),
            onPressed:
                date?.year == minDate.year && date?.month == minDate.month
                    ? null
                    : () => decrement(PeriodMode.MONTH),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '${date?.month} 月',
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: FlatButton(
            child: Icon(Icons.chevron_right),
            onPressed:
                date?.year == maxDate.year && date?.month == maxDate.month
                    ? null
                    : () => increment(PeriodMode.MONTH),
          ),
        ),
      ],
    );
  }
}
