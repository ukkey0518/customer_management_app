import 'package:customermanagementapp/data/line_chart_data/year_line_chart_data.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/page_select_tabs.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TransitionGraphPage extends StatefulWidget {
  TransitionGraphPage({
    @required this.allVisitHistories,
    @required this.vhList,
  });

  final List<VisitHistory> allVisitHistories;
  final List<VisitHistory> vhList;

  @override
  _TransitionGraphPageState createState() => _TransitionGraphPageState();
}

class _TransitionGraphPageState extends State<TransitionGraphPage> {
  bool showAvg = false;
  List<String> _modeTabs = [
    '今年',
    '今月',
  ];
  String _selectedMode = '今年';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            PageSelectTabs(
              tabs: _modeTabs,
              selectedValue: _selectedMode,
              onChanged: (value) {
                setState(() {
                  _selectedMode = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: AspectRatio(
                  aspectRatio: 1.20,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: LineChart(_chartData()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _chartData() {
    switch (_selectedMode) {
      case '今年':
        return yearLineChartData(widget.allVisitHistories);
      case '今月':
        //TODO
        return LineChartData();
    }
  }
}
