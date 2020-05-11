import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class SelectedMenuItem extends StatelessWidget {
  SelectedMenuItem({
    @required this.menu,
    this.onTap,
  });

  final Menu menu;
  final ValueChanged<Menu> onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(menu),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.import_contacts,
              color: Color(menu.menuCategoryJson.toMenuCategory().color),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                menu.name,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              '${menu.price.toPriceString()}',
              style: TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
