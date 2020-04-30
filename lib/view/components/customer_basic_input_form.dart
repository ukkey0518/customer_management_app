import 'package:customermanagementapp/view/components/select_buttons.dart';
import 'package:flutter/material.dart';

import 'date_select_form.dart';
import 'input_field.dart';

class CustomerBasicInputForm extends StatelessWidget {
  CustomerBasicInputForm({
    @required this.nameInputField,
    @required this.nameReadingInputField,
    @required this.genderSelectButtons,
    @required this.birthDaySelectForm,
  });

  final InputField nameInputField;
  final InputField nameReadingInputField;
  final SelectButtons genderSelectButtons;
  final DateSelectForm birthDaySelectForm;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xe5e5e5e5),
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
    );
  }
}
