import 'package:customermanagementapp/data/data_classes/customer_narrow_data.dart';
import 'package:customermanagementapp/data/gender_bool_data.dart';
import 'package:customermanagementapp/data/visit_reason_data.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/buttons/simple_dropdown_button.dart';
import 'package:customermanagementapp/view/components/dialogs/dialog_title_text.dart';
import 'package:customermanagementapp/view/components/custom_containers/since_until_date_input_container.dart';
import 'package:customermanagementapp/view/components/buttons/raised_switch_buttons.dart';
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
    final novList = <String>['~10', '11~20', '21~30', '31~40', '41~50', '51~'];
    final ageList = <String>['10代', '20代', '30代', '40代', '50代'];

    String numOfVisits = narrow.numOfVisits;
    bool isGenderFemale = narrow.isGenderFemale;
    String age = narrow.age;
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
              Text('■最終来店日'),
              SinceUntilDateInputContainer(
                sinceDate: sinceLastVisit,
                untilDate: untilLastVisit,
                onSinceDateConfirm: (date) =>
                    setState(() => sinceLastVisit = date.toOnlyDate()),
                onUntilDateConfirm: (date) =>
                    setState(() => untilLastVisit = date.toOnlyDate()),
              ),
              Text('■次回来店予想'),
              SinceUntilDateInputContainer(
                sinceDate: sinceNextVisit,
                untilDate: untilNextVisit,
                onSinceDateConfirm: (date) =>
                    setState(() => sinceNextVisit = date.toOnlyDate()),
                onUntilDateConfirm: (date) =>
                    setState(() => untilNextVisit = date.toOnlyDate()),
                maxDate: DateTime.now() + 365.days,
              ),
              Text('■来店回数'),
              SimpleDropdownButton(
                items: novList,
                selectedItem: numOfVisits ?? unselectedValue,
                onChanged: (value) => setState(() {
                  return numOfVisits = value == unselectedValue ? null : value;
                }),
                textColor: Theme.of(context).primaryColorDark,
                unselectedValue: unselectedValue,
                isTextContrast: true,
              ),
              SizedBox(height: 16),
              Text('■年齢層'),
              SimpleDropdownButton(
                items: ageList,
                selectedItem: age ?? unselectedValue,
                onChanged: (value) => setState(() {
                  return age = value == unselectedValue ? null : value;
                }),
                textColor: Theme.of(context).primaryColorDark,
                unselectedValue: unselectedValue,
                isTextContrast: true,
              ),
              SizedBox(height: 16),
              Text('■性別'),
              RaisedSwitchButtons(
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
              Text('■来店理由'),
              SimpleDropdownButton(
                items: visitReasonData.keys.toList(),
                selectedItem: visitReason ?? unselectedValue,
                onChanged: (value) => setState(() {
                  return visitReason = value == unselectedValue ? null : value;
                }),
                isExpand: true,
                textColor: Theme.of(context).primaryColorDark,
                unselectedValue: unselectedValue,
                isTextContrast: true,
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
                age: age,
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
