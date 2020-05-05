import 'package:customermanagementapp/data/date_format_mode.dart';
import 'package:customermanagementapp/view/components/polymorphism/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:customermanagementapp/util/extensions.dart';

class DateInputTile extends InputWidget {
  DateInputTile({
    @required this.selectedDate,
    @required this.onConfirm,
    this.onLongPress,
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
  final ValueChanged<DateTime> onLongPress;
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
        selectedDate.toFormatString(DateFormatMode.FULL),
        style: TextStyle(fontSize: 16),
      );
    }

    var content;

    if (compactMode) {
      content = Text(
        selectedDate == null
            ? '未設定'
            : selectedDate.toFormatString(DateFormatMode.MEDIUM),
        style: TextStyle(fontSize: 16),
      );
    } else {
      content = Row(
        children: <Widget>[
          Expanded(
            child: Text(
              selectedDate == null
                  ? '未設定'
                  : selectedDate.toFormatString(DateFormatMode.FULL),
              style: TextStyle(fontSize: 16),
            ),
          ),
          Icon(Icons.chevron_right),
        ],
      );
    }

    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => _showDateSelectPicker(context),
          onLongPress:
              onLongPress != null ? () => onLongPress(selectedDate) : null,
          child: Container(
            color: color,
            padding: EdgeInsets.symmetric(
                horizontal: paddingHorizontal, vertical: paddingVertical),
            child: content,
          ),
        ),
        _clearButtonPart(isClearable),
      ],
    );
  }

  Widget _clearButtonPart(bool flag) {
    return flag
        ? Container(
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: RaisedButton(
              disabledColor: Color(0xe5e5e5e5),
              child: Text('クリア'),
              onPressed: selectedDate != null ? () => onConfirm(null) : null,
            ),
          )
        : Container();
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
