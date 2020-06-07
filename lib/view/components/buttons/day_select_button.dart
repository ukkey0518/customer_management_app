import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:customermanagementapp/view/components/custom_containers/rounded_rectangle_container.dart';
import 'package:flutter/material.dart';

class DaySelectButton extends StatelessWidget {
  DaySelectButton({
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
    final isPreviousDisable = date.year == minDate.year &&
        date.month == minDate.month &&
        date.day == minDate.day;
    final isNextDisable = date.year == maxDate.year &&
        date.month == maxDate.month &&
        date.day == maxDate.day;
    return RoundedRectangleContainer(
      borderColor: Theme.of(context).primaryColorLight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Text(
              '${date.day} 日',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.chevron_left,
                      color: isPreviousDisable
                          ? Colors.grey.shade300
                          : Theme.of(context).primaryColor,
                      size: 32,
                    ),
                  ),
                  onPressed: isPreviousDisable
                      ? null
                      : () => decrement(PeriodMode.DAY),
                ),
              ),
              Expanded(
                child: FlatButton(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.chevron_right,
                      color: isNextDisable
                          ? Colors.grey.shade300
                          : Theme.of(context).primaryColor,
                      size: 32,
                    ),
                  ),
                  onPressed:
                      isNextDisable ? null : () => increment(PeriodMode.DAY),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
