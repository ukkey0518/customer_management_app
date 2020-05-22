import 'dart:ui';

extension ConvertFromColor on Color {
  // [変換：Colorから色番号をintで抽出するメソッド]
  int getColorNumber() {
    var colorStr = this.toString();
    var numStr = colorStr.substring(6, colorStr.length - 1);
    return int.parse(numStr);
  }

  // [生成：HEX文字列からColorを取得]
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  // [取得：色からHEX文字列を取得]
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
