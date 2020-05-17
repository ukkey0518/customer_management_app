import 'package:customermanagementapp/data/enums/period_select_mode.dart';

class Period {
  Period({year, month, day})
      : _year = year,
        _month = month,
        _day = day;

  int _year;

  int get year => _year;

  int _month;

  int get month => _month;

  int _day;

  int get day => _day;

  void clear() {
    _year = null;
    _month = null;
    _day = null;
  }

  void setPeriod({
    int year,
    int month,
    int day,
    bool isReset = false,
  }) {
    if (isReset) {
      _year = year;
      _month = month;
      _day = day;
    } else {
      _year = year ?? _year;
      _month = month ?? _month;
      _day = day ?? _day;
    }
  }

  void increment(PeriodSelectMode selectMode) {
    switch (selectMode) {
      case PeriodSelectMode.YEAR:
        _year++;
        break;
      case PeriodSelectMode.MONTH:
        _month++;
        break;
      case PeriodSelectMode.DAY:
        _day++;
        break;
    }
  }

  void decrement(PeriodSelectMode selectMode) {
    switch (selectMode) {
      case PeriodSelectMode.YEAR:
        _year--;
        break;
      case PeriodSelectMode.MONTH:
        _month--;
        break;
      case PeriodSelectMode.DAY:
        _day--;
        break;
    }
  }

  @override
  String toString() {
    return 'Period: [y: $_year, m: $_month, d: $_day]';
  }
}
