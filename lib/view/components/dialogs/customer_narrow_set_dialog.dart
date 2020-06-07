import 'package:customermanagementapp/data/data_classes/customer_narrow_data.dart';
import 'package:customermanagementapp/data/gender_bool_data.dart';
import 'package:customermanagementapp/data/visit_reason_data.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/custom_dropdown_button/simple_dropdown_button.dart';
import 'package:customermanagementapp/view/components/dialogs/dialog_title_text.dart';
import 'package:customermanagementapp/view/components/input_widgets/period_input_tile.dart';
import 'package:customermanagementapp/view/components/input_widgets/select_switch_buttons.dart';
import 'package:flutter/material.dart';
import 'package:time/time.dart';

class CustomerNarrowSetDialog extends StatelessWidget {
  CustomerNarrowSetDialog({
    @required this.narrowData,
  });

  final CustomerNarrowData narrowData;

  @override
  Widget build(BuildContext context) {
    var narrow = narrowData;
    var unselectedValue = '未設定';

    int numOfVisits = narrow.numOfVisits;
    bool isGenderFemale = narrow.isGenderFemale;
    int minAge = narrow.minAge;
    int maxAge = narrow.maxAge;
    DateTime sinceLastVisit = narrow.sinceLastVisit;
    DateTime untilLastVisit = narrow.untilLastVisit;
    DateTime sinceNextVisit = narrow.sinceNextVisit;
    DateTime untilNextVisit = narrow.untilNextVisit;
    String visitReason = narrow.visitReason;

    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: DialogTitleText('絞り込み条件の設定'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //TODO 来店回数
              Text('最終来店日：'),
              PeriodInputTile(
                sinceDate: sinceLastVisit,
                untilDate: untilLastVisit,
                onSinceDateConfirm: (date) =>
                    setState(() => sinceLastVisit = date),
                onUntilDateConfirm: (date) =>
                    setState(() => untilLastVisit = date),
              ),
              Text('次回来店予想：'),
              PeriodInputTile(
                sinceDate: sinceNextVisit,
                untilDate: untilNextVisit,
                onSinceDateConfirm: (date) =>
                    setState(() => sinceNextVisit = date),
                onUntilDateConfirm: (date) =>
                    setState(() => untilNextVisit = date),
                maxDate: DateTime.now() + 365.days,
              ),
              SizedBox(height: 16),
              //TODO 年齢
              SizedBox(height: 16),
              Text('性別：'),
              SelectSwitchButtons(
                values: genderBoolData.values.toList(),
                selectedValue: isGenderFemale != null
                    ? genderBoolData[isGenderFemale]
                    : unselectedValue,
                unselectedValue: unselectedValue,
                onChanged: (value) {
                  setState(() {
                    isGenderFemale = value == unselectedValue
                        ? null
                        : genderBoolData.getKeyFromValue(value);
                  });
                },
              ),
              SizedBox(height: 16),
              Text('来店理由：'),
              SimpleDropdownButton(
                items: visitReasonData.keys.toList(),
                selectedItem: visitReason ?? unselectedValue,
                onChanged: (value) => setState(() {
                  return visitReason = value == unselectedValue ? null : value;
                }),
                isExpand: true,
                textColor: Theme.of(context).primaryColorDark,
                unselectedValue: unselectedValue,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('キャンセル'),
            onPressed: () => Navigator.of(context).pop(narrow),
          ),
          FlatButton(
            child: Text('決定'),
            onPressed: () {
              narrow = CustomerNarrowData(
                numOfVisits: numOfVisits,
                isGenderFemale: isGenderFemale,
                minAge: minAge,
                maxAge: maxAge,
                sinceLastVisit: sinceLastVisit,
                untilLastVisit: untilLastVisit,
                sinceNextVisit: sinceNextVisit,
                untilNextVisit: untilNextVisit,
                visitReason: visitReason,
              );
              Navigator.of(context).pop(narrow);
            },
          ),
        ],
      );
    });
  }
}
