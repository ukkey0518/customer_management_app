import 'package:flutter/material.dart';

class NarrowDropDownMenu extends StatelessWidget {
  NarrowDropDownMenu({this.items, this.selectedValue, this.onSelected});

  final List<String> items;
  final String selectedValue;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: DropdownButton(
          value: selectedValue,
          icon: Icon(Icons.arrow_drop_down),
          onChanged: onSelected,
          style: TextStyle(fontSize: 14, color: Colors.black),
          items: items.map<DropdownMenuItem<String>>(
            (value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(
                  width: 80,
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
