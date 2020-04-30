import 'package:customermanagementapp/util/mixins.dart';
import 'package:flutter/material.dart';

class SelectButtons extends StatelessWidget with InputWidgetMixIn {
  SelectButtons({
    @required this.values,
    @required this.selectedValue,
    @required this.onChanged,
  }) : assert(values.length >= 2);

  final List<String> values;
  final String selectedValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Widget>.generate(values.length, (index) {
        var value = values[index];
        return RaisedButton(
          color: value == selectedValue
              ? Theme.of(context).primaryColorLight
              : Colors.white,
          child: Text(
            value,
            style: TextStyle(
              color: value == selectedValue ? Colors.black : Colors.grey,
            ),
          ),
          onPressed: () => onChanged(value),
        );
      }),
    );
  }
}
