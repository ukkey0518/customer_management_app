import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:customermanagementapp/view/components/custom_containers/rounded_rectangle_container.dart';
import 'package:flutter/material.dart';

class YearSelectTile extends StatelessWidget {
  YearSelectTile({
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
    final isPreviousDisable = date?.year == minDate.year;
    final isNextDisable = date?.year == maxDate.year;
    return RoundedRectangleContainer(
      borderColor: Theme.of(context).primaryColorLight,
      child: SizedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                '${date?.year} 年',
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
                        : () => decrement(PeriodMode.YEAR),
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
                        isNextDisable ? null : () => increment(PeriodMode.YEAR),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
