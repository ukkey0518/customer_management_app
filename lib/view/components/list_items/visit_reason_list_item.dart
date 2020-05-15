import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/polymorphism/basic_list_view_item.dart';
import 'package:flutter/material.dart';

class VisitReasonListItem extends BasicListViewItem<VisitReason> {
  VisitReasonListItem({
    @required VisitReason visitReason,
    ValueChanged onTap,
    ValueChanged onLongPress,
  }) : super(item: visitReason, onTap: onTap, onLongPress: onLongPress);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            '${item.reason}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          leading: Icon(
            Icons.comment,
            color: Colors.grey,
          ),
          onTap: () => onTap(item),
          onLongPress: () => onLongPress(item),
        ),
        Divider(height: 1),
      ],
    );
  }
}
