import 'dart:ui';

extension ConvertFromColor on Color {
  // [生成：HEX文字列 -> Colorオブジェクト]
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  // [変換：色番号(ARGB)を取得]
  int toARGB() {
    var colorStr = this.toString();
    var numStr = colorStr.substring(6, colorStr.length - 1);
    return int.parse(numStr);
  }

  // [変換：色番号(HEX文字列)を取得]
  String toHEXStr({bool leadingHashSign = true}) =>
      '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
