import 'package:intl/intl.dart';

extension ConvertFromInteger on int {
  // [変換：数値を金額文字列へ]
  String toPriceString() {
    final formatStr = NumberFormat('#,###,###').format(this);
    return '\¥$formatStr';
  }
}
