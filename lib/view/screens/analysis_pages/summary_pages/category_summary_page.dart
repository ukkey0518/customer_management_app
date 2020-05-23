import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class CategorySummaryPage extends StatefulWidget {
  CategorySummaryPage({
    @required this.menuCategories,
    @required this.allVisitHistories,
    @required this.vhList,
  });

  final List<MenuCategory> menuCategories;
  final List<VisitHistory> allVisitHistories;
  final List<VisitHistory> vhList;

  @override
  _CategorySummaryPageState createState() => _CategorySummaryPageState();
}

class _CategorySummaryPageState extends State<CategorySummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('CategorySummaryPage')),
    );
  }
}
