import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:customermanagementapp/util/extensions.dart';

class DateSelectForm extends StatelessWidget {
  DateSelectForm({
    @required this.selectedDate,
    @required this.onConfirm,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onConfirm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: InkWell(
            onTap: () => _showDateSelectPicker(context),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? '未登録'
                        : '${selectedDate.toBirthDayString()}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: RaisedButton(
            disabledColor: Color(0xe5e5e5e5),
            child: Text('クリア'),
            onPressed: selectedDate != null ? () => onConfirm(null) : null,
          ),
        ),
      ],
    );
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
