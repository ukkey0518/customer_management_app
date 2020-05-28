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
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;
  List<String> _modeTabs = [
    '新規来店数',
    'リピート数',
  ];
  String _selectedMode = '新規来店数';

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
                    child: LineChart(
                      allData(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData allData() {
    return LineChartData(
      gridData: FlGridData(
        // 背景グリッドデータの表示
        show: true,
        // 水平グリッド線の表示
        drawVerticalLine: true,
        // 水平グリッド線の間隔
        horizontalInterval: 1.0,
        // 水平グリッド線のスタイルを取得する関数
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.lightBlueAccent,
            strokeWidth: 1,
          );
        },
        // 垂直グリッド先の表示
        drawHorizontalLine: true,
        // 垂直グリッド線の間隔
        verticalInterval: 1.0,
        // 垂直グリッド線のスタイルを取得する関数
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.lightBlueAccent,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(color: Color(0xff68737d)),
          getTitles: (value) => '${value.toInt() + 1}',
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(color: Color(0xff67727d)),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.lightBlueAccent, width: 1),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(1, 2),
            FlSpot(2, 5),
            FlSpot(3, 3.1),
            FlSpot(4, 4),
            FlSpot(5, 3),
            FlSpot(6, 4),
            FlSpot(7, 5),
            FlSpot(8, 3.1),
            FlSpot(9, 4),
            FlSpot(10, 3),
            FlSpot(11, 4),
          ],
          isCurved: false,
          colors: gradientColors,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
