import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DatePickerByPeriod extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  DatePickerByPeriod({DateTime currentTime, LocaleType locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.year);
    this.setMiddleIndex(this.currentTime.month);
    this.setRightIndex(this.currentTime.day);
  }

  @override
  String leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 1, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex(),
            currentTime.hour,
            currentTime.minute,
            currentTime.second,
          )
        : DateTime(
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex(),
            currentTime.hour,
            currentTime.minute,
            currentTime.second,
          );
  }
}
