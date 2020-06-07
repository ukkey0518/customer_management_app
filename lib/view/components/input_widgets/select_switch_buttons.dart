import 'package:customermanagementapp/view/components/polymorphism/input_widget.dart';
import 'package:flutter/material.dart';

class SelectSwitchButtons extends InputWidget {
  SelectSwitchButtons({
    @required this.values,
    @required this.selectedValue,
    @required this.onChanged,
    this.unselectedValue,
  }) : assert(values.length >= 2);

  final List<String> values;
  final String selectedValue;
  final ValueChanged<String> onChanged;
  final String unselectedValue;

  @override
  Widget build(BuildContext context) {
    var valueList = List<String>.from(values);

    if (unselectedValue != null) {
      valueList.insert(0, unselectedValue);
    }

    return Row(
      children: List<Widget>.generate(valueList.length, (index) {
        var value = valueList[index];
        var selectedColor = unselectedValue != value
            ? Theme.of(context).primaryColorLight
            : Colors.grey.shade300;
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: RaisedButton(
            color: value == selectedValue ? selectedColor : Colors.white,
            child: Text(
              value,
              style: TextStyle(
                color: value == selectedValue ? Colors.black : Colors.grey,
              ),
            ),
            onPressed: () {
              onChanged(value != '未設定' ? value : null);
            },
          ),
        );
      }),
    );
  }
}
