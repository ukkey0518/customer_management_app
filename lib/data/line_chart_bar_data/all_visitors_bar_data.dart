import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

LineChartBarData allVisitorsBarData({@required List<FlSpot> spotsData}) {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  return LineChartBarData(
    spots: spotsData,
    isCurved: false,
    colors: gradientColors,
    barWidth: 1,
    isStrokeCapRound: true,
    dotData: FlDotData(show: true),
    belowBarData: BarAreaData(
      show: true,
      colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
    ),
  );
}
