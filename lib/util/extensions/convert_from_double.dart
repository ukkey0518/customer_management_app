import 'package:intl/intl.dart';

extension ConvertFromDouble on double {
  // [変換：数値を金額文字列へ]
  String toPriceString(int asFixed) {
    final num = double.parse(this.toStringAsFixed(asFixed));
    final formatStr = NumberFormat('#,###,###.######').format(num);
    return '\¥$formatStr';
  }
}
