import 'dart:ui';

extension ConvertFromColor on Color {
  // [変換：Colorから色番号をintで抽出するメソッド]
  int getColorNumber() {
    var colorStr = this.toString();
    var numStr = colorStr.substring(6, colorStr.length - 1);
    return int.parse(numStr);
  }
}
