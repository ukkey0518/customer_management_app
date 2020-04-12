import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VisitRecordListCard extends StatelessWidget {
  VisitRecordListCard({this.soldItem, this.onTap, this.onLongPress});

  final SoldItem soldItem;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text('$soldItem'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
