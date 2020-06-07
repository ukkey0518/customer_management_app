import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

showDateSelectPicker(
  BuildContext context, {
  @required ValueChanged<DateTime> onConfirm,
  DateTime minTime,
  DateTime maxTime,
  DateTime currentTime,
}) {
  var min = minTime ?? DateTime(1990, 1, 1);
  var max = maxTime ?? DateTime.now();
  var current = DateTime.now();

  DatePicker.showDatePicker(
    context,
    showTitleActions: true,
    minTime: min,
    maxTime: max,
    onConfirm: (date) => onConfirm(date),
    currentTime: current,
    locale: LocaleType.jp,
  );
}
