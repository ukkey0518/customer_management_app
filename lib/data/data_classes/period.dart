import 'package:customermanagementapp/data/enums/period_select_mode.dart';

class Period {
  Period({DateTime date})
      : this.year = date?.year,
        this.month = date?.month,
        this.day = date?.day;

  int year;

  int month;

  int day;

  void clear() {
    year = null;
    month = null;
    day = null;
  }

  void increment(PeriodSelectMode selectMode) {
    final date = DateTime(year ?? 1, month ?? 1, day ?? 1);
    DateTime newDate;

    switch (selectMode) {
      case PeriodSelectMode.YEAR:
        newDate = DateTime(
          date.year + 1,
          date.month,
          date.day,
        );
        year = newDate.year;
        break;
      case PeriodSelectMode.MONTH:
        newDate = DateTime(
          date.year,
          date.month + 1,
          date.day,
        );
        year = newDate.year;
        month = newDate.month;
        break;
      case PeriodSelectMode.DAY:
        newDate = DateTime(
          date.year,
          date.month,
          date.day + 1,
        );
        year = newDate.year;
        month = newDate.month;
        day = newDate.day;
        break;
    }
  }

  void decrement(PeriodSelectMode selectMode) {
    final date = DateTime(year ?? 1, month ?? 1, day ?? 1);
    DateTime newDate;

    switch (selectMode) {
      case PeriodSelectMode.YEAR:
        newDate = DateTime(
          date.year - 1,
          date.month,
          date.day,
        );
        year = newDate.year;
        break;
      case PeriodSelectMode.MONTH:
        newDate = DateTime(
          date.year,
          date.month - 1,
          date.day,
        );
        year = newDate.year;
        month = newDate.month;
        break;
      case PeriodSelectMode.DAY:
        newDate = DateTime(
          date.year,
          date.month,
          date.day - 1,
        );

        year = newDate.year;
        month = newDate.month;
        day = newDate.day;
        break;
    }
  }

  @override
  String toString() {
    return 'Period: [y: $year, m: $month, d: $day]';
  }
}
