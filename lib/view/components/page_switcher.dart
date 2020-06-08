import 'package:customermanagementapp/view/components/buttons/tab_buttons.dart';
import 'package:flutter/material.dart';

class PageSwitcher extends StatelessWidget {
  PageSwitcher({
    @required this.tabsData,
    @required this.selectedTab,
    @required this.onChanged,
  });

  final Map<String, Widget> tabsData;
  final String selectedTab;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = tabsData.keys.toList();

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TabButtons(
            tabs: tabs,
            selectedValue: selectedTab,
            onChanged: (value) => onChanged(value),
          ),
        ),
        tabsData[selectedTab],
      ],
    );
  }
}
