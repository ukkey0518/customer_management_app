import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:customermanagementapp/data/period_select_mode_text_entry.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/dialogs/dialog_title_text.dart';
import 'package:customermanagementapp/view/components/input_widgets/date_select_tiles_by_period.dart';
import 'package:customermanagementapp/view/components/input_widgets/select_switch_buttons.dart';
import 'package:flutter/material.dart';

class PeriodSetDialog extends StatelessWidget {
  PeriodSetDialog({
    @required this.mode,
    @required this.date,
    DateTime maxDate,
    DateTime minDate,
  })  : _maxDate = maxDate ?? DateTime(2200, 1, 1),
        _minDate = minDate ?? DateTime(1990, 1, 1);

  final PeriodMode mode;
  final DateTime date;
  final DateTime _maxDate;
  final DateTime _minDate;

  @override
  Widget build(BuildContext context) {
    var selectDate = date;
    var selectMode = mode;

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: DialogTitleText('集計期間の設定'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SelectSwitchButtons(
                  values: periodModeTextMap.values.toList(),
                  onChanged: (value) {
                    setState(() {
                      selectMode = periodModeTextMap.getKeyFromValue(value);
                    });
                  },
                  selectedValue: periodModeTextMap[selectMode],
                ),
                DateSelectTilesByPeriod(
                  mode: selectMode,
                  date: selectDate,
                  maxDate: _maxDate,
                  minDate: _minDate,
                  increment: (mode) {
                    setState(() {
                      final date = selectDate.increment(mode);
                      if (date.isAfter(_maxDate)) {
                        selectDate = _maxDate;
                      } else {
                        selectDate = date;
                      }
                    });
                  },
                  decrement: (mode) {
                    setState(() {
                      final date = selectDate.decrement(mode);
                      if (date.isBefore(_minDate)) {
                        selectDate = _minDate;
                      } else {
                        selectDate = date;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('キャンセル'),
              onPressed: () =>
                  Navigator.of(context).pop({'date': date, 'mode': mode}),
            ),
            FlatButton(
              child: const Text('確定'),
              onPressed: () => Navigator.of(context)
                  .pop({'date': selectDate, 'mode': selectMode}),
            ),
          ],
        );
      },
    );
  }
}
