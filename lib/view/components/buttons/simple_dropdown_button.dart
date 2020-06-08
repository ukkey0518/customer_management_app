import 'package:flutter/material.dart';

class SimpleDropdownButton extends StatelessWidget {
  SimpleDropdownButton({
    @required this.items,
    @required this.selectedItem,
    @required this.onChanged,
    this.isExpand = false,
    this.isDisabled = false,
    this.isTextContrast = false,
    this.unselectedValue,
    this.textColor,
  });

  final List<String> items;
  final String selectedItem;
  final String unselectedValue;
  final Color textColor;
  final ValueChanged<String> onChanged;
  final bool isExpand;
  final bool isDisabled;
  final bool isTextContrast;

  @override
  Widget build(BuildContext context) {
    if (isDisabled) {
      return Container(
        width: isExpand ? double.infinity : null,
        child: Text(
          selectedItem ?? '',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    var itemList = List<String>.from(items).toList();
    var txtColor = textColor ?? Theme.of(context).primaryColorDark;

    if (unselectedValue != null) {
      itemList.insert(0, unselectedValue);
    }

    return DropdownButton(
      isExpanded: isExpand,
      value: selectedItem,
      selectedItemBuilder: (context) {
        return itemList.map((name) {
          final color = unselectedValue != null && name == unselectedValue
              ? Colors.grey
              : txtColor;
          final weight = unselectedValue != null && name == unselectedValue
              ? FontWeight.normal
              : FontWeight.bold;
          return Container(
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: TextStyle(
                color: isTextContrast ? color : null,
                fontWeight: isTextContrast ? weight : FontWeight.normal,
              ),
            ),
          );
        }).toList();
      },
      items: itemList.map<DropdownMenuItem>((name) {
        final color = unselectedValue != null && name == unselectedValue
            ? Colors.grey
            : txtColor;
        final weight = unselectedValue != null && name == unselectedValue
            ? FontWeight.normal
            : FontWeight.bold;
        return DropdownMenuItem(
          value: name,
          child: Text(
            name,
            style: TextStyle(
              color: isTextContrast ? color : null,
              fontWeight: isTextContrast ? weight : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
      onChanged: (value) => onChanged(value),
    );
  }
}
