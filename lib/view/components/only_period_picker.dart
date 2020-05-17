import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class OnlyPeriodPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  OnlyPeriodPicker({
    DateTime currentTime,
    LocaleType locale,
  }) : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setMiddleIndex(this.currentTime.month);
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
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex(),
          )
        : DateTime(
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex(),
          );
  }
}
