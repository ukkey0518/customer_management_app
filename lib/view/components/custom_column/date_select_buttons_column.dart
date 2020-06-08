import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:customermanagementapp/view/components/buttons/day_select_button.dart';
import 'package:customermanagementapp/view/components/buttons/month_select_button.dart';
import 'package:customermanagementapp/view/components/buttons/year_select_button.dart';
import 'package:flutter/material.dart';

class DateSelectButtonsColumn extends StatelessWidget {
  DateSelectButtonsColumn({
    this.mode,
    this.date,
    this.maxDate,
    this.minDate,
    this.increment,
    this.decrement,
  });

  final PeriodMode mode;
  final DateTime date;
  final DateTime maxDate;
  final DateTime minDate;
  final ValueChanged<PeriodMode> increment;
  final ValueChanged<PeriodMode> decrement;

  @override
  Widget build(BuildContext context) {
    var widgetList = List<Widget>();

    switch (mode) {
      case PeriodMode.YEAR:
        widgetList
          ..add(YearSelectButton(
            date: date,
            maxDate: maxDate,
            minDate: minDate,
            increment: (mode) => increment(mode),
            decrement: (mode) => decrement(mode),
          ));
        break;
      case PeriodMode.MONTH:
        widgetList
          ..add(YearSelectButton(
            date: date,
            maxDate: maxDate,
            minDate: minDate,
            increment: (mode) => increment(mode),
            decrement: (mode) => decrement(mode),
          ))
          ..add(SizedBox(height: 8))
          ..add(MonthSelectButton(
            date: date,
            maxDate: maxDate,
            minDate: minDate,
            increment: (mode) => increment(mode),
            decrement: (mode) => decrement(mode),
          ));
        break;
      case PeriodMode.DAY:
        widgetList
          ..add(YearSelectButton(
            date: date,
            maxDate: maxDate,
            minDate: minDate,
            increment: (mode) => increment(mode),
            decrement: (mode) => decrement(mode),
          ))
          ..add(SizedBox(height: 8))
          ..add(MonthSelectButton(
            date: date,
            maxDate: maxDate,
            minDate: minDate,
            increment: (mode) => increment(mode),
            decrement: (mode) => decrement(mode),
          ))
          ..add(SizedBox(height: 8))
          ..add(DaySelectButton(
            date: date,
            maxDate: maxDate,
            minDate: minDate,
            increment: (mode) => increment(mode),
            decrement: (mode) => decrement(mode),
          ));
        break;
    }

    return Container(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgetList,
        ),
      ),
    );
  }
}
