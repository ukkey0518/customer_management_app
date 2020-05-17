import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:customermanagementapp/data/period_select_mode_text_entry.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/dialogs/dialog_title_text.dart';
import 'package:customermanagementapp/view/components/input_widgets/select_switch_buttons.dart';
import 'package:flutter/material.dart';

class PeriodSetDialog extends StatelessWidget {
  PeriodSetDialog({this.date, this.mode});

  final DateTime date;
  final PeriodMode mode;

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
                //TODO 日付を選択する部分
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
