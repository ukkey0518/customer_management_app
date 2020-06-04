import 'package:customermanagementapp/data/enums/date_format_mode.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/polymorphism/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DateInputTile extends InputWidget {
  DateInputTile({
    @required this.selectedDate,
    @required this.onConfirm,
    this.isDisabled = false,
    this.isClearable = false,
    this.paddingHorizontal = 0,
    this.paddingVertical = 0,
    this.color,
    this.compactMode = false,
    DateTime minTime,
    DateTime maxTime,
    DateTime currentTime,
  })  : _minTime = minTime ?? DateTime(1990, 1, 1),
        _maxTime = maxTime ?? DateTime.now(),
        _currentTime = selectedDate == null ? DateTime.now() : selectedDate;

  final DateTime selectedDate;
  final ValueChanged<DateTime> onConfirm;
  final bool isDisabled;
  final bool isClearable;
  final double paddingVertical;
  final double paddingHorizontal;
  final Color color;
  final bool compactMode;
  final DateTime _minTime;
  final DateTime _maxTime;
  final DateTime _currentTime;

  @override
  Widget build(BuildContext context) {
    if (isDisabled) {
      return Text(
        selectedDate.toFormatStr(DateFormatMode.FULL),
        style: TextStyle(fontSize: 16),
      );
    }

    var content;

    if (compactMode) {
      content = Text(
        selectedDate == null
            ? '未設定'
            : selectedDate.toFormatStr(DateFormatMode.MEDIUM),
        style: TextStyle(fontSize: 16),
      );
    } else {
      content = Row(
        children: <Widget>[
          Expanded(
            child: Text(
              selectedDate == null
                  ? '未設定'
                  : selectedDate.toFormatStr(DateFormatMode.FULL),
              style: TextStyle(fontSize: 16),
            ),
          ),
          Icon(Icons.arrow_drop_down),
        ],
      );
    }

    return InkWell(
      onTap: () => _showDateSelectPicker(context),
      onLongPress: isClearable ? () => onConfirm(null) : null,
      child: Container(
        color: color,
        padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal, vertical: paddingVertical),
        child: content,
      ),
    );
  }

  // [コールバック：誕生日欄タップ時]
  _showDateSelectPicker(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: _minTime,
      maxTime: _maxTime,
      onConfirm: onConfirm,
      currentTime: _currentTime,
      locale: LocaleType.jp,
    );
  }
}
