import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/polymorphism/basic_list_view_item.dart';
import 'package:flutter/material.dart';

class EmployeeListItem extends BasicListViewItem<Employee> {
  EmployeeListItem({
    @required Employee employee,
    ValueChanged onTap,
    ValueChanged onLongPress,
  }) : super(item: employee, onTap: onTap, onLongPress: onLongPress);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            '${item.name}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          leading: Icon(
            Icons.supervisor_account,
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
