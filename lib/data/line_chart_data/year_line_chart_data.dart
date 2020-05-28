import 'package:customermanagementapp/data/line_chart_bar_data/all_visitors_bar_data.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// [年別折れ線グラフデータ]
LineChartData yearLineChartData(List<VisitHistory> vhList) {
  final thisYearData = List<VisitHistory>.from(vhList).where((vh) {
    final thisYear = DateTime.now().year;
    return vh.date.year == thisYear;
  }).toList();

  final maxMonth = List.from(thisYearData)
      .reduce((v, e) => v.date.isAfter(e.date) ? v : e)
      .date
      .month;

  final vhListByMonth = List<List<VisitHistory>>.generate(maxMonth, (index) {
    return thisYearData.where((vh) => vh.date.month == index + 1).toList();
  });

  final allVisitorsSpotsData = List<FlSpot>.generate(maxMonth, (index) {
    final spot = vhListByMonth[index].length * 0.2;
    return FlSpot(index.toDouble(), spot);
  });

  final minValue = allVisitorsSpotsData.reduce((v, e) => v.y <= e.y ? v : e).y;
  final double minY = minValue == 0 ? 0 : minValue - 1;
  final maxValue = allVisitorsSpotsData.reduce((v, e) => v.y >= e.y ? v : e).y;
  final double maxY = maxValue <= 4 ? 4 : maxValue + 1;

  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 1.0,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Colors.lightBlueAccent,
          strokeWidth: value.toInt() % 2 == 0 ? 2 : 1,
        );
      },
      drawHorizontalLine: true,
      verticalInterval: 1.0,
      getDrawingVerticalLine: (_) {
        return FlLine(
          color: Colors.lightBlueAccent,
          strokeWidth: 0.5,
        );
      },
    ),
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(getTooltipItems: (spots) {
        final spot = (spots.single.y / 0.2).floor();
        return [LineTooltipItem('$spot人', TextStyle(color: Colors.black))];
      }),
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
            case 0:
              return '0';
            case 2:
              return '10';
            case 4:
              return '20';
            case 6:
              return '30';
            case 8:
              return '40';
            case 10:
              return '50';
            case 12:
              return '60';
            case 14:
              return '70';
            case 16:
              return '80';
            case 18:
              return '90';
            case 20:
              return '100';
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
    minY: minY,
    maxY: maxY,
    lineBarsData: [
      allVisitorsBarData(spotsData: allVisitorsSpotsData),
    ],
  );
}
