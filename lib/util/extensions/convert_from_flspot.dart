import 'package:fl_chart/fl_chart.dart';

extension ConvertFromFlSpot on FlSpot {
  // [変換：出力用文字列を取得]
  String toPrintText({String xMode, String yMode}) {
    if (yMode == null) {
      throw Exception('yModeが未指定');
    }

    var xText = '$x';
    var yText = '$y';

    switch (xMode) {
      case 'month':
        xText = '${(x + 1).floor()}月';
        break;
      case 'day':
        xText = '${(x + 1).floor()}日';
        break;
    }

    switch (yMode) {
      case 'nov':
        yText = '${(y / 0.2).floor()}人';
        break;
    }
    return 'FlSpot{x:$xText, y:$yText}';
  }
}
