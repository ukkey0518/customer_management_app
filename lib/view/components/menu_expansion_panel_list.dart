import 'package:customermanagementapp/data/data_classes/menus_by_category.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/functions.dart';
import 'package:customermanagementapp/view/components/expantion_panels/add_panel.dart';
import 'package:customermanagementapp/view/components/expantion_panels/title_panel.dart';
import 'package:flutter/material.dart';

import 'expantion_panels/menu_panel.dart';

class MenuExpansionPanelList extends StatelessWidget {
  MenuExpansionPanelList({
    @required this.menuByCategories,
    @required this.expansionCallback,
    this.onItemPanelTap,
    this.onItemPanelLongPress,
    this.onAddPanelTap,
  });

  final void Function(int index, bool isExpanded) expansionCallback;
  final List<MenusByCategory> menuByCategories;
  final BiConsumer<MenuCategory, Menu> onItemPanelTap;
  final ValueChanged<Menu> onItemPanelLongPress;
  final ValueChanged<MenuCategory> onAddPanelTap;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: expansionCallback,
      children: menuByCategories.map<ExpansionPanel>((menusByCategory) {
        var menus = menusByCategory.menus;
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ExpansionPanelTitle(
              title: menusByCategory.menuCategory.name,
              leading: Icon(
                Icons.category,
                color: Color(menusByCategory.menuCategory.color),
              ),
            );
          },
          // メニュー部分の生成
          body: SingleChildScrollView(
            child: Column(
              children: List<Widget>.generate(
                menus.length,
                (index) => MenuPanel(
                  menu: menus[index],
                  onTap: (menu) {
                    onItemPanelTap(menusByCategory.menuCategory, menu);
                  },
                  onLongPress: onItemPanelLongPress != null
                      ? (menu) => onItemPanelLongPress(menu)
                      : null,
                ),
              )..add(
                  onAddPanelTap != null
                      ? ExpansionPanelAddPanel(
                          name: 'メニュー',
                          onTap: () =>
                              onAddPanelTap(menusByCategory.menuCategory),
                        )
                      : Container(),
                ),
            ),
          ),
          isExpanded: menusByCategory.isExpanded,
          canTapOnHeader: true,
        );
      }).toList(),
    );
  }
}
