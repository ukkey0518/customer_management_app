import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

LineChartBarData customChartBarData({
  @required List<FlSpot> spotsData,
  @required List<Color> colors,
}) {
  return LineChartBarData(
    spots: spotsData,
    isCurved: false,
    colors: colors,
    barWidth: 1,
    isStrokeCapRound: true,
    dotData: FlDotData(show: true),
    belowBarData: BarAreaData(
      show: true,
      colors: colors.map((color) => color.withOpacity(0.3)).toList(),
    ),
  );
}
