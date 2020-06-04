import 'package:customermanagementapp/data/enums/date_format_mode.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';

extension ConvertFromCustomer on Customer {
  // [変換：出力用文字列を取得]
  String toPrintText({
    bool showId = false,
    bool showName = true,
    bool showNameReading = false,
    bool showGender = false,
    bool showBirth = false,
    bool showVisitReason = false,
  }) {
    final list = List();

    list.add(showId ? 'id: $id' : '');
    list.add(showName ? 'name: $name' : '');
    list.add(showNameReading ? 'nameR: $nameReading' : '');
    list.add(showGender ? 'gender: ${isGenderFemale ? 'F' : 'M'}' : '');
    list.add(
        showBirth ? 'birth: ${birth.toFormatStr(DateFormatMode.MEDIUM)}' : '');
    var vrSubText = visitReason.substring(0, 5);
    list.add(showVisitReason
        ? 'vr: ${vrSubText + '${vrSubText != visitReason ? '…' : ''}'}'
        : '');

    list.removeWhere((value) => value == '');

    return 'Customer{${list.join(', ')}}';
  }
}
