import 'package:customermanagementapp/data/enums/date_format_mode.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/util/functions/show_date_select_picker.dart';
import 'package:flutter/material.dart';

class DateInputContainer extends StatelessWidget {
  DateInputContainer({
    @required this.selectedDate,
    @required this.onConfirm,
    this.isDisabled = false,
    this.isClearable = false,
    this.paddingHorizontal = 0,
    this.paddingVertical = 0,
    this.backgroundColor,
    this.compactMode = false,
    this.isExpand = false,
    this.aliment,
    this.minTime,
    this.maxTime,
    this.currentTime,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onConfirm;
  final bool isExpand;
  final bool isDisabled;
  final bool isClearable;
  final bool compactMode;
  final double paddingVertical;
  final double paddingHorizontal;
  final Color backgroundColor;
  final DateTime minTime;
  final DateTime maxTime;
  final DateTime currentTime;
  final Alignment aliment;

  @override
  Widget build(BuildContext context) {
    if (isDisabled) {
      return Text(
        selectedDate.toFormatStr(DateFormatMode.FULL),
        style: TextStyle(fontSize: 16),
      );
    }

    return SizedBox(
      width: isExpand ? double.infinity : null,
      height: isExpand ? double.infinity : null,
      child: InkWell(
        onTap: () => showDateSelectPicker(
          context,
          onConfirm: (date) => onConfirm(date),
          minTime: minTime,
          maxTime: maxTime,
          currentTime: currentTime,
        ),
        onLongPress: isClearable ? () => onConfirm(null) : null,
        child: Container(
          alignment: aliment,
          color: backgroundColor,
          padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal, vertical: paddingVertical),
          child: compactMode
              ? Text(
                  selectedDate == null
                      ? '未設定'
                      : selectedDate.toFormatStr(DateFormatMode.MEDIUM),
                  style: TextStyle(fontSize: 16))
              : Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                          selectedDate == null
                              ? '未設定'
                              : selectedDate.toFormatStr(DateFormatMode.FULL),
                          style: TextStyle(fontSize: 16)),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
        ),
      ),
    );
  }
}
