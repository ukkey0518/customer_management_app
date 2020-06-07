import 'package:customermanagementapp/data/enums/date_format_mode.dart';
import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:intl/intl.dart';

extension ConvertFromDateTime on DateTime {
  // [変換：DateTime -> 表示用日付文字列]
  String toFormatStr(DateFormatMode mode) {
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

  // [変換：DateTime -> 指定期間を表す文字列]
  String toPeriodStr(PeriodMode periodMode) {
    var dateStr;
    switch (periodMode) {
      case PeriodMode.YEAR:
        dateStr = '${this.year}年';
        break;
      case PeriodMode.MONTH:
        dateStr = '${this.year}年 ${this.month}月';
        break;
      case PeriodMode.DAY:
        dateStr = '${this.year}年 ${this.month}月 ${this.day}日';
        break;
    }
    return dateStr;
  }

  // [取得：インクリメントした日付を返す]
  DateTime increment(PeriodMode period) {
    DateTime newDate = this;

    switch (period) {
      case PeriodMode.YEAR:
        newDate = DateTime(
          this.year + 1,
          this.month,
          this.day,
          this.hour,
          this.minute,
          this.second,
          this.millisecond,
          this.microsecond,
        );
        break;
      case PeriodMode.MONTH:
        newDate = DateTime(
          this.year,
          this.month + 1,
          this.day,
          this.hour,
          this.minute,
          this.second,
          this.millisecond,
          this.microsecond,
        );
        break;
      case PeriodMode.DAY:
        newDate = DateTime(
          this.year,
          this.month,
          this.day + 1,
          this.hour,
          this.minute,
          this.second,
          this.millisecond,
          this.microsecond,
        );
        break;
    }
    return newDate;
  }

  // [取得：デクリメントした日付を返す]
  DateTime decrement(PeriodMode period) {
    DateTime newDate = this;

    switch (period) {
      case PeriodMode.YEAR:
        newDate = DateTime(
          this.year - 1,
          this.month,
          this.day,
        );
        break;
      case PeriodMode.MONTH:
        newDate = DateTime(
          this.year,
          this.month - 1,
          this.day,
        );
        break;
      case PeriodMode.DAY:
        newDate = DateTime(
          this.year,
          this.month,
          this.day - 1,
        );
        break;
    }
    return newDate;
  }

  // [取得：日付情報だけを取得する]
  DateTime toOnlyDate() {
    if (this == null) return null;
    var onlyDateData = DateTime(this.year, this.month, this.day);
    return onlyDateData;
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
