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
    return Row(
      children: <Widget>[
        Expanded(
          child: Card(
            color: Colors.grey.shade200,
            child: DateInputTile(
              selectedDate: sinceDate,
              paddingVertical: 16,
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
          child: Card(
            color: Colors.grey.shade200,
            child: DateInputTile(
              selectedDate: untilDate,
              paddingVertical: 16,
              paddingHorizontal: 16,
              onConfirm: (date) => onUntilDateConfirm(date),
              isClearable: true,
              minTime: sinceDate,
              compactMode: true,
            ),
          ),
        ),
      ],
    );
  }
}
