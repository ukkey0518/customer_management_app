import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:customermanagementapp/view/components/only_period_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DateSelectField extends StatelessWidget {
  DateSelectField({
    this.date,
    this.periodMode = PeriodMode.MONTH,
    this.onConfirm,
  });

  final DateTime date;
  final PeriodMode periodMode;
  final ValueChanged<DateTime> onConfirm;

  @override
  Widget build(BuildContext context) {
    var tilesList = List<Widget>();

    switch (periodMode) {
      case PeriodMode.YEAR:
        tilesList.add(Container());
        break;
      case PeriodMode.MONTH:
        tilesList.add(Container());
        tilesList.add(Container());
        break;
      case PeriodMode.DAY:
        tilesList.add(Container());
        tilesList.add(Container());
        tilesList.add(Container());
    }

    return Row(
      children: tilesList,
    );
  }
}
