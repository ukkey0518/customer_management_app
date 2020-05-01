import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/polymorphism/basic_list_view_item.dart';
import 'package:flutter/material.dart';

class MenuCategoryListItem extends BasicListViewItem<MenuCategory> {
  MenuCategoryListItem({
    @required MenuCategory menuCategory,
    ValueChanged onTap,
    ValueChanged onLongPress,
  }) : super(item: menuCategory, onTap: onTap, onLongPress: onLongPress);

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
            Icons.category,
            color: Color(item.color),
          ),
          onTap: () => onTap(item),
          onLongPress: () => onLongPress(item),
        ),
        Divider(height: 1),
      ],
    );
  }
}
