import 'package:flutter/material.dart';

class PageSelectTabs extends StatelessWidget {
  PageSelectTabs({
    @required this.tabs,
    @required this.selectedValue,
    @required this.onChanged,
  });

  final List<String> tabs;
  final String selectedValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final focusedTextColor = Colors.white;
    final focusedBoxColor = Theme.of(context).primaryColor;
    final unfocusedTextColor = Theme.of(context).primaryColor;
    final unfocusedBoxColor = Colors.white;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColorLight,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(tabs.length, (index) {
          final isLast = tabs.last == tabs[index];
          final isSelected = selectedValue == tabs[index];
          return InkWell(
            onTap: () => onChanged(tabs[index]),
            child: Container(
              width: 100,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected ? focusedBoxColor : unfocusedBoxColor,
                border: Border(
                  right: isLast
                      ? BorderSide.none
                      : BorderSide(color: Theme.of(context).primaryColorLight),
                ),
              ),
              child: Text(
                '${tabs[index]}',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? focusedTextColor : unfocusedTextColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }),
      ),
    );
  }
}
