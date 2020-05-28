import 'package:customermanagementapp/data/line_chart_data/year_line_chart_data.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/page_select_tabs.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TransitionGraphPage extends StatefulWidget {
  TransitionGraphPage({
    @required this.allVisitHistories,
  });

  final List<VisitHistory> allVisitHistories;

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
    return Padding(
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
          Expanded(
            child: ListView(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '総来店数',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 8),
                        AspectRatio(
                          aspectRatio: 1.20,
                          child: LineChart(_chartData()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
