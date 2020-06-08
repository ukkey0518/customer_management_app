import 'package:custom_switch/custom_switch.dart';
import 'package:customermanagementapp/data/line_chart_data/month_line_chart_data.dart';
import 'package:customermanagementapp/data/line_chart_data/year_line_chart_data.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/buttons/tab_buttons.dart';
import 'package:customermanagementapp/view/components/transition_graph_parts/line_chart_label.dart';
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

  bool _isShowCompare = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          TabButtons(
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
                    padding:
                        const EdgeInsets.only(top: 16, bottom: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '総来店数',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: _chartLabel(),
                        ),
                        SizedBox(height: 8),
                        AspectRatio(
                          aspectRatio: 1.30,
                          child: LineChart(_chartData(_isShowCompare)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              const Text('前年データと比較'),
                              SizedBox(width: 16),
                              CustomSwitch(
                                activeColor: Theme.of(context).primaryColor,
                                value: _isShowCompare,
                                onChanged: (flag) {
                                  setState(() {
                                    _isShowCompare = flag;
                                  });
                                },
                              ),
                            ],
                          ),
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

  List<Widget> _chartLabel() {
    final List<Widget> list = List();
    var thisYearLabelColor;
    var lastYearLabelColor;

    switch (_selectedMode) {
      case '今年':
        thisYearLabelColor = Colors.pinkAccent;
        lastYearLabelColor = Colors.lightBlueAccent;
        break;
      case '今月':
        thisYearLabelColor = Colors.orangeAccent;
        lastYearLabelColor = Colors.greenAccent;
        break;
    }

    list.add(LineChartLabel(text: '当年データ', color: thisYearLabelColor));
    if (_isShowCompare) {
      list.insert(0, SizedBox(width: 16));
      list.insert(0, LineChartLabel(text: '前年データ', color: lastYearLabelColor));
    }
    return list;
  }

  _chartData(bool showCompareData) {
    switch (_selectedMode) {
      case '今年':
        return yearLineChartData(widget.allVisitHistories, showCompareData);
      case '今月':
        return monthLineChartData(widget.allVisitHistories, showCompareData);
    }
  }
}
