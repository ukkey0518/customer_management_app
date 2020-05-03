import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/polymorphism/expansion_panel_title.dart';
import 'package:flutter/material.dart';

class ExpansionPanelTitleMenuCategory extends ExpansionPanelTitle {
  ExpansionPanelTitleMenuCategory({
    @required MenuCategory menuCategory,
  }) : super(
          title: menuCategory.name,
          leading: Icon(
            Icons.category,
            color: Color(menuCategory.color),
          ),
        );
}
