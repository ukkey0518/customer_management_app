import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

Picker singleItemSelectPicker(
  BuildContext context,
  List<String> values,
  String selectedValue,
  ValueChanged<String> onConfirm,
) {
  return Picker(
    adapter: PickerDataAdapter<String>(pickerdata: values),
    changeToFirst: true,
    textAlign: TextAlign.center,
    selecteds: [values.indexOf(selectedValue)],
    columnPadding: const EdgeInsets.all(16.0),
    confirmText: '決定',
    confirmTextStyle: TextStyle(
      fontSize: 16,
      color: Theme.of(context).primaryColor,
    ),
    cancelText: 'キャンセル',
    cancelTextStyle: TextStyle(
      fontSize: 16,
      color: Colors.grey,
    ),
    onConfirm: (Picker picker, List value) =>
        onConfirm(picker.getSelectedValues().single.toString()),
  );
}
