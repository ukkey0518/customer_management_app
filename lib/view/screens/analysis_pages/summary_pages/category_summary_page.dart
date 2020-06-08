import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/screen_components/analysis_screen_parts/sales_summary_cards/menu_list_breakdown_card.dart';
import 'package:flutter/material.dart';

class CategorySummaryPage extends StatefulWidget {
  CategorySummaryPage({
    @required this.menuCategories,
    @required this.vhList,
  });

  final List<MenuCategory> menuCategories;
  final List<VisitHistory> vhList;

  @override
  _CategorySummaryPageState createState() => _CategorySummaryPageState();
}

class _CategorySummaryPageState extends State<CategorySummaryPage> {
  @override
  Widget build(BuildContext context) {
    final dataMap =
        widget.vhList.getAllSoldMenus().toMenusData(widget.menuCategories);
    dataMap.forEach((key, value) {
      print('${key.name} : ${value.map((menu) => menu.name)}');
    });

    return Container(
      child: Expanded(
        child: ListView(
          children: [
            MenuListBreakDownCard(
              menuData: dataMap,
            ),
          ],
        ),
      ),
    );
  }
}
