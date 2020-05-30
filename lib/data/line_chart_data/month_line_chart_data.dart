import 'package:customermanagementapp/data/line_chart_bar_data/all_visitors_bar_data.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

LineChartData monthLineChartData(
    List<VisitHistory> vhList, bool showLastYearData) {
  final thisYearSpotList = vhList.toNumOfVisitorsFlSpotList(
      DateTime.now().year, DateTime.now().month);
  final lastYearSpotList = vhList.toNumOfVisitorsFlSpotList(
      DateTime.now().year - 1, DateTime.now().month);

  final double thisYearMinY = thisYearSpotList.getMinY();
  final double thisYearMaxY = thisYearSpotList.getMaxY(10);
  final double lastYearMinY = lastYearSpotList.getMinY();
  final double lastYearMaxY = lastYearSpotList.getMaxY(10);

  List<LineChartBarData> chartData = [
    // 当年データ
    customChartBarData(
      spotsData: thisYearSpotList,
      colors: [const Color(0xffff8c00), const Color(0xffffff00)],
    ),
  ];
  if (showLastYearData) {
    chartData.insert(
      0, // 前年データ
      customChartBarData(
        spotsData: lastYearSpotList,
        colors: [const Color(0xff32cd32), const Color(0xffadff2f)],
      ),
    );
  }

  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 1.0,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Colors.lightBlueAccent,
          strokeWidth: value.toInt() % 5 == 0 ? 1 : 0.3,
        );
      },
      drawHorizontalLine: true,
      verticalInterval: 1.0,
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: Colors.lightBlueAccent,
          strokeWidth:
              value.toInt() == 4 || (value.toInt() - 4) % 5 == 0 ? 1.5 : 0.5,
        );
      },
    ),
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(getTooltipItems: (spots) {
        List<LineTooltipItem> list = List();
        spots.forEach((spot) {
          final num = (spot.y).floor();
          final color = spot.bar.colors[0];
          list.add(LineTooltipItem('$num人', TextStyle(color: color)));
        });
        return list;
      }),
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        textStyle: const TextStyle(color: Color(0xff68737d)),
        getTitles: (value) {
          final num = value.toInt();
          return num == 0 || num == 4 || (num - 4) % 5 == 0 ? '${num + 1}' : '';
        },
        margin: 8,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        textStyle: const TextStyle(color: Color(0xff67727d)),
        getTitles: (value) {
          final num = value.toInt();
          return num == 0 || num % 5 == 0 ? '$num' : '';
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
    maxX: 30,
    minY: thisYearMinY < lastYearMinY ? thisYearMinY : lastYearMinY,
    maxY: thisYearMaxY > lastYearMaxY ? thisYearMaxY : lastYearMaxY,
    lineBarsData: chartData,
  );
}
