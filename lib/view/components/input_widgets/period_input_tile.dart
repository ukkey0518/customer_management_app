import 'package:customermanagementapp/view/components/custom_containers/rounded_rectangle_container.dart';
import 'package:flutter/material.dart';

import 'date_input_tile.dart';

class PeriodInputTile extends StatelessWidget {
  PeriodInputTile({
    @required this.sinceDate,
    @required this.untilDate,
    this.onSinceDateConfirm,
    this.onUntilDateConfirm,
  });

  final DateTime sinceDate;
  final DateTime untilDate;
  final ValueChanged<DateTime> onSinceDateConfirm;
  final ValueChanged<DateTime> onUntilDateConfirm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: RoundedRectangleContainer(
                borderColor: sinceDate != null
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                borderWidth: 2,
                height: 45,
                width: 120,
                child: DateInputTile(
                  isExpand: true,
                  aliment: Alignment.center,
                  selectedDate: sinceDate,
                  paddingVertical: 8,
                  paddingHorizontal: 16,
                  onConfirm: (date) => onSinceDateConfirm(date),
                  isClearable: true,
                  maxTime: untilDate,
                  compactMode: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text('〜'),
            ),
            Expanded(
              child: RoundedRectangleContainer(
                borderColor: untilDate != null
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                borderWidth: 2,
                height: 45,
                width: 120,
                child: DateInputTile(
                  isExpand: true,
                  aliment: Alignment.center,
                  selectedDate: untilDate,
                  paddingVertical: 8,
                  paddingHorizontal: 16,
                  onConfirm: (date) => onUntilDateConfirm(date),
                  isClearable: true,
                  minTime: sinceDate,
                  compactMode: true,
                ),
              ),
            ),
          ],
        ),
        const Text(
          '※長押しでクリア',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
