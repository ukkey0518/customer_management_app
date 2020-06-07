import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:customermanagementapp/view/components/input_widgets/day_select_tile.dart';
import 'package:customermanagementapp/view/components/input_widgets/month_select_tile.dart';
import 'package:customermanagementapp/view/components/input_widgets/year_select_tile.dart';
import 'package:flutter/material.dart';

class DateSelectTilesByPeriod extends StatelessWidget {
  DateSelectTilesByPeriod({
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
          ..add(YearSelectTile(
            date: date,
            maxDate: maxDate,
            minDate: minDate,
            increment: (mode) => increment(mode),
            decrement: (mode) => decrement(mode),
          ));
        break;
      case PeriodMode.MONTH:
        widgetList
          ..add(YearSelectTile(
            date: date,
            maxDate: maxDate,
            minDate: minDate,
            increment: (mode) => increment(mode),
            decrement: (mode) => decrement(mode),
          ))
          ..add(SizedBox(height: 8))
          ..add(MonthSelectTile(
            date: date,
            maxDate: maxDate,
            minDate: minDate,
            increment: (mode) => increment(mode),
            decrement: (mode) => decrement(mode),
          ));
        break;
      case PeriodMode.DAY:
        widgetList
          ..add(YearSelectTile(
            date: date,
            maxDate: maxDate,
            minDate: minDate,
            increment: (mode) => increment(mode),
            decrement: (mode) => decrement(mode),
          ))
          ..add(SizedBox(height: 8))
          ..add(MonthSelectTile(
            date: date,
            maxDate: maxDate,
            minDate: minDate,
            increment: (mode) => increment(mode),
            decrement: (mode) => decrement(mode),
          ))
          ..add(SizedBox(height: 8))
          ..add(DaySelectTile(
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
