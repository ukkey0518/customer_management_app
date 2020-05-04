import 'package:customermanagementapp/data/date_format_mode.dart';
import 'package:customermanagementapp/view/components/polymorphism/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:customermanagementapp/util/extensions.dart';

class DateSelectForm extends InputWidget {
  DateSelectForm({
    @required this.selectedDate,
    @required this.onConfirm,
    this.isDisabled = false,
    this.isClearable = false,
    this.paddingHorizontal = 0,
    this.paddingVertical = 0,
    this.color,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onConfirm;
  final bool isDisabled;
  final bool isClearable;
  final double paddingVertical;
  final double paddingHorizontal;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (isDisabled) {
      return Text(
        selectedDate.toFormatString(DateFormatMode.FULL),
        style: TextStyle(fontSize: 16),
      );
    }
    return Column(
      children: <Widget>[
        Container(
          color: color,
          padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal, vertical: paddingVertical),
          child: InkWell(
            onTap: () => _showDateSelectPicker(context),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? '未登録'
                        : selectedDate.toFormatString(DateFormatMode.FULL),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
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
      minTime: DateTime(1970, 1, 1),
      maxTime: DateTime.now(),
      onConfirm: onConfirm,
      currentTime: selectedDate == null ? DateTime(1990, 1, 1) : selectedDate,
      locale: LocaleType.jp,
    );
  }
}
