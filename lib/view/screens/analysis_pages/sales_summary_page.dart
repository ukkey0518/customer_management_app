import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/page_switcher.dart';
import 'package:customermanagementapp/view/screens/analysis_pages/summary_pages/category_summary_page.dart';
import 'package:customermanagementapp/view/screens/analysis_pages/summary_pages/gender_summary_page.dart';
import 'package:customermanagementapp/view/screens/analysis_pages/summary_pages/repeat_summary_page.dart';
import 'package:flutter/material.dart';

class SalesSummaryPage extends StatefulWidget {
  SalesSummaryPage({
    @required this.allVisitHistories,
    @required this.vhList,
    @required this.menuCategories,
  });

  final List<VisitHistory> allVisitHistories;
  final List<VisitHistory> vhList;
  final List<MenuCategory> menuCategories;

  @override
  _SalesSummaryPageState createState() => _SalesSummaryPageState();
}

class _SalesSummaryPageState extends State<SalesSummaryPage> {
  String selectedTab = 'リピート別';

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget> tabsData = {
      'リピート別': RepeatSummaryPage(
        allVisitHistories: widget.allVisitHistories,
        vhList: widget.vhList,
      ),
      '男女別': GenderSummaryPage(
        allVisitHistories: widget.allVisitHistories,
        vhList: widget.vhList,
      ),
      'カテゴリ別': CategorySummaryPage(
        menuCategories: widget.menuCategories,
        vhList: widget.vhList,
      ),
    };

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: PageSwitcher(
              tabsData: tabsData,
              selectedTab: selectedTab,
              onChanged: (value) {
                setState(() {
                  selectedTab = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
