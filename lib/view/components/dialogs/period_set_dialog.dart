import 'package:customermanagementapp/data/data_classes/period.dart';
import 'package:customermanagementapp/data/enums/period_select_mode.dart';
import 'package:customermanagementapp/data/period_select_mode_text_entry.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/dialogs/dialog_title_text.dart';
import 'package:customermanagementapp/view/components/input_widgets/select_switch_buttons.dart';
import 'package:flutter/material.dart';

class PeriodSetDialog extends StatelessWidget {
  PeriodSetDialog({this.period, this.mode});

  final Period period;
  final PeriodSelectMode mode;

  @override
  Widget build(BuildContext context) {
    var selectPeriod = period;
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
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('キャンセル'),
              onPressed: () =>
                  Navigator.of(context).pop({'period': period, 'mode': mode}),
            ),
            FlatButton(
              child: const Text('確定'),
              onPressed: () => Navigator.of(context)
                  .pop({'period': selectPeriod, 'mode': selectMode}),
            ),
          ],
        );
      },
    );
  }
}
