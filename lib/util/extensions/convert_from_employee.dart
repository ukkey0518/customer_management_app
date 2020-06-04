import 'package:customermanagementapp/db/database.dart';

extension ConvertFromEmployee on Employee {
  // [変換：出力用文字列を取得]
  String toPrintText({
    bool showId = false,
    bool showName = true,
  }) {
    final list = List();

    list.add(showId ? 'id: $id' : '');
    list.add(showName ? 'name: $name' : '');

    list.removeWhere((value) => value == '');

    return 'Employee{${list.join(', ')}}';
  }
}
