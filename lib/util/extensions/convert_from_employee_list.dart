import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';

extension ConvertFromEmployeeList on List<Employee> {
  // [取得：IDから従業員データを取得]
  getEmployee(int id) {
    if (this.isEmpty) return null;
    return this.singleWhere((em) => em.id == id);
  }

  // [変換：出力用文字列を取得]
  String toPrintText({
    bool onlyLength = false,
    bool showId = false,
    bool showName = true,
  }) {
    var str;

    if (onlyLength) {
      str = 'length: ${this.length}';
    } else {
      str = List<Employee>.from(this).map<String>(
        (e) {
          return e.toPrintText(
            showId: showId,
            showName: showName,
          );
        },
      ).join(', ');
    }

    return 'EmployeeList{$str}';
  }
}
