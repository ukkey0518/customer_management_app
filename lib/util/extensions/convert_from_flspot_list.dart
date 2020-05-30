import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:fl_chart/fl_chart.dart';

extension ConvertFromFlSpotList on List<FlSpot> {
  // [取得：Yの最大値を取得]
  double getMinY() {
    double minY;

    if (this.isEmpty) {
      return 0.0;
    }

    if (this.length == 1) {
      minY = this.single.y;
    }

    minY = List<FlSpot>.from(this).reduce((v, e) => v.y <= e.y ? v : e).y;

    return minY == 0 ? 0 : minY - 1;
  }

  // [取得：Yの最大値を取得]
  double getMaxY() {
    double maxY;

    if (this.isEmpty) {
      return 4;
    }

    if (this.length == 1) {
      maxY = this.single.y;
    }

    maxY = List<FlSpot>.from(this).reduce((v, e) => v.y >= e.y ? v : e).y;

    return maxY <= 4 ? 4 : maxY + 1;
  }

  // [変換：出力用文字列を取得]
  List<String> toPrintText({String xMode, String yMode}) {
    return List<FlSpot>.from(this)
        .map<String>((spot) => spot.toPrintText(xMode: xMode, yMode: yMode))
        .toList();
  }
}
