import 'package:customermanagementapp/data/date_format_mode.dart';
import 'package:intl/intl.dart';

extension ConvertFromDateTime on DateTime {
  // [変換：DateTime -> 表示用日付文字列]
  String toFormatString(DateFormatMode mode) {
    var dateStr;
    switch (mode) {
      case DateFormatMode.FULL:
        dateStr = DateFormat('yyyy年 M月 d日').format(this);
        break;
      case DateFormatMode.FULL_WITH_DAY_OF_WEEK:
        dateStr = DateFormat('yyyy年 M月 d日 (E)').format(this);
        break;
      case DateFormatMode.MEDIUM:
        dateStr = DateFormat('yyyy/M/d').format(this);
        break;
      case DateFormatMode.MEDIUM_WITH_DAY_OF_WEEK:
        dateStr = DateFormat('yyyy/M/d(E)').format(this);
        break;
      case DateFormatMode.SHORT:
        dateStr = DateFormat('M月 d日').format(this);
        break;
      case DateFormatMode.SHORT_WITH_DAY_OF_WEEK:
        dateStr = DateFormat('M月 d日 (E)').format(this);
        break;
    }
    return dateStr;
  }

  // [変換：誕生日から年齢を取得する]
  int toAge() {
    // 引数がnullの場合はnullを返す
    if (this == null) return null;
    var diffDays = DateTime.now().difference(this).inDays;
    var age = (diffDays / 365).floor();
    return age;
  }
}
