import 'package:customermanagementapp/util/colors.dart';
import 'package:customermanagementapp/view/components/input_form_widgets/select_buttons.dart';
import 'package:flutter/material.dart';

import 'input_form_widgets/date_select_form.dart';
import 'input_form_widgets/input_field.dart';

class BasicInputForm extends StatelessWidget {
  BasicInputForm({
    @required this.formTitle,
    @required this.nameInputField,
    @required this.nameReadingInputField,
    @required this.genderSelectButtons,
    @required this.birthDaySelectForm,
  });

  final String formTitle;

  final InputField nameInputField;
  final InputField nameReadingInputField;
  final SelectButtons genderSelectButtons;
  final DateSelectForm birthDaySelectForm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            formTitle,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Card(
          color: MyColors.lightGrey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('氏名：', style: TextStyle(fontWeight: FontWeight.bold)),
                nameInputField,
                SizedBox(height: 16),
                Text('よみがな：', style: TextStyle(fontWeight: FontWeight.bold)),
                nameReadingInputField,
                SizedBox(height: 16),
                Text('性別：', style: TextStyle(fontWeight: FontWeight.bold)),
                genderSelectButtons,
                SizedBox(height: 16),
                Text('生年月日：', style: TextStyle(fontWeight: FontWeight.bold)),
                birthDaySelectForm,
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
