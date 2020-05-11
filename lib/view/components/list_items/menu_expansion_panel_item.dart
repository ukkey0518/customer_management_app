import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';

import 'package:customermanagementapp/view/components/polymorphism/basic_list_view_item.dart';
import 'package:flutter/material.dart';

class MenuExpansionPanelItem extends BasicListViewItem<Menu> {
  MenuExpansionPanelItem({
    @required Menu menu,
    ValueChanged onTap,
    ValueChanged onLongPress,
  }) : super(item: menu, onTap: onTap, onLongPress: onLongPress);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(height: 1),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(item.name, style: TextStyle(fontSize: 16)),
                ),
                Text('${item.price.toPriceString()}',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          onTap: () => onTap(item),
          onLongPress: onLongPress != null ? () => onLongPress(item) : null,
        ),
      ],
    );
  }
}
