import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class PeriodSelectTile extends StatelessWidget {
  PeriodSelectTile({
    @required this.date,
    @required this.mode,
    @required this.maxDate,
    @required this.minDate,
    @required this.onBackTap,
    @required this.onForwardTap,
    @required this.onDateAreaTap,
    @required this.forwardText,
    @required this.backText,
  });

  final DateTime date;
  final PeriodMode mode;
  final DateTime maxDate;
  final DateTime minDate;
  final ValueChanged<PeriodMode> onBackTap;
  final ValueChanged<PeriodMode> onForwardTap;
  final VoidCallback onDateAreaTap;
  final String forwardText;
  final String backText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: checkMinDate() ? null : () => onBackTap(mode),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.chevron_left,
                        color: checkMinDate()
                            ? Colors.grey
                            : Theme.of(context).primaryColor,
                      ),
                      Text(
                        backText,
                        style: TextStyle(
                          fontSize: 16,
                          color: checkMinDate()
                              ? Colors.grey
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () => onDateAreaTap(),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    '${date?.toPeriodStr(mode)}',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: checkMaxDate() ? null : () => onForwardTap(mode),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        forwardText,
                        style: TextStyle(
                          fontSize: 16,
                          color: checkMaxDate()
                              ? Colors.grey
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: checkMaxDate()
                            ? Colors.grey
                            : Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool checkMinDate() {
    var flag = false;
    switch (mode) {
      case PeriodMode.YEAR:
        flag = date?.year == minDate?.year;
        break;
      case PeriodMode.MONTH:
        flag = date?.year == minDate?.year && date?.month == minDate?.month;
        break;
      case PeriodMode.DAY:
        flag = date?.year == minDate?.year &&
            date?.month == minDate?.month &&
            date?.day == minDate?.day;
        break;
    }
    return flag;
  }

  bool checkMaxDate() {
    var flag = false;
    switch (mode) {
      case PeriodMode.YEAR:
        flag = date?.year == maxDate?.year;
        break;
      case PeriodMode.MONTH:
        flag = date?.year == maxDate?.year && date?.month == maxDate?.month;
        break;
      case PeriodMode.DAY:
        flag = date?.year == maxDate?.year &&
            date?.month == maxDate?.month &&
            date?.day == maxDate?.day;
        break;
    }
    return flag;
  }
}
