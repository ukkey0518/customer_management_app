import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/selected_menu_list_parts/selected_menu_header.dart';
import 'package:customermanagementapp/view/components/selected_menu_list_parts/selected_menu_item.dart';
import 'package:flutter/material.dart';

class SelectedMenuList extends StatelessWidget {
  SelectedMenuList({
    @required this.selectedMenus,
    this.onItemTap,
  });

  final List<Menu> selectedMenus;
  final ValueChanged<Menu> onItemTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SelectedMenuHeader(
                selectedMenus: selectedMenus,
              ),
              Divider(),
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: selectedMenus.length,
                    itemBuilder: (context, index) {
                      return SelectedMenuItem(
                        menu: selectedMenus[index],
                        onTap: (menu) => onItemTap(menu),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
